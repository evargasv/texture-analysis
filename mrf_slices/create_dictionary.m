function [dictionary_textons]=create_dictionary(textons_train,CLASS_ID,NBR_CLUSTERS,NBR_SIZE)
%CREATE_DICTIONARY Creates a dictionary of textons from the training data
%   - textons_class: cell-array containing the textons per class
%   - CLASS_ID: cell-array containing the names of the classes
%   - TRAIN_IDX: index of the volumes that will be used for training
%   - TRAIN_IDX_SPLEEN: index of the volumnes that will be used for
%     training on the class spleen
%   - NBR_CLUSTERS: number of clusters used on k-means
%   - NBR_SIZE: size of the neighbourhood
%
% ------
% Author: Elizabeth Vargas
% E-mail: EVargas@tmvse.com
% Created: 17-03-2015, using MATLAB 8.4.0.150421 (R2014b)
% Modified: 24-03-2015
% Copyright 2015 Toshiba Medical Visualization Systems Europe (TMVS)

    % number of classes
    NBR_CLASSES = size(CLASS_ID,2);
    % initialise textons dictionary
    dictionary_textons = zeros(NBR_CLASSES*NBR_CLUSTERS,(NBR_SIZE*NBR_SIZE)-1);
    dict_idx = 1;

    for i=1:NBR_CLASSES

        % initialise textons dictionary
        textons_dic = zeros(10000000,(NBR_SIZE*NBR_SIZE)-1);
        textons_dic_idx = 1;
        % textons of the volumes of the i-th class
        vol_class = textons_train{i};
        % number of volumes
        nr_vol = size(vol_class,1);

        for j=1:nr_vol

            % textons of the j-th volume
            volume = vol_class{j,1};
            % number of slices of the volume
            NBR_SLICES = size(volume,1);
            
            sprintf('class: %s, volume-id: %d, nr-slices:%d',CLASS_ID{i},j,NBR_SLICES)

            for k=1:NBR_SLICES
                % concatenate textons per class
                textons_slice = volume{k};
                nr_txt_slice = size(textons_slice,1);
                textons_dic(textons_dic_idx:textons_dic_idx+nr_txt_slice-1,:) = textons_slice;
                textons_dic_idx = textons_dic_idx + nr_txt_slice;
            end
        end

        textons_dic = textons_dic(1:textons_dic_idx-1,:);
        
        % clustering
        [~, clusters_class] = kmeans(textons_dic',NBR_CLUSTERS);
        dictionary_textons(dict_idx:dict_idx+NBR_CLUSTERS-1,:) = clusters_class';
        dict_idx = dict_idx + NBR_CLUSTERS;
    end

end

