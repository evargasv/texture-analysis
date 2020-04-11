function dicom2itk_resized( PATIENT_ID,VOL_ID,CLASS_ID,ERO_SIZE)
%DICOM2ITK_RESIZED Resizes a set of DICOM volumes and converts them into
%ITK format
%   - PATIENT_ID: Cell-array of patient numbers
%   - VOL_ID: Cell-array of volumes numbers
%   - CLASS_ID: Cell-array of class names
%
% ------
% Author: Elizabeth Vargas
% E-mail: EVargas@tmvse.com
% Created: 09-04-2015, using MATLAB 8.4.0.150421 (R2014b)
% Modified: 13-04-2015
% Copyright 2015 Toshiba Medical Visualization Systems Europe (TMVS)

    % number of patients
    NR_PATIENTS = size(PATIENT_ID,2);
    
    % number of classes
    NR_CLASS = size(CLASS_ID,2);

    for i=1:NR_PATIENTS 

        % subject id
        sbj_id = PATIENT_ID{i};
        % cell array of noises id
        noises_id = VOL_ID{i,:};
        % number of noises
        NR_NOISE = size(noises_id,2);
        
        % noise id
        noise = noises_id{1};

        % Iterate through each noise
        for j=1:1%NR_NOISE

            % noise id
            noise = noises_id{j};
            % load dicom volume
            vol_name = strcat('C:\MyDicomLibrary\',sbj_id,'\',sbj_id,'_*_',noise,'_*.dcm');
            [dicom_volume,~,voxelSizes] = dicomreadvolume(vol_name);
            
            % original size of the volume
            [X,Y,Z] = size(dicom_volume);
            % size to convert
            sizes = round([X/2,Y/2,Z/4]);
            % resize the volume
            resized_volume = imresize3d(dicom_volume,sizes,'bicubic');
            % save the resized volume as itk file
            write_itk(resized_volume, strcat('C:\MyResizedItkLibrary\',sbj_id,'\',sbj_id,'_',noise),'ElementSpacing',voxelSizes);
        end
        
        % segmented volume, including all the ROI's
        sgm_vol = zeros(sizes);

        % Iterate through each ROI
        for k=1:NR_CLASS
            % class id
            class = CLASS_ID{k};

            % subject '04636' has no spleen
            if strcmp(sbj_id,'04636') && strcmp(class,'Spleen'); continue; end;

            % if the class is kidney
            if k == 1
                % left kidney
                [lk_mask,~] = ReadVyNamedSelections(strcat('C:\rois\',sbj_id,'\LKidney.txt'));
                % right kidney
                [rk_mask,~] = ReadVyNamedSelections(strcat('C:\rois\',sbj_id,'\RKidney.txt'));
                % kidney mask
                mask = lk_mask + rk_mask;
            else
                % load roi mask
                roi_name = strcat('C:\rois\',sbj_id,'\',class,'.txt');
                [mask,~] = ReadVyNamedSelections(roi_name);
            end
            
            %erode lung mask
            if k == 3
                mask = erode_mask(mask,ERO_SIZE);
            end
            
            % resize the mask
            resized_mask = imresize3d(mask,sizes,'bicubic');
            % save the resized mask as itk file
            write_itk(round(resized_mask), strcat('C:\MyResizedItkLibrary\',sbj_id,'\',class),'ElementSpacing',voxelSizes);
            resized_mask = round(resized_mask) .* k;
            % add new ROI to the segmented volume
            sgm_vol = sgm_vol + resized_mask;
        end   
        
        % save the resized mask as itk file
        write_itk(sgm_vol, strcat('C:\MyResizedItkLibrary\',sbj_id,'\ROIs'),'ElementSpacing',voxelSizes);
    end
    
end
