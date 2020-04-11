function [ dsnt ] = chi_sqrt_dstn( hist_1, hist_2 )
%CHI_SQRT_DSTN Computes the Chi Squared distance between two 2-Dimensional
%histograms
%   hist_1: matrix of size N by M
%   hist_2: matrix of size N by M
%
% ------
% Author: Elizabeth Vargas
% E-mail: EVargas@tmvse.com
% Created: 16-03-2015, using MATLAB 8.4.0.150421 (R2014b)
% Modified: 08-04-2015
% Copyright 2015 Toshiba Medical Visualization Systems Europe (TMVS)

    num = ( hist_1 -  hist_2 ).^2;
    den = hist_1 +  hist_2;

    zero_idx = den == 0;      
    dsnt = num./den;
    dsnt(zero_idx) = 0;
    dsnt = sum(dsnt,2);
    dsnt = sum(dsnt);
    dsnt = dsnt/2;

end

