function [ textons, central_px ] = neighbours_extraction_slice( img, nbr_size )
%NEIGHBOURS_EXTRACTION Extraction of the N^2 - 1 neighbours in a N by N
%neighbourhood (central pixel excluded)
%   - img: 2D input image
%   - nbr_size: neighbourhood size
%
% ------
% Author: Elizabeth Vargas
% E-mail: EVargas@tmvse.com
% Created: 09-04-2015, using MATLAB 8.4.0.150421 (R2014b)
% Modified: 09-04-2015
% Copyright 2015 Toshiba Medical Visualization Systems Europe (TMVS)

    % image size
    [ROWS, COLS] = size(img);
    % central pixel
    C = floor(nbr_size/2);
    % initialise textons vector
    nRowsOut = (ROWS - 2*C) * (COLS - 2*C);
    textons = zeros(nRowsOut, nbr_size^2);    
    outputRow = 1;
    
    for i = 1 + C : ROWS - C
        for j = 1 + C : COLS - C
            % pixels in the neighbourhood
            t = img(i-C:i+C,j-C:j+C);
            textons(outputRow,:) = t(:);
            outputRow = outputRow + 1;
        end
    end
   
    % central column
    c_idx = ceil(nbr_size^2 / 2);
    central_px = textons(:,c_idx);
    textons(:,c_idx) = [];
end
