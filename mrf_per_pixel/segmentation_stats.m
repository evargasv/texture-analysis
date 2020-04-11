function [ ttp, ttn, tfp, tfn ] = segmentation_stats( seg, gt )
%SEGMENTATION_STATS Calculates the classification statistics, based on a
%segmented image and its corresponding ground truth (both in 2D or 3D).
%   - seg: image of the predicted segmentation
%   - gt: image of the ground truth data
%   - ttp: total of true positives
%   - ttn: total of true negatives
%   - tfp: total of false positives
%   - tfn: total of false negatives
%
% ------
% Author: Elizabeth Vargas
% E-mail: EVargas@tmvse.com
% Created: 15-04-2015, using MATLAB 8.4.0.150421 (R2014b)
% Modified: 15-04-2015
% Copyright 2015 Toshiba Medical Visualization Systems Europe (TMVS)

    % true positives
    tp = seg & gt;
    ttp = size(tp(tp(:)==1),1);
    
    % true negatives
    tn = seg | gt;
    ttn = size(tn(tn(:)==0),1);
    
    % false positives
    fp = (seg.* -1) + gt;
    tfp = size(fp(fp(:)==-1),1);
    
    % false negatives
    tfn = size(fp(fp(:)==1),1);

end

