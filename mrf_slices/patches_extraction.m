function [patches_class] = patches_extraction(PATIENT_ID,VOL_ID,CLASS_ID)
%PATCHES_EXTRACTION Extracts the patches, i.e. bounding box of the region
%of interests based on a predefined mask. The output is a data structure
%named patches_class which contains at each position the slice patch, the
%original mask, the slice number and the coordinates of the bounding box.
%This is organized by classes, which at the same time are splited by
%patient.
%   - PATIENT_ID: cell-array of strings containing the patient numbers
%   - VOL_ID: cell-array of strings containing the noise label
%   - CLASS_ID: cell-array of strings containing the class names
%
% ------
% Author: Elizabeth Vargas
% E-mail: EVargas@tmvse.com
% Created: 07-03-2015, using MATLAB 8.4.0.150421 (R2014b)
% Modified: 01-04-2015
% Copyright 2015 Toshiba Medical Visualization Systems Europe (TMVS)

    % initialise cell-array
    patches_class = cell(4,1);
    patches_class{1,1} = {};
    patches_class{2,1} = {};
    patches_class{3,1} = {};
    patches_class{4,1} = {};
    
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

        for j=1:NR_NOISE

            % noise id
            noise = noises_id{j};
            % load dicom volume
            vol_name = strcat('C:\MyDicomLibrary\',sbj_id,'\',sbj_id,'_*_',noise,'_*.dcm');
            [dicom_volume,~,~] = dicomreadvolume(vol_name);

            for k=1:NR_CLASS
                % class id
                class = CLASS_ID{k};

                % subject '04636' has no spleen
                if strcmp(sbj_id,'04636') && strcmp(class,'Spleen'); continue; end;

                % load roi mask
                roi_name = strcat('C:\rois_old\',sbj_id,'\',class,'.txt');
                [mask,~] = ReadVyNamedSelections(roi_name);
                  
                % roi's patches for i-person with the j-noise belonging to
                % k-class
                rois_patches = extract_rois( dicom_volume, mask );
                % concatenate roi information on the corresponding class cell
                patches_class{k,:} = [patches_class{k,:}; {rois_patches}];
            end        
        end
    end
end

