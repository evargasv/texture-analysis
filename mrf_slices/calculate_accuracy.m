function [accuracy,miss_class]=calculate_accuracy(predicted_class,gt_class,models_test)
%CALCULATE_ACCURACY Measures the performance of the classification by
%calculating the portion of pixels that are labeled correctly during
%classification of the hand-segmented regions.
%   - models_test: cell-array containing the ground truth data  
%   - test_class: array containing the classification results
%
% ------
% Author: Elizabeth Vargas
% E-mail: EVargas@tmvse.com
% Created: 19-03-2015, using MATLAB 8.4.0.150421 (R2014b)
% Modified: 30-03-2015
% Copyright 2015 Toshiba Medical Visualization Systems Europe (TMVS)

    % number of models to test
    NR_TEST = size(predicted_class,1);
    correct_class = 0;
    total_class = 0;
    % cell array of miss-classified index
    miss_class = cell(4,1);
    
    for i=1:NR_TEST

        % number of voxels
        nr_voxels = models_test{i,3};
        % predicted class
        predicted = predicted_class(i,1);
        % ground truth
        gt = gt_class(i,1);
        
        % well classified
        if predicted == gt
            correct_class = correct_class + nr_voxels;
            total_class = total_class + nr_voxels;
        % miss-classified
        else
            total_class = total_class + nr_voxels;
            miss_class{gt,1} = [miss_class{gt,1}, i];
        end

    end
    
    % accuracy
    accuracy = correct_class./total_class;
    
end
