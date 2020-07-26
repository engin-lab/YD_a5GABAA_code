clear;
load('EE8task_performance.mat');
rew_col = task_perform{1, 1}.performance(:,1);

[pc, lt] = getestprobcorrect(rew_col, 0.25, 0);

    outbound_curve_witherr = pc(2:end,:);
    outbound_curve = pc(2:end,1);
    outbound_lowerr = pc(2:end,2);
    outbound_uperr = pc(2:end,3);
    outbound_learningtrial = lt;
    clr = 'r';
    clr2 = 'r';
    figure; hold on; 
    
    t = 1:size(pc,1)-1;
    %%% Plot data %%
    plot(t', pc(2:end,1),clr, 'Linewidth', 2);
    taxis = t';
    data=[pc(2:end,2),pc(2:end,3)];
    jbfill(taxis',pc(2:end,3)',pc(2:end,2)',clr,clr,1,1);
    plot(t', pc(2:end,2),[clr2,'--'], 'Linewidth', 2);
    plot(t', pc(2:end,3),[clr2,'--'], 'Linewidth', 2);
    
    %% Backgnd Prob
    %line([1 t(end)], [background_prob  background_prob ], 'k');
    plot(t, 0.25*ones(size(t)),'k', 'Linewidth', 2);
    
    %% Title
    titlefont = 18;
    title(['Trials'],'FontSize',titlefont,'Fontweight','normal');
    
    %% Axes Names
    xfont = 16;
    yfont = 16;
    xlabel('Trial Number','FontSize',xfont,'Fontweight','normal')
    ylabel('Probability of a Correct Response','FontSize',yfont,'Fontweight','normal')
    
     %% Axis
%     xlabmax = xax(end) - mod (xax(end),50); % Get max multiple of 50 that fits into axis
%     set(gca,'XTick',[0:50:xlabmax],'XTickLabel',num2str([0:50:xlabmax]'));
%     axis([1 t(end)  0 1.1]);
%     set(gca,'TickDir','out');