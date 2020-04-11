function [ hist_2D ] = generate_2D_histogram( textons_img,central_px,dict_textons,hist_edges )
%GENERATE_2D_HISTOGRAM Creates a 2D histogram as a model of the joint 
%distribution of textures w.r.t. the center pixel. 
%   - textons_img: array of R by N^2-1 representing the image textons
%   - central_px: array of R by 1 representing the centers associated to
%     each texton
%   - dict_textons: array of M by N^2-1 representing a dictionary of
%     textons
%   - hist_edges: edges of the histogram
%
% ------
% Author: Elizabeth Vargas
% E-mail: EVargas@tmvse.com
% Created: 16-03-2015, using MATLAB 8.4.0.150421 (R2014b)
% Modified: 20-03-2015
% Copyright 2015 Toshiba Medical Visualization Systems Europe (TMVS)

    % number of pixels
    nr_px = size(textons_img,1);
    % number of bins per center pixel histogram
    bins = size(hist_edges,2);
    % dictionary size
    dict_size = size(dict_textons,1);
    % array of labels
    label_px = zeros(nr_px,1);
    % 2D histogram model
    hist_2D = zeros(dict_size,bins);
    
    % label each pixel
    for i=1:nr_px
        label_px(i,:) = label_pixel( dict_textons, textons_img(i,:) );
    end    
    
    % generate 1D histogram of the textures distribution
    %histogram(label_px,D);
    
    for i=1:dict_size
        % central pixels of this texture
        texture_px = double( central_px(label_px == i) );
        % histogram of the central pixels
        hist_texture = hist(texture_px,double(hist_edges));
        hist_2D(i,:) = hist_texture;
    end
    
end

