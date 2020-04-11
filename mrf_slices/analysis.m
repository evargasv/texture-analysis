function [total_slices,miss_slices,perc_miss]=analysis(gt,miss_class,models_train,models_test,patches_class,test_class,HIST_EDGES,CLASS_ID)
%ANALYSIS Displays the list of missclassified slices, along with its
%nearest neighbour on the training, that is causing the missclassification
%   - gt: ground truth of the test slices
%   - miss_class: slices that are being miss-classified
%   - models_train: cell-array containing the models used for training
%   - models_test: cell-array containing the models used for testing
%   - patches_class: cell-array containing the information of the roi
%     patches, organised by class
%   - test_class: predicted class of the test slices
%   - HIST_EDGES: edges of the histogram models
%   - CLASS_ID: cell-array containing the name of the classes
%   - total_slices: total number of slices in the test per class
%   - miss_slices: total number of miss-classified slices in the test per
%     class
%   - perc_miss: percentage of miss-classified slices per class
%
% ------
% Author: Elizabeth Vargas
% E-mail: EVargas@tmvse.com
% Created: 31-03-2015, using MATLAB 8.4.0.150421 (R2014b)
% Modified: 07-04-2015
% Copyright 2015 Toshiba Medical Visualization Systems Europe (TMVS)

    % total slices
    total_slices = zeros(4,1);
    total_slices(1,1) = size(gt( gt(:) == 1),1);
    total_slices(2,1) = size(gt( gt(:) == 2),1);
    total_slices(3,1) = size(gt( gt(:) == 3),1);
    total_slices(4,1) = size(gt( gt(:) == 4),1);

    % miss-classified slices
    miss_slices = zeros(4,1);
    miss_slices(1,1) = size(miss_class{1,:},2);
    miss_slices(2,1) = size(miss_class{2,:},2);
    miss_slices(3,1) = size(miss_class{3,:},2);
    miss_slices(4,1) = size(miss_class{4,:},2);

    % percentage of miss-classified per class
    perc_miss = miss_slices ./ total_slices * 100;

    figure();clf;

    for i=1:4
        % miss-classified models per i-th class
        mc = miss_class{i,:};
        % number of miss-classified models
        nr_mc = size(mc,2);

        for j=1:nr_mc

            % TEST PATCH MISS-CLASSIFIED
            test_model_nr = mc(j);
            % patch information of the test model that was miss-classified
            class_gt = i;
            vol_gt = models_test{test_model_nr,4};
            slice_gt = models_test{test_model_nr,5};
            % patches of class_gt
            pc_gt = patches_class{class_gt};
            % patches of volume vol_gt
            pv_gt = pc_gt{vol_gt};
            % patches of slice slice_gt
            ps_gt = pv_gt(slice_gt,:);
            % ROI extraction
            patch_gt = ps_gt{1,1};
            mask_gt = ps_gt{1,2};
            roi_gt = patch_gt .* int16(mask_gt);

            % TRAIN PATCH WITH THE CLOSEST MODEL
            train_model_nr = test_class(test_model_nr,2);
            % patch information of the train model into which the test was
            % miss-classified
            class_pred = models_train{train_model_nr,2};
            vol_pred = models_train{train_model_nr,4};
            slice_pred = models_train{train_model_nr,5};
            % patches of class_pred
            pc_pred = patches_class{class_pred};
            % patches of volume vol_pred
            pv_pred = pc_pred{vol_pred};
            % patches of slice slice_pred
            ps_pred = pv_pred(slice_pred,:);
            % ROI extraction
            patch_pred = ps_pred{1,1};
            mask_pred = ps_pred{1,2};
            % original slice of the volume into which is miss-classified
            slice_problem = ps_pred{1,3}
            
            roi_pred = patch_pred .* int16(mask_pred);

            clf;
            sub_title = sprintf('Class: %s, Volume: %d, Slice: %d',CLASS_ID{class_gt},vol_gt,slice_gt);
            subplot(1,2,1), imshow(roi_gt,'DisplayRange',[HIST_EDGES(1),HIST_EDGES(end)]); title(sub_title)
            sub_title = sprintf('Class: %s, Volume: %d, Slice: %d',CLASS_ID{class_pred},vol_pred,slice_pred);
            subplot(1,2,2), imshow(roi_pred,'DisplayRange',[HIST_EDGES(1),HIST_EDGES(end)]); title(sub_title)
            suptitle(strcat('Class:',CLASS_ID{i},' Miss-classification Nr.: ', num2str(j), '/', num2str(nr_mc) ))
            pause;
        end
    end
end

