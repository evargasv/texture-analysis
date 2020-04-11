function [ test_class ] = classification( models_train, models_test )
%CLASSIFICATION Using the chi squared distance, this method find the
%closest model in the training set for each model in the test set and
%assigns the same class.
%   - models_train: set of 2D histograms used for training
%   - models_test: set of 2D histograms used for testing
%
% ------
% Author: Elizabeth Vargas
% E-mail: EVargas@tmvse.com
% Created: 17-03-2015, using MATLAB 8.4.0.150421 (R2014b)
% Modified: 24-03-2015
% Copyright 2015 Toshiba Medical Visualization Systems Europe (TMVS)

    % number of models to test
    NR_TEST = size(models_test,1);
    % number of models to train
    NR_TRAIN = size(models_train,1);
    % vector of assigned class
    test_class = zeros(NR_TEST,2);

    for i=1:NR_TEST

        sprintf('Test Nr. %d/%d',i,NR_TEST)
        % initialise distance array
        dst = zeros(NR_TRAIN,1);
        m_test = models_test{i,1};

        for j=1:NR_TRAIN
            % chi squared distance between 2D histograms
            % dst(j,1) = chi_sqrt_dstn( m_test, models_train{j,1} );
            
            % kl-divergence between 2D histograms
            %dst(j,1) = kl_divergence( m_test, models_train{j,1} );
            
            % euclidean distance between 2D histograms
            dst(j,1) = euclidean_distance( m_test, models_train{j,1}  );
        end

        % select the minimum value
        [~,idx] = min(dst);
        % assign the class of the first minimum distance (in case there is
        % more than one)
        test_class(i,1) = models_train{idx(1),2};
        test_class(i,2) = idx(1);
    end

end

