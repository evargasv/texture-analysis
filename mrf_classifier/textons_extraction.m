function [textons_train,textons_test,dict_textons] = textons_extraction(nbr_size,nr_cluster)
%TEXTONS_EXTRACTION Extract the textons from each image and distribute them
%between the traininig and the testing set
%   - nbr_size: neighbourhood size
%   - nr_cluster: number of clusters
%
% ------
% Author: Elizabeth Vargas
% E-mail: EVargas@tmvse.com
% Created: 13-02-2015, using MATLAB 8.4.0.150421 (R2014b)
% Modified: 11-03-2015
% Copyright 2015 Toshiba Medical Visualization Systems Europe (TMVS)

    dataDir = 'P2_class/';
    d = dir([dataDir 't*']);

    % number of classes
    nr_class = length(d);
    % textons dictionary
    dict_textons = zeros(nr_cluster*nr_class,(nbr_size*nbr_size)-1);
    dict_idx = 1;
    % textons_train
    textons_train = cell(2*nr_class,3);
    % textons_test
    textons_test = cell(nr_class-2,3);

    %computing textons from training and testing sets
    for i=1:nr_class,

        sprintf('class #%f',i)
        namedir = d(i).name;
        d1 = dir([dataDir namedir '/*.tif']);
        
        textons_class = [];

        for j=1:2,        
            name = [dataDir namedir '/' d1(j).name];
            img = imread(name);
            img = rgb2gray(img);

            % extract textons
            [textons_img,central_px]=neighbours_extraction(img,nbr_size);
            % store textons
            textons_train((i-1)*2+j,:) = {textons_img,central_px,i};

            % concatenate textons for the dictionary
            textons_class = [textons_class; textons_img];        
        end

        textons_class = double(textons_class);
        % clusterize textons
        % [~, clusters_class] = kmeans(textons_class,nr_cluster,'Replicates',5,'MaxIter',500);
        % kmeans++
        [~, clusters_class] = kmeans(textons_class',nr_cluster);
                
        % create textons dictionary
        % dict_textons(dict_idx:dict_idx+nr_cluster-1,:) = clusters_class;
        dict_textons(dict_idx:dict_idx+nr_cluster-1,:) = clusters_class';
        dict_idx = dict_idx + nr_cluster;

        for j=3:length(d1),
            name = [dataDir namedir '/' d1(j).name];
            img = imread(name);
            img = rgb2gray(img);

            % extract textons
            [textons_img,central_px]=neighbours_extraction(img,nbr_size);
            % store textons
            textons_test((i-1)*4+j-2,:) = {textons_img,central_px,i};
        end
    end

end

