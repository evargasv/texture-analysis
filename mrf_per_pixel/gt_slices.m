function [ slices_gt ] = gt_slices( PATIENT_ID, CLASS_ID )
%GT_SLICES Extract the slices that contains ROI information
%   - PATIENT_ID: cell-array of test patients identifiers
%   - CLASS_ID: cell-array of class names
% ------
% Author: Elizabeth Vargas
% E-mail: EVargas@tmvse.com
% Created: 29-04-2015, using MATLAB 8.4.0.150421 (R2014b)
% Modified: 30-04-2015
% Copyright 2015 Toshiba Medical Visualization Systems Europe (TMVS)

    % initialise 3D array
    slices_gt = zeros(size(PATIENT_ID,2),size(CLASS_ID,2),2);

    % iterate through test patients
    for i=1:size(PATIENT_ID,2)
        % iterate through each class
        for j=1:size(CLASS_ID,2)
        
            if strcmp(PATIENT_ID{i},'04636') && strcmp(CLASS_ID{j},'Spleen')
                continue;
            end
            
            % file name
            fname = strcat('C:\MyResizedItkLibrary\',PATIENT_ID{i},'\',CLASS_ID{j},'.mhd');
            % read volume
            [itk_volume,~] = read_itk( fname );
            % extract roi
            [ slice_idx_start, slice_idx_end] =roi_boundaries( itk_volume );
            % assign values to the array
            slices_gt(i,j,1) = slice_idx_start;
            slices_gt(i,j,2) = slice_idx_end;
            
        end 
    end
    
end

