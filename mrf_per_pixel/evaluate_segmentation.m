function evaluate_segmentation( PATIENT_ID, CLASS_ID, slices_gt )
%EVALUATE_SEGMENTATION Calculates segmentation metrics for the test
%patients and save the results on a txt file
%   - PATIENT_ID: cell-array of test patients identifiers
%   - CLASS_ID: cell-array of classes names
%   - slices_gt: indices of the slices that contains ROI information
%
% ------
% Author: Elizabeth Vargas
% E-mail: EVargas@tmvse.com
% Created: 29-04-2015, using MATLAB 8.4.0.150421 (R2014b)
% Modified: 29-04-2015
% Copyright 2015 Toshiba Medical Visualization Systems Europe (TMVS)

    f = fopen('results.out','w');

    % iterate through each patient
    for i=1:size(PATIENT_ID,2)
        % iterate through each class
        for j=1:size(CLASS_ID,2)
            
            if strcmp(PATIENT_ID{i},'04636') && strcmp(CLASS_ID{j},'Spleen')
                continue;
            end
            
            seg_fname = strcat('C:\MyResizedItkLibrary\',PATIENT_ID{i},'\seg_',CLASS_ID{j});
            gt_fname = strcat('C:\MyResizedItkLibrary\',PATIENT_ID{i},'\',CLASS_ID{j});
            [seg,~] = read_itk(seg_fname);
            [gt,~] = read_itk(gt_fname);
            ini_idx = slices_gt(i,j,1);
            end_idx = slices_gt(i,j,2);
            [accuracy,precision,recall,dice]=segmentation_metrics(seg(:,:,ini_idx:end_idx),gt(:,:,ini_idx:end_idx));
            
            fprintf(f,'%0.4f\n',dice);
        end
        fprintf(f,'\n');
    end
    fclose(f);
end

