function [texton_idx] = majority_voting_scheme( dictionary,texton_px, DST_THOLD, NR_CLUSTERS )
%MAJORITY_VOTING_SCHEME Summary of this function goes here
%   - dictionary: array of M by N^2-1 representing a dictionary of textons
%   - texton_px: array of 1 by N^2-1 representing one texton
%   - DST_THOLD: threshold of the distance between the texton and the
%     dictionary of textons that determines whether a pixels belongs to the
%     background or not
% ------
% Author: Elizabeth Vargas
% E-mail: EVargas@tmvse.com
% Created: 30-04-2015, using MATLAB 8.4.0.150421 (R2014b)
% Modified: 30-04-2015
% Copyright 2015 Toshiba Medical Visualization Systems Europe (TMVS)

    % dictionary size
    N = size(dictionary,1);
    rep_texton_px = double( repmat(texton_px,N,1) );
    
    % euclidean distance
    d = sqrt( sum((dictionary-rep_texton_px).^2,2) );
    % sort distances
    [sorted_dst, sorted_idx] = sort(d);
    
    % three closest indices to do majoring voting scheme
    mvs = zeros(1,3);
    
    % assign class to the textons indices
    for i=1:3
        mvs(1,i) = assign_class( sorted_idx(i), NR_CLUSTERS );
    end
    
    % all are different
    if (mvs(1)~=mvs(2)) && (mvs(1)~=mvs(3)) && (mvs(2)~=mvs(3))
        min_dst = sorted_dst(1);
        texton_idx = mvs(1);
    % three are equal
    elseif (mvs(1)==mvs(2)) && (mvs(1)==mvs(3)) && (mvs(2)==mvs(3))
        min_dst = sorted_dst(1);
        texton_idx = mvs(1);
    % the first two are equal
    elseif (mvs(1)==mvs(2))
        min_dst = sorted_dst(1);
        texton_idx = mvs(1);
    elseif (mvs(1)==mvs(3))
        min_dst = sorted_dst(1);
        texton_idx = mvs(1);
    elseif (mvs(2)==mvs(3))
        min_dst = sorted_dst(2);
        texton_idx = mvs(2);
    end
    
    % check if the value corresponds to background
    if min_dst > DST_THOLD 
        texton_idx = 0;
    end

end

