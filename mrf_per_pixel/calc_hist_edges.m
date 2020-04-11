function [ HIST_EDGES ] = calc_hist_edges( textons_train, NBR_SIZE )
%CALC_HIST_EDGES Calculates the edges of the 2D histogram by computing the
%maximum and the minimum value of the train classes
%   - textons_train: textons of the volumes used for train
%   - NBR_SIZE: size of the neighbourhood
%   - HIST_EDGES: edges of the 2D histogram
%
% ------
% Author: Elizabeth Vargas
% E-mail: EVargas@tmvse.com
% Created: 23-03-2015, using MATLAB 8.4.0.150421 (R2014b)
% Modified: 24-03-2015
% Copyright 2015 Toshiba Medical Visualization Systems Europe (TMVS)

    % number of classes
    NR_CLASSES = size(textons_train,1);   
    % assumes that patches_class has at least one element
    [low_edge,high_edge]=windowing(textons_train{1},NBR_SIZE );
    
    for i=2:NR_CLASSES
        % find the edges per class
        [low,high]=windowing(textons_train{i},NBR_SIZE);
        % determine whether the low edge is the minimum
        if low < low_edge
            low_edge = low;
        end
        % determine whether the high edge is the maximum
        if high > high_edge
            high_edge = high;
        end
    end
    
    % return the histogram edges
    HIST_EDGES = low_edge:high_edge;
end

