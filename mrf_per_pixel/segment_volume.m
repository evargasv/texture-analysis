function [seg_volume] = segment_volume(itk_volume,dict_textons,nbr_size,DST_THOLD,NR_CLUSTERS)
%SEGMENT_VOLUME Segments an ITK volume into 5 different classes: liver,
%lung, spleen, kidneys and backgroud
%   - itk_volume: ITK volume to be segmented
%   - dict_textons: dictionary of textons
%   - nbr_size: size of the neighbourhood
%   - DST_THOLD: threshold of the distance between the texton and the
%     dictionary of textons that determines whether a pixels belongs to the
%     background or not
%
% ------
% Author: Elizabeth Vargas
% E-mail: EVargas@tmvse.com
% Created: 09-04-2015, using MATLAB 8.4.0.150421 (R2014b)
% Modified: 16-04-2015
% Copyright 2015 Toshiba Medical Visualization Systems Europe (TMVS)

    % number of slices
    nr_slices = size(itk_volume,3);
    % slice dimensions
    [ROWS,COLS] = size(itk_volume(:,:,1));
    % initialise segmented volume
    C = floor(nbr_size/2);
    seg_volume = zeros(ROWS,COLS,nr_slices);
    
    for i=1:nr_slices
        
        slice = itk_volume(:,:,i);
        % extract textons
        [textons,central_px] = neighbours_extraction_slice( slice, nbr_size );
        % number of textons
        nr_px = size(textons,1);
        
        % pixels indexes that are not considered background because of
        % their intensity values
        idx_fgd = find(central_px>-900);
        
        % array of labels
        label_px = zeros(nr_px,1);
        % label each pixel
        for j=idx_fgd'
%             label_px(j,:) = label_pixel_segmentation( dict_textons, textons(j,:),DST_THOLD,NR_CLUSTERS);
            label_px(j,:) = majority_voting_scheme( dict_textons, textons(j,:),DST_THOLD,NR_CLUSTERS);
        end
        
        % resize label_px
        seg_slice = reshape(label_px,(ROWS - 2*C),(COLS - 2*C));
        % assign segmented slice to volume
        seg_volume(1+C:ROWS-C,1+C:COLS-C,i) = seg_slice';
        % apply morphology
%         seg_volume(1+C:ROWS-C,1+C:COLS-C,i) = slice_morphology( seg_slice' );
    end
end

