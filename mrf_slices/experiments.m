%
% ------
% Author: Elizabeth Vargas
% E-mail: EVargas@tmvse.com
% Created: 07-04-2015, using MATLAB 8.4.0.150421 (R2014b)
% Modified: 14-04-2015
% Copyright 2015 Toshiba Medical Visualization Systems Europe (TMVS)

%% TEMPLATE
% chi-squared distance: neighbours=5,centroids=10
% noise = [0, 1, 2, 3, 4];
% kidney = [];
% liver = [];
% lung = [];
% spleen = [];
% plot_accuracy( noise,kidney,liver,lung,spleen );

%% EXPERIMENTS TYPE I

% chi-squared distance: neighbours=3,centroids=10
noise = [0, 1, 2, 3, 4];
kidney = [88.04, 86.96, 87.5, 87.5, 86.41];
liver = [61.63,	61.84, 61.43, 60.41, 55.92];
lung = [100, 100, 100, 100, 100];
spleen = [93.46, 93.77, 92.83, 93.15, 92.21];
plot_accuracy( noise,kidney,liver,lung,spleen,'ROIs Classification AIDR3D');

% chi-squared distance: neighbours=3,centroids=20
noise = [0, 1, 2, 3, 4];
kidney = [88.59, 88.04, 86.96, 82.61, 78.26];
liver = [56.53,	56.53, 57.55, 56.73, 51.02];
lung = [100, 100, 100, 100, 100];
spleen = [91.9,	91.28, 91.59, 90.65, 89.41];
plot_accuracy( noise,kidney,liver,lung,spleen,'ROIs Classification AIDR3D' );

% chi-squared distance: neighbours=5,centroids=10
noise = [0, 1, 2, 3, 4];
kidney = [91.3	92.39	90.76	91.3	89.13];
liver = [64.9	66.12	65.31	64.49	60.82];
lung = [100	100	100	100	100];
spleen = [96.23	96.54	96.23	96.23	95.28];
plot_accuracy( noise,kidney,liver,lung,spleen,'ROIs Classification AIDR3D' );

% chi-squared distance: neighbours=5,centroids=20
noise = [0, 1, 2, 3, 4];
kidney = [88.59	87.5	86.41	79.89	73.37];
liver = [61.22	61.84	61.84	59.8	56.53];
lung = [100	100	100	100	100];
spleen = [95.6	95.6	94.97	94.34	93.4];
plot_accuracy( noise,kidney,liver,lung,spleen,'ROIs Classification AIDR3D' );



% euclidean distance: neighbours=3,centroids=10
noise = [0, 1, 2, 3, 4];
kidney = [94.57	92.93	94.02	94.02	88.59];
liver = [66.12	66.33	66.33	64.08	60.41];
lung = [100	100	100	100	100];
spleen = [94.08	94.08	93.15	92.83	93.15];
plot_accuracy( noise,kidney,liver,lung,spleen,'ROIs Classification AIDR3D');

% euclidean distance: neighbours=3,centroids=20
noise = [0, 1, 2, 3, 4];
kidney = [94.57	94.57	95.65	94.57	94.57];
liver = [63.88	65.31	63.88	62.04	56.12];
lung = [100	100	100	100	100];
spleen = [91.59	91.59	91.59	91.59	89.72];
plot_accuracy( noise,kidney,liver,lung,spleen,'ROIs Classification AIDR3D' );

% euclidean distance: neighbours=5,centroids=10
noise = [0, 1, 2, 3, 4];
kidney = [98.91	98.91	98.91	97.83	97.83];
liver = [64.9	64.69	65.51	64.69	62.45];
lung = [100	100	100	100	100];
spleen = [94.65	94.34	94.34	94.34	93.4];
plot_accuracy( noise,kidney,liver,lung,spleen,'ROIs Classification AIDR3D' );

% euclidean distance: neighbours=5,centroids=20
noise = [0, 1, 2, 3, 4];
kidney = [92.39	92.39	92.39	90.22	83.15];
liver = [60.2	62.86	62.24	61.22	58.37];
lung = [100	100	100	100	100];
spleen = [92.14	92.14	93.08	93.08	92.14];
plot_accuracy( noise,kidney,liver,lung,spleen,'ROIs Classification AIDR3D' );

% glcm

noise = [0, 1, 2, 3, 4];
kidney = [63.47826087	75.65217391	71.30434783	76.52173913	84.34782609];
liver = [33.22683706	52.39616613	67.09265176	65.17571885	60.06389776];
lung = [100	100	100	100	100];
spleen = [97.05882353	95.09803922	93.1372549	96.07843137	90.68627451];
plot_accuracy( noise,kidney,liver,lung,spleen,'ROIs Classification AIDR3D' );

% COMPARISON
% kidney
noise = [0, 1, 2, 3, 4];
chi_sqrt = [91.3	92.39	90.76	91.3	89.13];
eucli = [98.91	98.91	98.91	97.83	97.83];
stats = [63.47826087	75.65217391	71.30434783	76.52173913	84.34782609];
plot_roi( noise,chi_sqrt,eucli,stats,'Kidney')
% liver
noise = [0, 1, 2, 3, 4];
chi_sqrt = [64.9	66.12	65.31	64.49	60.82];
eucli = [64.9	64.69	65.51	64.69	62.45];
stats = [33.22683706	52.39616613	67.09265176	65.17571885	60.06389776];
plot_roi( noise,chi_sqrt,eucli,stats,'Liver')
% lung
noise = [0, 1, 2, 3, 4];
chi_sqrt = [100	100	100	100	100];
eucli = [100	100	100	100	100];
stats = [100	100	100	100	100];
plot_roi( noise,chi_sqrt,eucli,stats,'Lung')
% spleen
noise = [0, 1, 2, 3, 4];
chi_sqrt = [96.23	96.54	96.23	96.23	95.28];
eucli = [94.65	94.34	94.34	94.34	93.4];
stats = [97.05882353	95.09803922	93.1372549	96.07843137	90.68627451];
plot_roi( noise,chi_sqrt,eucli,stats,'Spleen')


%% EXPERIMENTS TYPE II

% chi-squared distance: neighbours=3,centroids=10
noise = [0, 1, 2, 3, 4];
kidney = [90.22	89.13	86.41	72.83	36.96];
liver = [68.98	68.78	62.24	54.69	21.43];
lung = [100	100	100	100	100];
spleen = [91.59	89.41	69.78	17.45	12.77];
plot_accuracy( noise,kidney,liver,lung,spleen,'ROIs Classification No-AIDR3D');

% chi-squared distance: neighbours=3,centroids=20
noise = [0, 1, 2, 3, 4];
kidney = [80.98	78.8	72.28	37.5	15.22];
liver = [68.37	69.59	58.57	48.37	32.86];
lung = [100	100	100	100	100];
spleen = [85.98	79.75	43.93	19	12.15];
plot_accuracy( noise,kidney,liver,lung,spleen,'ROIs Classification No-AIDR3D');

% chi-squared distance: neighbours=5,centroids=10
noise = [0, 1, 2, 3, 4];
kidney = [91.3	88.04	83.7	73.37	39.13];
liver = [61.43	59.8	54.29	52.65	38.16];
lung = [100	100	100	100	99.72];
spleen = [94.65	94.34	93.4	52.52	39.94];
plot_accuracy( noise,kidney,liver,lung,spleen,'ROIs Classification No-AIDR3D');

% chi-squared distance: neighbours=5,centroids=20
noise = [0, 1, 2, 3, 4];
kidney = [85.33	76.63	63.04	28.26	15.76];
liver = [60.61	59.39	53.06	52.86	42.65];
lung = [100	100	100	99.72	99.45];
spleen = [95.6	94.65	93.71	70.13	82.7];
plot_accuracy( noise,kidney,liver,lung,spleen,'ROIs Classification No-AIDR3D');


% euclidean distance: neighbours=3,centroids=10
noise = [0, 1, 2, 3, 4];
kidney = [94.57	94.02	93.48	85.87	45.11];
liver = [70.82	74.08	65.31	55.71	52.65];
lung = [100	100	100	100	100];
spleen = [90.65	87.54	76.32	22.74	10.59];
plot_accuracy( noise,kidney,liver,lung,spleen,'ROIs Classification No-AIDR3D');

% euclidean distance: neighbours=3,centroids=20
noise = [0, 1, 2, 3, 4];
kidney = [97.83	96.74	96.74	63.04	34.24];
liver = [77.55	70.82	59.59	57.96	78.78];
lung = [100	100	100	100	100];
spleen = [83.8	76.32	50.16	26.48	3.738];
plot_accuracy( noise,kidney,liver,lung,spleen,'ROIs Classification No-AIDR3D');

% euclidean distance: neighbours=5,centroids=10
noise = [0, 1, 2, 3, 4];
kidney = [98.37	97.28	97.28	90.76	65.22];
liver = [59.8	57.35	55.1	54.9	54.08];
lung = [100	100	100	100	99.72];
spleen = [92.45	92.14	88.68	64.78	53.77];
plot_accuracy( noise,kidney,liver,lung,spleen,'ROIs Classification No-AIDR3D');

% euclidean distance: neighbours=5,centroids=20
noise = [0, 1, 2, 3, 4];
kidney = [96.74	96.74	87.5	53.26	41.3];
liver = [61.22	58.98	55.51	53.88	58.78];
lung = [100	100	100	99.45	99.18];
spleen = [93.4	91.82	90.25	76.1	92.14];
plot_accuracy( noise,kidney,liver,lung,spleen,'ROIs Classification No-AIDR3D');

% glcm

noise = [0, 1, 2, 3, 4];
kidney = [21.73913043	19.13043478	13.91304348	6.086956522	26.95652174];
liver = [64.53674121	63.57827476	70.28753994	63.25878594	54.63258786];
lung = [53.01724138	59.05172414	57.32758621	74.56896552	90.51724138];
spleen = [19.11764706	27.45098039	32.84313725	40.19607843	46.07843137];
plot_accuracy( noise,kidney,liver,lung,spleen,'ROIs Classification No-AIDR3D' );

% COMPARISON
% kidney
noise = [0, 1, 2, 3, 4];
chi_sqrt = [91.3	88.04	83.7	73.37	39.13];
eucli = [98.37	97.28	97.28	90.76	65.22];
stats = [21.73913043	19.13043478	13.91304348	6.086956522	26.95652174];
plot_roi( noise,chi_sqrt,eucli,stats,'Kidney')
% liver
noise = [0, 1, 2, 3, 4];
chi_sqrt = [60.61	59.39	53.06	52.86	42.65];
eucli = [77.55	70.82	59.59	57.96	78.78];
stats = [64.53674121	63.57827476	70.28753994	63.25878594	54.63258786];
plot_roi( noise,chi_sqrt,eucli,stats,'Liver')
% lung
noise = [0, 1, 2, 3, 4];
chi_sqrt = [100	100	100	100	100];
eucli = [100	100	100	100	100];
stats = [53.01724138	59.05172414	57.32758621	74.56896552	90.51724138];
plot_roi( noise,chi_sqrt,eucli,stats,'Lung')
% spleen
noise = [0, 1, 2, 3, 4];
chi_sqrt = [95.6	94.65	93.71	70.13	82.7];
eucli = [93.4	91.82	90.25	76.1	92.14];
stats = [19.11764706	27.45098039	32.84313725	40.19607843	46.07843137];
plot_roi( noise,chi_sqrt,eucli,stats,'Spleen')

