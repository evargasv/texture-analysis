function [ X, Y ] = generate_set( M, noise_id, col_idx, nr_pt )
%GENERATE_SET Summary of this function goes here
%   - M:
%   - noise_id:
%   - col_idx:
%   - nr_pt:
% ------
% Author: Elizabeth Vargas
% E-mail: EVargas@tmvse.com
% Created: 18-05-2015, using MATLAB 8.4.0.150421 (R2014b)
% Modified: 18-05-2015
% Copyright 2015 Toshiba Medical Visualization Systems Europe (TMVS)


    % rows indices of the noise type
    row_idx_noise = (M(:,1)== noise_id);
    % rows containing information of the noise type
    noise_info = M(row_idx_noise,:);
    
    % patients id
    pt_id = noise_info(:,2);
    
    % train
    if nr_pt == 3
        % patients row idx
        row_idx_pt = ((pt_id == 4635 )|(pt_id == 4636)|(pt_id == 4637));
    % test
    else
        % patients row idx 
        row_idx_pt = ((pt_id == 4638)|(pt_id == 4639));
    end
    
    pt_info = noise_info(row_idx_pt,:);
    
    % features
    X = pt_info(:,col_idx);
    % class
    Y = pt_info(:,3);

end

