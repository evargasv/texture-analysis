function [models] = generate_models(textons,CLASS_ID,VOL_IDX,VOL_IDX_SPLEEN,dictionary_textons,HIST_EDGES)
%GENERATE_MODELS Creates 2D histograms for each slice of the training and
%testing volumes and store them on cell-arrays.
%   - textons_class: cell-array containg the textons arraged by class
%   - CLASS_ID: cell-array containing class names
%   - TRAIN_IDX: indices of training volumes
%   - TRAIN_IDX_SPLEEN: indices of training volumes for class spleen
%   - TEST_IDX: indices of testing volumes
%   - TEST_IDX_SPLEEN: indices of testing volumes for class spleen
%   - dictionary_textons: array containing the textons dictionary
%   - HIST_EDGES: edges of the histogram according to the maximum and
%     minimum values of the textons
%
% ------
% Author: Elizabeth Vargas
% E-mail: EVargas@tmvse.com
% Created: 16-03-2015, using MATLAB 8.4.0.150421 (R2014b)
% Modified: 16-03-2015
% Copyright 2015 Toshiba Medical Visualization Systems Europe (TMVS)

    % cell-array of train models
    models = {};
    % number of classes
    NR_CLASSES = size(CLASS_ID,2);

    for i=1:NR_CLASSES
        % textons of the volumes of the i-th class
        vol_class = textons{i};
        % Spleen has one patient less for training
        if i==4; VOL_IDX = VOL_IDX_SPLEEN;end;
        % index of the texton volume
        txt_vol_idx = 1;

        for j=VOL_IDX
            % textons of the j-th volume
            volume = vol_class{txt_vol_idx,1};
            % central pixels of the j-th volume
            central_px = vol_class{txt_vol_idx,2};
            % number of slices of the volume
            NBR_SLICES = size(volume,1);

            sprintf('class: %s, volume-id: %d, nr-slices:%d',CLASS_ID{i},j,NBR_SLICES)

            for k=1:NBR_SLICES
                % textons per slice
                textons_slice = volume{k};
                nbr_textons = size(textons_slice,1);
                % central pixel per slice
                central_px_slice = central_px{k};
                % create model
                slice_model = generate_2D_histogram(textons_slice,central_px_slice,dictionary_textons,HIST_EDGES);
                
                % if the model has at least 5 elements
                if size(slice_model(slice_model(:)~=0),1) >= 5
                    % add to the cell-array of train models
                    models = [models; {slice_model, i, nbr_textons, j, k}];
                end
            end
            % increment index
            txt_vol_idx = txt_vol_idx + 1;
        end
    end

end

