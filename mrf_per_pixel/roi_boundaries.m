function [ slice_idx_start, slice_idx_end] = roi_boundaries( itk_volume )
%ROI_BOUNDARIES Determines the slices in which a determined ROI can in
%painted
%   - itk_volume: binary volume, representing a mask of an specific ROI
% ------
% Author: Elizabeth Vargas
% E-mail: EVargas@tmvse.com
% Created: 29-04-2015, using MATLAB 8.4.0.150421 (R2014b)
% Modified: 29-04-2015
% Copyright 2015 Toshiba Medical Visualization Systems Europe (TMVS)

    % number of slices
    NR_SLICES = size(itk_volume,3);
    % array of slices indexes
    slice_idx = zeros(1000,1);
    idx = 1;

    for i=1:NR_SLICES
        I = itk_volume(:,:,i);
        if any(I(:)~=0)
            slice_idx(idx) = i;
            idx = idx + 1;
        end
    end
    
    % remove the non-used positions
    slice_idx = slice_idx(1:idx-1);
    % select boundary indexes
    slice_idx_start = min(slice_idx);
    slice_idx_end = max(slice_idx);
end

