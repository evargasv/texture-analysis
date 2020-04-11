function [textons,central_px,idx_tx]=nhood_extract_erosion(roi,ero_mask,nbr_size)
%NHOOD_EXTRACT_EROSION Extraction of the N^2 - 1 neighbours in a N by N
%neighbourhood (central pixel excluded). Only intensities of the pixels
%that belongs to the foreground, i.e. the mask, are included
%   - roi: patch of the region of interest
%   - ero_mask: binary image representing an eroded mask
%   - nbr_size: neighbourhood size
%
% ------
% Author: Elizabeth Vargas
% E-mail: EVargas@tmvse.com
% Created: 12-03-2015, using MATLAB 8.4.0.150421 (R2014b)
% Modified: 16-03-2015
% Copyright 2015 Toshiba Medical Visualization Systems Europe (TMVS)

    % image size
    [ROWS, COLS] = size(roi);
    % central pixel
    C = floor(nbr_size/2);
    % initialise textons vector
    nRowsOut = (ROWS - 2*C) * (COLS - 2*C);
    textons = zeros(nRowsOut, nbr_size^2);    
    outputRow = 0;
    
    idx_tx = [];
    
    for i = 1 + C : ROWS - C
        for j = 1 + C : COLS - C
            % pixels in the roi's neighbourhood
            t = roi(i-C:i+C,j-C:j+C);
            
            % verify that the pixels on the neighbourhood belongs to the
            % roi
            if ero_mask(i,j) == 1
                outputRow = outputRow + 1;
                textons(outputRow,:) = t(:);
                
                % TEST: use this variable to return the indexes of th
                % epixels that are indeed used for the textons
                % representation
                idx_tx = [idx_tx;[i,j]];
            end
        end
    end
   
    % cut the excess
    textons = textons(1:outputRow,:);
    
    % central column
    c_idx = ceil(nbr_size^2 / 2);
    central_px = textons(:,c_idx);
    textons(:,c_idx) = [];

end

