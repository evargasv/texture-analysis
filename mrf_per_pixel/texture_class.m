% ------
% Author: Elizabeth Vargas
% E-mail: EVargas@tmvse.com
% Created: 09-04-2015, using MATLAB 8.4.0.150421 (R2014b)
% Modified: 23-05-2015
% Copyright 2015 Toshiba Medical Visualization Systems Europe (TMVS)

clear;clc;close all;
%% CONSTANTS/PARAMETERS

% experiment id
EXP_ID = 'exp/25';
% patients id
PATIENT_ID = {'04638','04639','04636','04635','04637'};

% volumes id, indicating the noise level
VOL_ID = {{'13'}; %patient-id 04635
          {'16'}; %patient-id 04636
          {'14'}; %patient-id 04637
          %----------------------------%
          {'16'}; %patient-id 04638
          {'15'}};%patient-id 04639
% class id    
CLASS_ID = {'Kidney','Liver','Lung','Spleen'};
% neighbourhood size
NBR_SIZE = 7;
% number of clusters
NR_CLUSTERS = 10;
% train volumes indexes
TRAIN_IDX = 1:3;
TRAIN_IDX_SPLEEN = 1:2;
% test volumes indexes
TEST_IDX = 4:5;
TEST_IDX_SPLEEN = 3:4;

%% PATCHES EXTRACTION: Extraction of ROI patches per class

sprintf('- + - + - + - + - + Patches Extraction + - + - + - + - + -')
patches_class = patches_extraction(PATIENT_ID,VOL_ID,CLASS_ID);
save(strcat(EXP_ID,'/patches_class.mat'),'patches_class','-v7.3');

% %% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TRAIN %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% TEXTONS EXTRACTION: Extraction of the textons per volume  

sprintf('- + - + - + - + - + Textons Extraction + - + - + - + - + -')
% class id    
CLASS_ID = {'Kidney','Liver','Lung','Spleen','Background'};
load(strcat(EXP_ID,'/patches_class.mat'));
textons_train = textons_extraction(patches_class,CLASS_ID,NBR_SIZE,TRAIN_IDX,TRAIN_IDX_SPLEEN);
save(strcat(EXP_ID,'/textons_train.mat'),'textons_train','-v7.3');

% % DICTIONARY: Creates dictionary from training set

sprintf('- + - + - + - + - + Create Dictionary + - + - + - + - + -')
load(strcat(EXP_ID,'/textons_train.mat'));
dictionary_textons = create_dictionary(textons_train,CLASS_ID,NR_CLUSTERS,NBR_SIZE);
save(strcat(EXP_ID,'/dictionary_textons.mat'),'dictionary_textons','-v7.3');

% MAXIMUM DISTANCE TO DICTIONARY

load(strcat(EXP_ID,'/dictionary_textons.mat'));
load(strcat(EXP_ID,'/textons_train.mat'));
CLASS_ID = {'Kidney','Liver','Lung','Spleen'};
DST_THOLD = max_dstn2dic(textons_train,CLASS_ID,TRAIN_IDX,TRAIN_IDX_SPLEEN,dictionary_textons(1:40,:));
% DST_THOLD = max_dstn2dic(textons_train,CLASS_ID,TRAIN_IDX,TRAIN_IDX_SPLEEN,dictionary_textons);

% DST_THOLD = 1000;

% SLICES GROUND TRUTH
CLASS_ID = {'Kidney','Liver','Lung','Spleen'};
slices_gt = gt_slices( PATIENT_ID(4:5), CLASS_ID );

% %% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TEST %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

tic

% SEGMENTATION
CLASS_ID = {'Kidney','Liver','Lung','Spleen'};
load(strcat(EXP_ID,'/dictionary_textons.mat'));
CLASS_ID = {'Kidney','Liver','Lung','Spleen'};
segment_test(TEST_IDX,PATIENT_ID,VOL_ID,NBR_SIZE,DST_THOLD,dictionary_textons,NR_CLUSTERS);

toc

% EVALUATION

evaluate_segmentation( PATIENT_ID(4:5), CLASS_ID, slices_gt);
