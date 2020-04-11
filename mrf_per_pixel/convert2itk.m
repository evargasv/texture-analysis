% ------
% Author: Elizabeth Vargas
% E-mail: EVargas@tmvse.com
% Created: 09-04-2015, using MATLAB 8.4.0.150421 (R2014b)
% Modified: 13-04-2015
% Copyright 2015 Toshiba Medical Visualization Systems Europe (TMVS)

clear;clc;close all;
%% CONSTANTS/PARAMETERS

% patients id
PATIENT_ID = {'04635','04636','04637','04638','04639'};

% volumes id, indicating the noise level
VOL_ID = {{'16','17','24','26','22','15','18','25','27','23'}; %patient-id 04635
          {'14','22','17','24','20','15','23','18','25','21'}; %patient-id 04636
          {'15','17','19','21','23','16','18','20','22','24'}; %patient-id 04637
          %----------------------------%
          {'13','15','17','22','20','14','16','18','23','21'}; %patient-id 04638
          {'16','18','10','12','14','17','19','11','13','15'}};%patient-id 04639
% class id    
CLASS_ID = {'Kidney','Liver','Lung','Spleen'};
% lungs erosion
ERO_SIZE = 5;

dicom2itk(PATIENT_ID,VOL_ID,CLASS_ID,ERO_SIZE);