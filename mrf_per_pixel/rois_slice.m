function [ rois_info ] = rois_slice( dicom_slice,mask_slice,slice_nr )
%ROIS_SLICE Extracts the bounding box of a DICOM slice according to a
%predefined mask
%   - dicom_slice: 2D image representing an slice of the DICOM volume
%   - mask_slice: 2D image representing an slice of the binary mask
%   - slice_nr: slice number
%
% ------
% Author: Elizabeth Vargas
% E-mail: EVargas@tmvse.com
% Created: 09-04-2015, using MATLAB 8.4.0.150421 (R2014b)
% Modified: 09-04-2015
% Copyright 2015 Toshiba Medical Visualization Systems Europe (TMVS)

    bw_mask_slice = im2bw(mask_slice, 0.5);

    % check that the mask has at least one roi
    if ismember(1,bw_mask_slice)
        
        % number of pixels on the mask
        px_mask = size(bw_mask_slice(bw_mask_slice(:) == 1),1);
        
        % the mask is big enough
        if px_mask > 16
            
            % extract statistics
            stats = regionprops(bw_mask_slice,'BoundingBox');
            % extract bounding boxes
            bound_bx = stats.BoundingBox;
            % number of bounding boxes
            nr_bound_bx = size(bound_bx,1);
            % preallocate memory for the cell array
            rois_info = cell(nr_bound_bx,4);

            for i=1:nr_bound_bx

                % round bounding box parameters
                bound_bx = round(bound_bx);
                % bounding box parameters
                bx_init_col = bound_bx(i,1);
                bx_init_row = bound_bx(i,2);
                bx_width = bound_bx(i,3);
                bx_height = bound_bx(i,4);
                bx_end_row = bx_init_row + bx_height - 1;
                bx_end_col = bx_init_col+bx_width - 1;

                % extract the mask portion (bounding box rectangle)
                mask = bw_mask_slice(bx_init_row:bx_end_row,bx_init_col:bx_end_col);
                patch = dicom_slice(bx_init_row:bx_end_row,bx_init_col:bx_end_col);

                % add roi information to the cell array
                rois_info(i,:) = {patch,mask,slice_nr,bound_bx};
            end
        % in case the region is too small
        else
            rois_info = {};
        end     
    % in case there are not roi's, return an empty cell array  
    else
        rois_info = {};
    end

end

