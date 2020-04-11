function [ img_close ] = slice_morphology( img )
%SLICE_MORPHOLOGY Summary of this function goes here
%   Detailed explanation goes here
% ------
% Author: Elizabeth Vargas
% E-mail: EVargas@tmvse.com
% Created: 04-05-2015, using MATLAB 8.4.0.150421 (R2014b)
% Modified: 04-05-2015
% Copyright 2015 Toshiba Medical Visualization Systems Europe (TMVS)

    se = strel('square',3);        
    img_ero = imerode(img,se);

%     img_ero = img;
    
    se = strel('square',3); 
    img_close = imclose(img_ero,se);
    
end

