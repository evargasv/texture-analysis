%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TEXTURE CLASSIFICATION
%
% This script classifies the textures of the dataset that contains 20
% different classes.
%
% The first part is used to extract the textons:
%  - the TRAINING set (first two images of each class)
%  - the TESTING set (rest of images of each class)
% Using the training set, a dictionary of textons is built.
%
% The second part calculates the models for each image in the train and
% test sets, besed on the dictionary generated on the previous step.
%
% The third part classifies each image on the test by choosing the closest
% model, and hence the corresponding texture class.
%
% ------
% Author: Elizabeth Vargas
% E-mail: EVargas@tmvse.com
% Created: 09-02-2015, using MATLAB 8.4.0.150421 (R2014b)
% Modified: 11-03-2015
% Copyright 2015 Toshiba Medical Visualization Systems Europe (TMVS)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Texton Extraction

clc; clear; close all;

tic

% neighbourhood size
nbr_size = 7;
% number of clusters
nr_cluster = 10;
% textons extraction
[textons_train,textons_test,dict_textons] = textons_extraction(nbr_size,nr_cluster);

%% Model Creation

%clc; clear; close all;
%load('dict_textons.mat');
%load('textons_test.mat');
%load('textons_train.mat');

% histogram edges
hist_edges = 0:255;
% create model for the training set
model_train = create_model( textons_train, dict_textons, hist_edges );
% create model for the testing set
model_test = create_model( textons_test, dict_textons, hist_edges );


%% Classification

%clc; close all;
%load('textons_test.mat');
%load('textons_train.mat');
%load('model_train.mat');
%load('model_test.mat');

% classification
test_class = classification( model_train, model_test, textons_train );

toc

% number of classes
nr_class = 20;
% ground truth
gt = [textons_test{:,3}]';

[C,a] = confmat(int8(test_class),int8(gt));

% % confusion matrix
% C = confusionmat(gt,test_class);
% sum_row = sum(C,2);
% % normalisation
% norm = repmat(sum_row,1,nr_class);
% C = C ./ norm;
% C(isnan(C(:))) = 0;
% % accuracy
% a = trace(C)/sum(C(:));
% % show confusion matrix
% imagesc(C)

