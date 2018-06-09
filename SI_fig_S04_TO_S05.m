clear all
close all
clc

% Figures S4 and Figure S5 - Performance of indirect reciprocity strategies
% with copy the better setup
% Panels of figure 4 are counted left to right, top to bottom:
% 1 2 3
% 4 5 6



load NS_16_URCRStudy_er.mat %_long

[sizeUR sizeCR dimREPL]=size(tconv);
prop_coop=number_true_cooperators./number_of_plays;

arrived_at=length(tconv); 
numNOTconverged=zeros(sizeUR,sizeCR);
RD_UD=zeros(sizeUR,sizeCR);
RD_TFT=zeros(sizeUR,sizeCR);
RD_CR=zeros(sizeUR,sizeCR);
RD_UR=zeros(sizeUR,sizeCR);
RD_UC=zeros(sizeUR,sizeCR);
RD_SJ=zeros(sizeUR,sizeCR); % set counters for relative dominance to zero for all types

for i=1:sizeUR
    for j=1:sizeCR
        numNOTconverged(i,j)=length(find(squeeze(tconv(i,j,:))>=tmax)); % (1)
        numNOTconverged(i,j)=numNOTconverged(i,j)/Niter;
        m_prop_coop(i,j)=mean(squeeze(prop_coop(i,j,:))); % (2)
        for z=1:dimREPL %(9)
            [~, pos_max]=max(squeeze(N_types(:,i,j,z)));
            if pos_max==1; RD_UD(i,j)=RD_UD(i,j)+1; end; % I update the counter of each types accordingly.
            if pos_max==2; RD_TFT(i,j)=RD_TFT(i,j)+1; end;
            if pos_max==3; RD_CR(i,j)=RD_CR(i,j)+1; end;
            if pos_max==4; RD_UR(i,j)=RD_UR(i,j)+1; end;
            if pos_max==5; RD_UC(i,j)=RD_UC(i,j)+1; end;
            if pos_max==6; RD_SJ(i,j)=RD_SJ(i,j)+1; end;
        end
        vct= [RD_UD(i,j) RD_TFT(i,j) RD_CR(i,j) RD_UR(i,j) RD_UC(i,j) RD_SJ(i,j)]; % (10)
        [~, DominantRelative(i,j)]=max(vct);
        
        N_UD(i,j)=length(find(squeeze(N_types(1,i,j,:))>(0.9*N)))/arrived_at; % (4-8)
        N_TFT(i,j)=length(find(squeeze(N_types(2,i,j,:))>(0.9*N)))/arrived_at;
        N_CR(i,j)=length(find(squeeze(N_types(3,i,j,:))>(0.9*N)))/arrived_at;
        N_UR(i,j)=length(find(squeeze(N_types(4,i,j,:))>(0.9*N)))/arrived_at;
        N_UC(i,j)=length(find(squeeze(N_types(5,i,j,:))>(0.9*N)))/arrived_at;
        N_SJ(i,j)=length(find(squeeze(N_types(6,i,j,:))>(0.9*N)))/arrived_at;
        N_NC(i,j)=(1-(N_UD(i,j)+N_TFT(i,j)+N_CR(i,j)+N_UR(i,j)+N_UC(i,j)+N_SJ(i,j))); % residual. Simulations that are not dominated.
        
        vct= [N_UD(i,j) N_TFT(i,j) N_CR(i,j) N_UR(i,j) N_UC(i,j) N_SJ(i,j)]; % (3)
        [Propdom_joined(i,j), DominantAbsolute(i,j)]=max(vct);
    end
end
RD_UD=RD_UD./Niter;
RD_TFT=RD_TFT./Niter;
RD_CR=RD_CR./Niter;
RD_UR=RD_UR./Niter;
RD_UC=RD_UC./Niter;
RD_SJ=RD_SJ./Niter;


% FIGURE S4 (PANEL 6) - PROPORTION OF SIMULATIONS WITHOUT ABSOLUTELY DOMINANT STRATEGY
fignum = figure(3);
axes1 = axes('Parent',fignum);
hold(axes1,'on');
set(axes1,'FontSize',18);
xlim([-0.025 0.525]);
ylim([-0.025 0.525]);
imagesc(Prop_UR,Prop_CR,N_NC);
colorbar
set(gca, 'CLim', [0, 1]);
set(gca,'YDir','normal')
xlabel('Prop UR','FontSize',18);
ylabel('Prop CR','FontSize',18);
tt=['BetterInitial Proportions of UR and CR - No Dominance'];
title({'Initial Proportions of UR and CR','No Dominance'},'FontSize',18) 
fn=tt(~isspace(tt));
saveas(fignum,fn);
print('-depsc', fn);

% FIGURE S4 (PANEL 5) - PROPORTION OF SIMULATIONS DOMINATED BY UD
fignum = figure(4);
axes1 = axes('Parent',fignum);
hold(axes1,'on');
set(axes1,'FontSize',18);
xlim([-0.025 0.525]);
ylim([-0.025 0.525]);
imagesc(Prop_UR,Prop_CR,N_UD);
colorbar
set(gca, 'CLim', [0, 1]);
set(gca,'YDir','normal')
xlabel('Prop UR','FontSize',18);
ylabel('Prop CR','FontSize',18);
tt=['BetterInitial Proportions of UR and CR - Proportion Dominated by UD'];
title({'Initial Proportions of UR and CR','Proportion Dominated by UD'},'FontSize',18) 
fn=tt(~isspace(tt));
saveas(fignum,fn);
print('-depsc', fn);



% FIGURE S4 (PANEL 4) - PROPORTION OF SIMULATIONS DOMINATED BY UC
fignum = figure(6);
axes1 = axes('Parent',fignum);
hold(axes1,'on');
set(axes1,'FontSize',18);
xlim([-0.025 0.525]);
ylim([-0.025 0.525]);
imagesc(Prop_UR,Prop_CR,N_UC);
colorbar
set(gca, 'CLim', [0, 1]);
set(gca,'YDir','normal')
xlabel('Prop UR','FontSize',18);
ylabel('Prop CR','FontSize',18);
tt=['BetterInitial Proportions of UR and CR - Proportion Dominated by UC'];
title({'Initial Proportions of UR and CR','Proportion Dominated by UC'},'FontSize',18) 
fn=tt(~isspace(tt));
saveas(fignum,fn);
print('-depsc', fn);

% FIGURE S4 (PANEL 3) - PROPORTION OF SIMULATIONS DOMINATED BY SJ
fignum = figure(7);
axes1 = axes('Parent',fignum);
hold(axes1,'on');
set(axes1,'FontSize',18);
xlim([-0.025 0.525]);
ylim([-0.025 0.525]);
imagesc(Prop_UR,Prop_CR,N_SJ);
colorbar
set(gca, 'CLim', [0, 1]);
set(gca,'YDir','normal')
xlabel('Prop UR','FontSize',18);
ylabel('Prop CR','FontSize',18);
tt=['BetterInitial Proportions of UR and CR - Proportion Dominated by SJ'];
title({'Initial Proportions of UR and CR','Proportion Dominated by SJ'},'FontSize',18) 
fn=tt(~isspace(tt));
saveas(fignum,fn);
print('-depsc', fn);


% FIGURE S4 (PANEL 2) - PROPORTION OF SIMULATIONS DOMINATED BY UR
fignum = figure(8);
axes1 = axes('Parent',fignum);
hold(axes1,'on');
set(axes1,'FontSize',18);
xlim([-0.025 0.525]);
ylim([-0.025 0.525]);
imagesc(Prop_UR,Prop_CR,N_UR);
colorbar
set(gca, 'CLim', [0, 1]);
set(gca,'YDir','normal')
xlabel('Prop UR','FontSize',18);
ylabel('Prop CR','FontSize',18);
tt=['BetterInitial Proportions of UR and CR - Proportion Dominated by UR'];
title({'Initial Proportions of UR and CR','Proportion Dominated by UR'},'FontSize',18) 
fn=tt(~isspace(tt));
saveas(fignum,fn);
print('-depsc', fn);

% FIGURE S4 (PANEL 1) - PROPORTION OF SIMULATIONS DOMINATED BY CR
fignum = figure(9);
axes1 = axes('Parent',fignum);
hold(axes1,'on');
set(axes1,'FontSize',18);
xlim([-0.025 0.525]);
ylim([-0.025 0.525]);
imagesc(Prop_UR,Prop_CR,N_CR);
colorbar
set(gca, 'CLim', [0, 1]);
set(gca,'YDir','normal')
xlabel('Prop UR','FontSize',18);
ylabel('Prop CR','FontSize',18);
tt=['BetterInitial Proportions of UR and CR - Proportion Dominated by CR'];
title({'Initial Proportions of UR and CR','Proportion Dominated by CR'},'FontSize',18) 
fn=tt(~isspace(tt));
saveas(fignum,fn);
print('-depsc', fn);


% FIGURE S5 (LEFT PANEL) - PROPORTION OF COOPERATORS

fignum = figure(10);
axes1 = axes('Parent',fignum);
hold(axes1,'on');
box(axes1,'on');
% Set the remaining axes properties
set(axes1,'FontSize',18,'Layer','top','YTick',[0 0.1 0.2 0.3 0.4 0.5],...
    'YTickLabel',{'0','0.1','0.2','0.3','0.4','0.5'});
xlim([-0.025 0.525]);
ylim([-0.025 0.525]);
imagesc(Prop_UR,Prop_CR,m_prop_coop);
colorbar
set(gca, 'CLim', [0, 1]);
set(gca,'YDir','normal')
xlabel('Prop UR','FontSize',18);
ylabel('Prop CR','FontSize',18);
tt=['BetterInitial Proportions of UR and CR - Proportion Cooperators'];
title({'Indirect Reciprocity','Proportion of Cooperators'},'FontSize',18) 
fn=tt(~isspace(tt));
saveas(fignum,fn);
print('-depsc', fn);
% 
for i=1:sizeUR
    for j=1:sizeCR
        if DominantAbsolute(i,j)==1; toprint(i,j)=1; end
        if DominantAbsolute(i,j)==3; toprint(i,j)=2; end
        if DominantAbsolute(i,j)==4; toprint(i,j)=3; end
        if DominantAbsolute(i,j)==5; toprint(i,j)=4; end
        if DominantAbsolute(i,j)==6; toprint(i,j)=5; end
    end
end

% FIGURE S5 (RIGHT PANEL) - STRATEGY DOMINATING THE MOST FREQUENTLY
fignum=figure(11);
hSurf=imagesc(Prop_UR,Prop_CR,toprint); % This is the command to make a shaded contour plot
hSurfAx=(gca);
cRange= caxis; % get the default color map for the data range

tt=['BetterInitial Proportions of UR and CR - Type dominating more often'];
% Set the remaining axes properties
set(gca,'FontSize',18,'Layer','top','YTick',[0 0.1 0.2 0.3 0.4 0.5],'YTickLabel',{'0','0.1','0.2','0.3','0.4','0.5'});
xlim([0 0.50]);
ylim([0 0.50]);
set(gca,'YDir','normal')
hold all
% Then add contour lines with appropriate Z data (I am overlaying temperature on other parameters):
 [C,hT]= contour(Prop_UR,Prop_CR, Propdom_joined, '-k','ShowText','on','LineWidth',2);
    hLines=findobj(gca, 'type', 'line'); % find all the separate lines on contour plot.
    set(hLines, 'LineWidth', 8); % and set their width.
    clabel(C,hT,'FontSize',14);

% Then reset the color axis according to the range determined above:
mymap = [1 1 1
1 0 0
    0 1 0
    0 0 1
    0 0 0 ];
caxis([1, 5])
cb=colormap(mymap);
set(gca, 'CLim', [1, 6]);
%set(cb,'Ticks',[1,2,3,4,5],'TickLabels',{'UD','CR','UR','UC','SJ'});
 colorbar('Location','eastoutside','Ticks',[1.5,2.5,3.5,4.5,5.5],'TickLabels',{'UD','CR','UR',...
     'UC','SJ'},'TickLabelInterpreter','latex')
xlabel('Prop UR','FontSize',18);
ylabel('Prop CR','FontSize',18);
title({'Indirect Reciprocity','Strategy dominating most frequently'},'FontSize',18) 
fn=tt(~isspace(tt));
saveas(fignum,fn);
print('-depsc', fn);