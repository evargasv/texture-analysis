function [textons_class]=textons_extraction(patches_class,CLASS_ID,NBR_SIZE,VOL_IDX,VOL_IDX_SPLEEN)
%TEXTONS_EXTRACTION Extract the textons from each slice and store them on a
%new data structure called textons_class
%   - patches_class: cell-array containing patches of the regions of
%   interest
%   - CLASS_ID: cell-array containing the id of name of the classes
%   - NBR_SIZE: size of the neighbourhood used to extract the textons
%
% ------
% Author: Elizabeth Vargas
% E-mail: EVargas@tmvse.com
% Created: 17-03-2015, using MATLAB 8.4.0.150421 (R2014b)
% Modified: 30-03-2015
% Copyright 2015 Toshiba Medical Visualization Systems Europe (TMVS)

    % number of classes
    NBR_CLASSES = size(CLASS_ID,2);
    % with of the neighbourhood
    NBR_WIDTH = floor(NBR_SIZE/2);

    % textons per class
    textons_class = cell(NBR_CLASSES,1);

    % for each class
    for i=1:NBR_CLASSES 

        % patches of the i-th class
        class = patches_class{i};
        % number of volumes
        if i==4; VOL_IDX = VOL_IDX_SPLEEN;end;
        % textons per volume
        textons_vol = cell(size(VOL_IDX,2),2);
        textons_vol_idx = 1;

        % for each volume
        for j=VOL_IDX

            % extract the roi patches from the volume
            patches_vol = class{j};
            sprintf('class: %s, volume-id: %d, nr-slices:%d',CLASS_ID{i},j,size(patches_vol,1))

            % for each slice of the volume
            for k=1:size(patches_vol,1)

                roi = patches_vol{k,1};
                mask = patches_vol{k,2};
                
                if (size(roi,1) < 3) | (size(roi,2) < 3)
                    continue;
                end

                %erode mask using an structuring element of the size of the
                %neighbourhodd
                se = strel('square', NBR_SIZE);
                ero_mask = imerode(mask,se);
                
                %padding the edges of the bounding box
                [ROWS,COLS]= size(ero_mask);
                
                % verify that the padding is not bigger than the roi
                if ( (NBR_WIDTH-1) < ROWS ) && ( (NBR_WIDTH-1) < COLS )
                    % top rows
                    ero_mask(1:NBR_WIDTH,:) = 0;
                    % left columns
                    ero_mask(:,1:NBR_WIDTH) = 0;
                    % bottom rows
                    ero_mask(ROWS-(NBR_WIDTH-1):ROWS,:) = 0;
                    % right columns
                    ero_mask(:,COLS-(NBR_WIDTH-1):COLS) = 0;
                end

                % extract using eroded mask
                [textons,central_px]=nhood_extract_erosion(roi,ero_mask,NBR_SIZE);
                textons_vol{textons_vol_idx,1} = [textons_vol{textons_vol_idx,1}; {textons}];
                textons_vol{textons_vol_idx,2} = [textons_vol{textons_vol_idx,2}; {central_px}]; 
            end
            % increment index
            textons_vol_idx = textons_vol_idx + 1;
        end  
        % concatenate to textons per class cell array
        textons_class{i} = [textons_class{i}; textons_vol];
    end

end

