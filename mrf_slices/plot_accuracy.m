function plot_accuracy( noise,kidney,liver,lung,spleen,ptitle )
%PLOT_ACCURACY Summary of this function goes here
%   Detailed explanation goes here
%
% ------
% Author: Elizabeth Vargas
% E-mail: EVargas@tmvse.com
% Created: 20-05-2015, using MATLAB 8.4.0.150421 (R2014b)
% Modified: 20-05-2015
% Copyright 2015 Toshiba Medical Visualization Systems Europe (TMVS)

    linecolors = prism(50);
    colorsjet = jet(20);

    figure;
    plot(noise,kidney,'s-','LineWidth',2,'Color',colorsjet(6,:),'MarkerSize',4);
    hold on;
    plot(noise,liver,'v-','LineWidth',2,'Color',linecolors(2,:),'MarkerSize',4);
    hold on;
    plot(noise,lung,'diamond-','LineWidth',2,'Color',linecolors(30,:),'MarkerSize',4);
    hold on;
    plot(noise,spleen,'*-','LineWidth',2,'Color',linecolors(1,:),'MarkerSize',4);

    title(ptitle)
    grid on
    axis([0,4,0,105])
    xlabel('Noise Level')
    set(gca,'XTickLabel',{'0', '', '25', '', '50', '', '75', '', '88'})
    ylabel('Accuracy (%)')
    legend({'kidney','liver','lung','spleen'}, 'Location', 'SouthWest')

end

