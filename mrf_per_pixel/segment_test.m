function segment_test(TEST_IDX,PATIENT_ID,VOL_ID,NBR_SIZE,DST_THOLD,dictionary_textons,NR_CLUSTERS)
%SEGMENT_TEST Invokes the function that segments a volume for each of the
%test subjects and saves te results into files
%   - TEST_IDX: index of the test volumes
%   - PATIENT_ID: cell-array containing the patients identifiers
%   - VOL_ID: cell-array of the volumes numbers
%   - NBR_SIZE: size of the neighbourhood
%   - DST_THOLD: threshold that indicates the minimum distance between a
%     texton and the dictionary to really belong into any class. When the
%     threshold is not satisfied, the texton is considered background.
%   - dictionary_textons: textons dictionary
% ------
% Author: Elizabeth Vargas
% E-mail: EVargas@tmvse.com
% Created: 29-04-2015, using MATLAB 8.4.0.150421 (R2014b)
% Modified: 29-04-2015
% Copyright 2015 Toshiba Medical Visualization Systems Europe (TMVS)

    % two volumes for test
    for i=TEST_IDX

        % subject id
        sbj_id = PATIENT_ID{i};
        % cell array of noises id
        noises_id = VOL_ID{i,:};
        % number of noises
        NR_NOISE = size(noises_id,2);

        for j=1:NR_NOISE
            
            sprintf('segmenting: %s',sbj_id)
            
            % noise id
            noise = noises_id{j};
            % load dicom volume
            vol_name = strcat('C:\MyResizedItkLibrary\',sbj_id,'\',sbj_id,'_',noise);           
            [itk_volume,~] = read_itk(vol_name);
            % segment volume
            seg_volume = segment_volume(itk_volume,dictionary_textons,NBR_SIZE,DST_THOLD,NR_CLUSTERS);
            
            vol_size = size(seg_volume);

            % KIDNEY: segmented
            kidney_seg = (seg_volume(:) == 1);
            kidney_seg = reshape(kidney_seg,vol_size);
            file_name = strcat('C:\MyResizedItkLibrary\',sbj_id,'\seg_Kidney');
            write_itk(int16(kidney_seg), file_name);

            % LIVER: segmented
            liver_seg = (seg_volume(:) == 2);
            liver_seg = reshape(liver_seg,vol_size);
            file_name = strcat('C:\MyResizedItkLibrary\',sbj_id,'\seg_Liver');
            write_itk(int16(liver_seg), file_name);

            % LUNG: segmented
            lung_seg = (seg_volume(:) == 3);
            lung_seg = reshape(lung_seg,vol_size);
            file_name = strcat('C:\MyResizedItkLibrary\',sbj_id,'\seg_Lung');
            write_itk(int16(lung_seg), file_name);

            % SPLEEN: segmented
            spleen_seg = (seg_volume(:) == 4);
            spleen_seg = reshape(spleen_seg,vol_size);
            file_name = strcat('C:\MyResizedItkLibrary\',sbj_id,'\seg_Spleen');
            write_itk(int16(spleen_seg), file_name);

            % Image with all the regions segmented
            file_name = strcat('C:\MyResizedItkLibrary\',sbj_id,'\init_seg');
            write_itk(seg_volume, file_name);
        end
    end

end

