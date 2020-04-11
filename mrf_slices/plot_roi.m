function [ output_args ] = plot_roi( noise,chi_sqrt,eucli,stats,gtitle )
%PLOT_ROI Summary of this function goes here
%   Detailed explanation goes here

    colorsjet = jet(10);
    figure;
    plot(noise,chi_sqrt,'s-','LineWidth',2,'Color',colorsjet(4,:),'MarkerSize',4);
    hold on;
    plot(noise,eucli,'v-','LineWidth',2,'Color',colorsjet(10,:),'MarkerSize',4);
    hold on;
    plot(noise,stats,'diamond-','LineWidth',2,'Color',[0 0.79 0],'MarkerSize',4);
    title(gtitle)
    grid on
    axis([0,4,0,105])
    xlabel('Noise Level')
    set(gca,'XTickLabel',{'0', '', '25', '', '50', '', '75', '', '88'})
    ylabel('Accuracy (%)')
    legend({'chi-squared','euclidean','stats'}, 'Location', 'SouthWest')

end

