function [ rois_patches ] = extract_rois( dicom_vol, mask_vol )
%EXTRACT_ROIS This function extracts the region of interets from a DICOM 
%volume, based on some predefined masks along each slice of the volume
%   - dicom_vol: 3D matrix representing a DICOM image
%   - mask_vol: 3D matrix representing a binary mask
%
% ------
% Author: Elizabeth Vargas
% E-mail: EVargas@tmvse.com
% Created: 04-03-2015, using MATLAB 8.4.0.150421 (R2014b)
% Modified: 24-03-2015
% Copyright 2015 Toshiba Medical Visualization Systems Europe (TMVS)

    % dimension of the dicom volume
    [~,~,SLICES] = size(dicom_vol);
    % roi's patches
    rois_patches = {};
        
    for i=1:SLICES
        % dicom slice
        dicom_slice =dicom_vol(:,:,i);
        % mask slice
        mask_slice = mask_vol(:,:,i);        
        % extract the roi's information from the slice
        rois_info = rois_slice(dicom_slice,mask_slice,i);   
        % add roi's to the cell array
        rois_patches = [rois_patches; rois_info];
    end

end

