classdef Test_MRF < matlab.unittest.TestCase
%TEST Unit test of the MRF classifier
%   The list of implemented test is the following:
%     1. Read a neighbourhood around a pixel of a generic size. The
%        neighbourhood values used for the test were 3 and 5.
%     2. Calculation of the euclidean distance between one texton and a
%        dictionary, in order to determine the closest texton in the
%        dictionary. It returns the index of that element.
%
% ------
% Author: Elizabeth Vargas
% E-mail: EVargas@tmvse.com
% Created: 11-02-2015, using MATLAB 8.4.0.150421 (R2014b)
% Modified: 13-02-2015
% Copyright 2015 Toshiba Medical Visualization Systems Europe (TMVS)

    
    properties
    end
    
    methods (Test)
        
        % test neighbours_extraction method using a 3 by 3 neighbourhood
        function test_neighbours_extractionn_3(tc)
            img = [1 2 3 4; 5 6 7 8;9 10 11 12;13 14 15 16];
            nbr_size = 3;
            [actTextons,actCenters] = neighbours_extraction(img, nbr_size);
            expTextons = [1 5 9 2 10 3 7 11; 2 6 10 3 11 4 8 12;
                          5 9 13 6 14 7 11 15; 6 10 14 7 15 8 12 16];
            expCenters = [6;7;10;11];
            tc.verifyEqual(actTextons, expTextons);
            tc.verifyEqual(actCenters, expCenters);
        end
        
        % test neighbours_extraction method using a 5 by 5 neighbourhood
        function test_neighbours_extraction_5(tc)
            img = [1 2 3 4 5 6; 7 8 9 10 11 12; 13 14 15 16 17 18; 19 ...
                   20 21 22 23 24; 25 26 27 28 29 30; 31 32 33 34 35 36];
            nbr_size = 5;
            [act_textons,act_centers] = neighbours_extraction(img,nbr_size);
            exp_textons = [1 7 13 19 25 2 8 14 20 26 3 9 21 27 4 10 16 ...
                           22 28 5 11 17 23 29; 2 8 14 20 26 3 9 15 21 ...
                           27 4 10 22 28 5 11 17 23 29 6 12 18 24 30; 7 ...
                           13 19 25 31 8 14 20 26 32 9 15 27 33 10 16 ...
                           22 28 34 11 17 23 29 35; 8 14 20 26 32 9 15 ...
                           21 27 33 10 16 28 34 11 17 23 29 35 12 18 24 ...
                           30 36];
            exp_centers = [15;16;21;22];
            tc.verifyEqual(act_textons, exp_textons);
            tc.verifyEqual(act_centers, exp_centers);
        end
        
        % test label_pixel using a dictionary size of 4 and a texton size
        % of 5
        function test_label_pixel_4_5(tc)
            texton = [3 4 8 10 15];
            dictionary = [100 500 200 400 800; 1 1 1 1 1;
                          2 5 7 9 14; 400 50 90 40 30];
            act_texton_idx = label_pixel( dictionary, texton );
            exp_texton_idx = 3;
            tc.verifyEqual(act_texton_idx, exp_texton_idx);
        end
        
        % test label_pixel using a dictionary size of 3 and a texton size
        % of 8
        function test_label_pixel_3_8(tc)
            texton = [1 4 6 2 7 3 5 8];
            dictionary = [0 3 5 1 6 2 4 7; 3 11 8 4 9 21 31 81;
                          900 20 800 40 50 90 34 101];
            act_texton_idx = label_pixel( dictionary, texton );
            exp_texton_idx = 1;
            tc.verifyEqual(act_texton_idx, exp_texton_idx);
        end
        
        % test the calculation of the 2D histogram
        function test_generate_2D_histogram(tc)
            textons_img = [1 4 6 2 7 3 5 8; 2 10 7 3 8 20 30 80];
            central_px = [10; 5];
            dict_textons = [0 3 5 1 6 2 4 7; 3 11 8 4 9 21 31 81;
                            900 20 800 40 50 90 34 101];
            exp_img_model = zeros(3,255);
            exp_img_model(1,11) = 1;
            exp_img_model(2,6) = 1;            
            act_img_model = generate_2D_histogram( textons_img,central_px,dict_textons,0:255);
            tc.verifyEqual(act_img_model, exp_img_model);
        end
        
        % test the calculation of the chi squared distance between 2D
        % histograms
        function test_chi_sqrt_dstn(tc)
            hist_1 = [1 4 3; 5 8 12; 2 9 7];
            hist_2 = [9 13 5; 8 4 12; 9 20 10];
            exp_dsnt_acum = 11.4216;
            act_dsnt_acum = chi_sqrt_dstn( hist_1, hist_2 );    
            tc.verifyEqual(act_dsnt_acum, exp_dsnt_acum, 'AbsTol', 0.05);
        end
        
        % test the calculation of the chi squared distance between 2D
        % histograms, when there is zero at the same positions
        function test_chi_sqrt_dstn_zero(tc)
            hist_1 = [1 4 0; 5 8 12; 2 9 7];
            hist_2 = [9 13 0; 8 4 12; 9 20 10];
            exp_dsnt_acum = 11.1716;
            act_dsnt_acum = chi_sqrt_dstn( hist_1, hist_2 );    
            tc.verifyEqual(act_dsnt_acum, exp_dsnt_acum, 'AbsTol', 0.05);
        end
    end 
end













