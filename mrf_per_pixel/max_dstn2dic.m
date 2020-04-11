function [MAX_DST]=max_dstn2dic(textons,CLASS_ID,VOL_IDX,VOL_IDX_SPLEEN,dictionary_textons)
%MAX_DST2DIC Calculates the maximum distance of the textons of all the 
%classes to a dictionary
%   - textons: cell-array of textons per volume
%   - CLASS_ID: cell-array of class names
%   - VOL_IDX: cell-array of volumes indexes
%   - VOL_IDX_SPLEEN: cell-array of volumes indexes for the class spleen
%   - dictionary_textons: textons dictionary
%
% ------
% Author: Elizabeth Vargas
% E-mail: EVargas@tmvse.com
% Created: 16-04-2015, using MATLAB 8.4.0.150421 (R2014b)
% Modified: 16-04-2015
% Copyright 2015 Toshiba Medical Visualization Systems Europe (TMVS)

    % cell-array of train models
    models = {};
    % number of classes
    NR_CLASSES = size(CLASS_ID,2);
    % maximum distance
    MAX_DST = Inf;
    
    dstn = zeros(10000,1);
    dstn_idx = 1;
    
    for i=1:NR_CLASSES
        % textons of the volumes of the i-th class
        vol_class = textons{i};
        % Spleen has one patient less for training
        if i==4; VOL_IDX = VOL_IDX_SPLEEN;end;
        % index of the texton volume
        txt_vol_idx = 1;

        for j=VOL_IDX
            % textons of the j-th volume
            volume = vol_class{txt_vol_idx,1};
            % central pixels of the j-th volume
            central_px = vol_class{txt_vol_idx,2};
            % number of slices of the volume
            NBR_SLICES = size(volume,1);

            sprintf('class: %s, volume-id: %d, nr-slices:%d',CLASS_ID{i},j,NBR_SLICES)

            for k=1:NBR_SLICES
                % textons per slice
                textons_slice = volume{k};
                % maximum distance of the textons of this slice to the
                % dictionary
                distance = max_dstn_txt2dic(textons_slice,dictionary_textons);
                
                if ~isempty(distance)
                    dstn(dstn_idx,:) = distance;
                    dstn_idx = dstn_idx + 1;
                end
                
            end
            % increment index
            txt_vol_idx = txt_vol_idx + 1;
        end
    end
    
    dstn = dstn(1:dstn_idx-1);
    
    % average of the maximum distances per slice
    MAX_DST = mean(dstn);
%     %minimum of the maximum distances per slice
%     MAX_DST = min(dstn);
%     % maximum of the maximum distances per slice
%     MAX_DST = max(dstn);
    % percentil 25th of the maximum distance per slice
    idx = round(0.25*(dstn_idx-1));  
%     MAX_DST = dstn(idx,1);

end

