function [texton_idx]=label_pixel_segmentation(dictionary,texton_px, DST_THOLD,NR_CLUSTERS)
%LABEL_PIXEL_SEGMENTATION Calculate the closest element from a texton to a 
%textons dictionary by means of the euclidean distance between them. The 
%index of the texton is returned.
%   - dictionary: array of M by N^2-1 representing a dictionary of textons
%   - texton_px: array of 1 by N^2-1 representing one texton
%   - DST_THOLD: threshold of the distance between the texton and the
%     dictionary of textons that determines whether a pixels belongs to the
%     background or not
%
% ------
% Author: Elizabeth Vargas
% E-mail: EVargas@tmvse.com
% Created: 09-04-2015, using MATLAB 8.4.0.150421 (R2014b)
% Modified: 16-04-2015
% Copyright 2015 Toshiba Medical Visualization Systems Europe (TMVS)

    % dictionary size
    N = size(dictionary,1);
    rep_texton_px = double( repmat(texton_px,N,1) );
    
    % euclidean distance
    d = sqrt( sum((dictionary-rep_texton_px).^2,2) );
    % minimum index
    [min_dst,texton_idx] = min(d);
    texton_idx = assign_class( texton_idx, NR_CLUSTERS );

    if min_dst > DST_THOLD 
        texton_idx = 0;
    end
    
end