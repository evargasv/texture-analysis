%
% ------
% Author: Elizabeth Vargas
% E-mail: EVargas@tmvse.com
% Created: 06-05-2015, using MATLAB 8.4.0.150421 (R2014b)
% Modified: 06-05-2015
% Copyright 2015 Toshiba Medical Visualization Systems Europe (TMVS)



result_3 = [95, 83.75, 95];
result_5 = [97.5 82.5 96.25];
result_7 = [96.25 82.5 97.5];

figure;
bar([result_3;result_5;result_7]);
colormap(parula)
title('UdG Dataset')
grid on
xlabel('Neighbourhood Size')
set(gca,'XTickLabel',{'3', '5', '7'})
ylabel('Accuracy (%)')
legend('255 bins,10 centroids','128 bins,10 centroids','256 bins,20 centroids')