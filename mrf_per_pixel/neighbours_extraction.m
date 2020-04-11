function [ textons, central_px, idx_tx ] = neighbours_extraction( roi, mask, nbr_size )
%NEIGHBOURS_EXTRACTION Extraction of the N^2 - 1 neighbours in a N by N
%neighbourhood (central pixel excluded). A 2D mask is used to validate that
%pixels belonging to the background are not considered and instead only the
%pixels corresponding to the region of interest are taking into account.
%   - roi: 2D input region of interest
%   - mask: 2D input mask
%   - nbr_size: neighbourhood size
%
% ------
% Author: Elizabeth Vargas
% E-mail: EVargas@tmvse.com
% Created: 03-03-2015, using MATLAB 8.4.0.150421 (R2014b)
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
            % pixels in the mask's neighbourhood
            px_mask = mask(i-C:i+C,j-C:j+C);
            
            % verify that the pixels on the neighbourhood belongs to the
            % roi
            if ~ismember(0,px_mask)
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
