function [ class_idx ] = assign_class( txt_idx, NR_CLUSTERS )
%ASSIGN_CLASS Assigns a class label from 0 to 4 to a set of dictionary
%indices, depending on the number of textons per class in the dictionary
%   - txt_idx: index of the closest texton in the dictionary
%   - NR_CLUSTERS: number of textons per class in the dictionary
% ------
% Author: Elizabeth Vargas
% E-mail: EVargas@tmvse.com
% Created: 01-05-2015, using MATLAB 8.4.0.150421 (R2014b)
% Modified: 01-05-2015
% Copyright 2015 Toshiba Medical Visualization Systems Europe (TMVS)

    if NR_CLUSTERS == 10
        if txt_idx >= 1 && txt_idx <= 10
            class_idx = 1;
        elseif txt_idx >= 11 && txt_idx <= 20
            class_idx = 2;
        elseif txt_idx >= 21 && txt_idx <= 30
            class_idx = 3;
        elseif txt_idx >= 31 && txt_idx <= 40
            class_idx = 4;
        else
            class_idx = 0;
        end
    elseif NR_CLUSTERS == 20
        if txt_idx >= 1 && txt_idx <= 20
            class_idx = 1;
        elseif txt_idx >= 21 && txt_idx <= 40
            class_idx = 2;
        elseif txt_idx >= 41 && txt_idx <= 60
            class_idx = 3;
        elseif txt_idx >= 61 && txt_idx <= 80
            class_idx = 4;
        else
            class_idx = 0;
        end
    elseif NR_CLUSTERS == 30
        if txt_idx >= 1 && txt_idx <= 30
            class_idx = 1;
        elseif txt_idx >= 31 && txt_idx <= 60
            class_idx = 2;
        elseif txt_idx >= 61 && txt_idx <= 90
            class_idx = 3;
        elseif txt_idx >= 91 && txt_idx <= 120
            class_idx = 4;
        else
            class_idx = 0;
        end
    end

end

