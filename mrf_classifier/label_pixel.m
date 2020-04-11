function [ texton_idx ] = label_pixel( dictionary, texton_px )
%LABEL_PIXEL Calculate the closest element from a texton to a textons
%dictionary by means of the euclidean distance between them. The index of
%the texton is returned.
%   - dictionary: array of M by N^2-1 representing a dictionary of textons
%   - texton_px: array of 1 by N^2-1 representing one texton
%
% ------
% Author: Elizabeth Vargas
% E-mail: EVargas@tmvse.com
% Created: 09-02-2015, using MATLAB 8.4.0.150421 (R2014b)
% Modified: 09-02-2015
% Copyright 2015 Toshiba Medical Visualization Systems Europe (TMVS)

    % dictionary size
    N = size(dictionary,1);
    rep_texton_px = double( repmat(texton_px,N,1) );
    
    % euclidean distance
    d = sqrt( sum((dictionary-rep_texton_px).^2,2) );
    % minimum index
    [~,texton_idx] = min(d);
    
end

