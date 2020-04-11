function [ dst ] = kl_divergence( hist_1, hist_2  )
%KL_DIVERGENCE Computation of the KL-Divergence between two 2D histograms
%   - hist_1: Approximation of the distribution
%   - hist_2: True distribution
% ------
% Author: Elizabeth Vargas
% E-mail: EVargas@tmvse.com
% Created: 04-05-2015, using MATLAB 8.4.0.150421 (R2014b)
% Modified: 04-05-2015
% Copyright 2015 Toshiba Medical Visualization Systems Europe (TMVS)

    % KL-Divergence(P,Q): P is the true distribution, Q the approximation
    dst=sum(KLDiv(hist_2, hist_1));

end

