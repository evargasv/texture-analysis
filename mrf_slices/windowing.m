function [ w_low, w_high ] = windowing( class_textons, NBR_SIZE )
%WINDOWING This function determines the minimum and the maximum value of
%the region of interest of an specific organ, according to some predefined
%masks
%   - organ_patches: cell-array containing the images patches corresponding
%     to mask bounding boxes
%
% ------
% Author: Elizabeth Vargas
% E-mail: EVargas@tmvse.com
% Created: 05-03-2015, using MATLAB 8.4.0.150421 (R2014b)
% Modified: 24-03-2015
% Copyright 2015 Toshiba Medical Visualization Systems Europe (TMVS)

    % number of dicom volumnes 
    nr_dicom_vl = size(class_textons,1);
    % intensity values of the organ
    organ_values = zeros(10000000,NBR_SIZE*NBR_SIZE);
    organ_val_idx = 1;
    
    for i=1:nr_dicom_vl
        
        % patches of the i-volume
        [vl_slices_tx,vl_slices_ct] = class_textons{i,:};
        nr_slices = size(vl_slices_tx,1);
        
        for j=1:nr_slices
            % extract intensities from the slice
            textons = vl_slices_tx{j};
            central_px = vl_slices_ct{j};
            % concatenate intensities
            int_organ = [textons,central_px];
            
            nr_int = size(int_organ,1);
            organ_values(organ_val_idx:organ_val_idx+nr_int-1,:) = int_organ;
            organ_val_idx = organ_val_idx + nr_int;
        end
    end
    
    organ_values = organ_values(1:organ_val_idx-1,:);
    w_low = min(organ_values(:));
    w_high = max(organ_values(:));
    
end

