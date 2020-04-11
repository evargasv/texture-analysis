function [ model ] = create_model( textons, dict_textons, hist_edges )
%CREATE_MODEL Creates a model per class based on the 2D histogram between
%textures and intensity values of the center of the texture neighbourhood
%   - textons: cell array of textons per set
%   - dict_textons: dictionary of textons
%   - hist_edges: edges of the histogram
%
% ------
% Author: Elizabeth Vargas
% E-mail: EVargas@tmvse.com
% Created: 13-02-2015, using MATLAB 8.4.0.150421 (R2014b)
% Modified: 13-02-2015
% Copyright 2015 Toshiba Medical Visualization Systems Europe (TMVS)

    % create models from training
    nr_train = size(textons,1);
    % initialise model
    model = cell(nr_train,3);

    for i=1:nr_train
        model(i,:) = {generate_2D_histogram( textons{i,1},textons{i,2},dict_textons, hist_edges )};
    end

end

