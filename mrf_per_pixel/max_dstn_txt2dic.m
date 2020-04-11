function [max_dstn] = max_dstn_txt2dic( textons_img,dict_textons )
%MAX_DSTN_TXT2DIC Calculates the maximum distance of the textons per slice
%to the dictionary of textons
%   - textons_img: textons of the slice
%   - dict_textons: textons dictionary
%
% ------
% Author: Elizabeth Vargas
% E-mail: EVargas@tmvse.com
% Created: 16-04-2015, using MATLAB 8.4.0.150421 (R2014b)
% Modified: 16-04-2015
% Copyright 2015 Toshiba Medical Visualization Systems Europe (TMVS)

    % number of pixels
    nr_px = size(textons_img,1);
    % array of labels
    dst_px = zeros(nr_px,1);
    
    % find the distance of each pixel
    for i=1:nr_px
        [~,dst_px(i,:)] = label_pixel( dict_textons, textons_img(i,:) );
    end    
    
    % maximum distance of a texton to the dictionary
    max_dstn = max(dst_px);

end

