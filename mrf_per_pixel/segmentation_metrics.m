function [acc,precision,recall,dice]=segmentation_metrics(seg,gt)
%SEGMENTATION_METRICS Calculates a set of metrics to evaluate the quality
%of the obtained segmentation
%   - seg: 2D or 3D image representing the obtained segmentation
%   - gt: 2D or 3D image representing the ground truth
%   - acc: accuracy of the segmentation, equivalent to the number of the
%     pixels correctly classified out of the total
%   - precision: positive predicted value (PPV) of the segmentation
%   - recall: sensitivity or true positive rate (TPR) of the segmentation
%   - f_score: F1 score. It takes values in the range [0, 1], being 1 a
%     perfect segmentation and 0 a poor one
%   - dice: Dice Coefficient. It takes values in the range [0, 1], being 1
%     a perfect segmentation and 0 a poor one
%
% ------
% Author: Elizabeth Vargas
% E-mail: EVargas@tmvse.com
% Created: 15-04-2015, using MATLAB 8.4.0.150421 (R2014b)
% Modified: 15-04-2015
% Copyright 2015 Toshiba Medical Visualization Systems Europe (TMVS)

    TOTAL = size(seg(:),1);
    % statistics
    [TP,TN,FP,FN]=segmentation_stats(int16(seg),int16(gt));
    % accuracy 
    acc = ((TP+TN)./TOTAL);
    % precision (positive predicted value)
    precision = TP./(TP+FP);
    % recall (sensitivity)
    recall = TP./(TP+FN);
    % dice coefficient
    dice = 2*nnz(seg&gt)/(nnz(seg) + nnz(gt));

end

