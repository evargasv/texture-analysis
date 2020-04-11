% Author: Elizabeth Vargas
% E-mail: EVargas@tmvse.com
% Created: 04-05-2015, using MATLAB 8.4.0.150421 (R2014b)
% Modified: 04-05-2015
% Copyright 2015 Toshiba Medical Visualization Systems Europe (TMVS)

hist_1 = [1 4 3; 5 8 12; 2 9 7];
hist_2 = [9 13 5; 8 4 12; 9 20 10];

dsnt_acum = chi_sqrt_dstn( hist_1, hist_2 )
dist12=sum(KLDiv(hist_1, hist_2))
dist21=sum(KLDiv(hist_2, hist_1))
eu_dst = euclidean_distance( hist_1, hist_2  )

hist_1 = [1 4 3; 5 8 12; 2 9 7];
hist_2 = [0 0 0; 0 0 0; 0 0 0];

dsnt_acum = chi_sqrt_dstn( hist_1, hist_2 )
dist12=sum(KLDiv(hist_1, hist_2))
dist21=sum(KLDiv(hist_2, hist_1))
eu_dst = euclidean_distance( hist_1, hist_2  )

hist_1 = [1 0 0; 0 3 0; 0 2 0];
hist_2 = [0 0 0; 0 0 0; 0 0 0];

dsnt_acum = chi_sqrt_dstn( hist_1, hist_2 )
dist12=sum(KLDiv(hist_1, hist_2))
dist21=sum(KLDiv(hist_2, hist_1))
eu_dst = euclidean_distance( hist_1, hist_2  )

hist_1 = [1 4 3; 5 8 12; 2 9 7];
hist_2 = [90 130 50; 80 40 120; 90 200 100];

dsnt_acum = chi_sqrt_dstn( hist_1, hist_2 )
dist12=sum(KLDiv(hist_1, hist_2))
dist21=sum(KLDiv(hist_2, hist_1))
eu_dst = euclidean_distance( hist_1, hist_2  )