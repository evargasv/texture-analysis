function [ dst ] = euclidean_distance( hist_1, hist_2  )
%EUCLIDEAN_DISTANCE Computation of the Euclidean Distance between two 2D
%histograms
%   - hist_1: 2D histogram
%   - hist_2: 2D histogram
% ------
% Author: Elizabeth Vargas
% E-mail: EVargas@tmvse.com
% Created: 04-05-2015, using MATLAB 8.4.0.150421 (R2014b)
% Modified: 04-05-2015
% Copyright 2015 Toshiba Medical Visualization Systems Europe (TMVS)

    dst = sqrt(sum(((hist_1-hist_2).^2),2));
    dst = sum(dst);

end

