function [ test_class ] = classification( model_train, model_test, textons_train )
%CLASSIFICATION Classifies each image on the test by choosing the closest
% model, and hence the corresponding texture class.
%   - model_train: models of the training set images
%   - model_test: models of the testing set images
%   - textons_train: array containing the textons per image and the
%     corresponding class
%
% ------
% Author: Elizabeth Vargas
% E-mail: EVargas@tmvse.com
% Created: 13-02-2015, using MATLAB 8.4.0.150421 (R2014b)
% Modified: 13-02-2015
% Copyright 2015 Toshiba Medical Visualization Systems Europe (TMVS)

    % number of training models
    train_nr = size(model_train,1);
    % number of testing models
    test_nr = size(model_test,1);

    % initialise classification array
    test_class = zeros(test_nr,1);

    % trainig model classes
    train_class = [textons_train{:,3}]';

    for i=1:test_nr

        % distance array from the test model to each training model
        dsnt = zeros(train_nr,1);

        for j=1:train_nr
            % chi squared distance calculation
            dsnt(j,1) = chi_sqrt_dstn( model_test{i,1}, model_train{j,1} );
        end

        % select the minimum value
        [~,idx] = min(dsnt);
        % assign the class of the first minimum distance (in case there is
        % more than one)
        test_class(i,:) = train_class(idx(1));
    end

end
