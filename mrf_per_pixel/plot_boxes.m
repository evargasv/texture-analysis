function plot_boxes( x,group,positions,xticklabel )
%PLOT_BOXES Summary of this function goes here
%   Detailed explanation goes here

    boxplot(x,group,'positions',positions);

    %set(gca,'xtick',[mean(positions(1:4)) mean(positions(5:8)) mean(positions(9:12))])
    set(gca,'xticklabel',xticklabel)

    color = ['r','m','y','c','r','m','y','c','r','m','y','c'];
    h = findobj(gca,'Tag','Box');
    for j=1:length(h), 
       patch(get(h(j),'XData'),get(h(j),'YData'),color(j),'FaceAlpha',.5);
    end

    c = get(gca, 'Children');
    grid on;
    title('Dice Coefficient');
    axis([0.75 2 0 1])
%     hleg1 = legend(c(1:4), 'kidneys', 'liver', 'lungs', 'spleen' );
%     set(gca,'LooseInset',get(gca,'TightInset'));
end

