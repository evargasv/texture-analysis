function [ ero_mask ] = erode_mask( mask, ERO_SIZE )
%ERODE_MASK Erodes each slice of a mask volume
%   - mask: 3D mask
%   - ERO_SIZE: size of the erosion window
% ------
% Author: Elizabeth Vargas
% E-mail: EVargas@tmvse.com
% Created: 30-04-2015, using MATLAB 8.4.0.150421 (R2014b)
% Modified: 30-04-2015
% Copyright 2015 Toshiba Medical Visualization Systems Europe (TMVS)

    [ROWS,COLS,SLICES] = size(mask);
    ero_mask = zeros(ROWS,COLS,SLICES);
    
    for i=1:SLICES
        
        I = mask(:,:,i);
        se = strel('square',ERO_SIZE);        
        ero_mask(:,:,i) = imerode(I,se);
        
    end
    
end

