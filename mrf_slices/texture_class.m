% ------
% Author: Elizabeth Vargas
% E-mail: EVargas@tmvse.com
% Created: 12-03-2015, using MATLAB 8.4.0.150421 (R2014b)
% Modified: 27-04-2015
% Copyright 2015 Toshiba Medical Visualization Systems Europe (TMVS)

clear;clc;close all;
%% CONSTANTS/PARAMETERS

% experiment id
EXP_ID = 'exp/95';
% patients id
PATIENT_ID = {'04635','04636','04637','04638','04639'};

% volumes id, indicating the noise level
VOL_ID = {{'15'}; %patient-id 04635
          {'15'}; %patient-id 04637
          {'16'}; %patient-id 04638
          %----------------------------%
          {'13'}; %patient-id 04639
          {'16'}};%patient-id 04636
% class id    
CLASS_ID = {'Kidney','Liver','Lung','Spleen'};
% neighbourhood size
NBR_SIZE = 5;
% number of clusters
NR_CLUSTERS = 20;
% train volumes indexes
TRAIN_IDX = 1:3;
TRAIN_IDX_SPLEEN = 1:2;
% test volumes indexes
TEST_IDX = 4:5;
TEST_IDX_SPLEEN = 3:4;

% %% PATCHES EXTRACTION: Extraction of ROI patches per class

% sprintf('- + - + - + - + - + Patches Extraction + - + - + - + - + -')
% patches_class = patches_extraction(PATIENT_ID,VOL_ID,CLASS_ID);
% save(strcat(EXP_ID,'/patches_class.mat'),'patches_class','-v7.3');

% %% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TRAIN %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% % % TEXTONS EXTRACTION: Extraction of the textons per volume  
% 
% sprintf('- + - + - + - + - + Textons Extraction + - + - + - + - + -')
% load(strcat(EXP_ID,'/patches_class.mat'));
% textons_train = textons_extraction(patches_class,CLASS_ID,NBR_SIZE,TRAIN_IDX,TRAIN_IDX_SPLEEN);
% save(strcat(EXP_ID,'/textons_train.mat'),'textons_train','-v7.3');
% 
% % % DICTIONARY: Creates dictionary from training set
% 
% sprintf('- + - + - + - + - + Create Dictionary + - + - + - + - + -')
% load(strcat(EXP_ID,'/textons_train.mat'));
% dictionary_textons = create_dictionary(textons_train,CLASS_ID,NR_CLUSTERS,NBR_SIZE);
% save(strcat(EXP_ID,'/dictionary_textons.mat'),'dictionary_textons','-v7.3');
% 
% % % HISTOGRAM EDGES
% 
% load(strcat(EXP_ID,'/textons_train.mat'));
% ORG_HIST_EDGES = calc_hist_edges( textons_train, NBR_SIZE );
% nr_bins = size(ORG_HIST_EDGES,2);
% start_idx = round(0.25*nr_bins);
% end_idx = round(0.75*nr_bins);
% HIST_EDGES = ORG_HIST_EDGES(start_idx:end_idx);
% save(strcat(EXP_ID,'/HIST_EDGES.mat'),'HIST_EDGES','-v7.3');
% 
% % % MODELS GENERATION: Creates the 2D histogram per slice
% 
% sprintf('- + - + - + - + - + 2D Histograms + - + - + - + - + -')
% load(strcat(EXP_ID,'/dictionary_textons.mat'));
% load(strcat(EXP_ID,'/textons_train.mat'));
% load(strcat(EXP_ID,'/HIST_EDGES.mat'));
% models_train = generate_models(textons_train,CLASS_ID,TRAIN_IDX,TRAIN_IDX_SPLEEN,dictionary_textons,HIST_EDGES);
% save(strcat(EXP_ID,'/models_train.mat'),'models_train','-v7.3');

% %% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TEST %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% % TEXTONS EXTRACTION: Extraction of the textons per volume  
% 
% sprintf('- + - + - + - + - + Textons Extraction + - + - + - + - + -')
% load(strcat(EXP_ID,'/patches_class.mat'));
% textons_test = textons_extraction(patches_class,CLASS_ID,NBR_SIZE,TEST_IDX,TEST_IDX_SPLEEN);
% save(strcat(EXP_ID,'/textons_test.mat'),'textons_test','-v7.3');
% 
% % MODELS GENERATION: Creates the 2D histogram per slice
% 
% sprintf('- + - + - + - + - + 2D Histograms + - + - + - + - + -')
% load(strcat(EXP_ID,'/dictionary_textons.mat'));
% load(strcat(EXP_ID,'/textons_test.mat'));
% load(strcat(EXP_ID,'/HIST_EDGES.mat'));
% models_test = generate_models(textons_test,CLASS_ID,TEST_IDX,TEST_IDX_SPLEEN,dictionary_textons,HIST_EDGES);
% save(strcat(EXP_ID,'/models_test.mat'),'models_test','-v7.3');

%CLASSIFICATION

sprintf('- + - + - + - + - + Classification + - + - + - + - + -')
load(strcat(EXP_ID,'/models_train.mat'));
load(strcat(EXP_ID,'/models_test.mat')); 
test_class = classification( models_train, models_test );
save(strcat(EXP_ID,'/test_class.mat'),'test_class','-v7.3');

% ACCURACY

load(strcat(EXP_ID,'/models_test.mat'));
load(strcat(EXP_ID,'/models_train.mat'));
load(strcat(EXP_ID,'/test_class.mat'));

% number of models to test
NR_TEST = size(models_test,1);
% ground truth 
gt = zeros(NR_TEST,1);
for i=1:NR_TEST
    gt(i,1) = models_test{i,2};
end

% per-pixel accuracy
[px_accuracy,miss_class] = calculate_accuracy( test_class, gt, models_test );

% per-region accuracy
[C,re_accuracy] = confmat(int8(test_class(:,1)),int8(gt));
imagesc(C);

% % ANALYSIS
% 
% load(strcat(EXP_ID,'/patches_class.mat'));
% load(strcat(EXP_ID,'/HIST_EDGES.mat'));
% load(strcat(EXP_ID,'/test_class.mat'));
% 
% [total_slices,miss_slices,perc_miss]=analysis(gt,miss_class,models_train,models_test,patches_class,test_class,ORG_HIST_EDGES,CLASS_ID)
