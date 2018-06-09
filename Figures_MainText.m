% Creates all figures in the main text of Righi S., Takacs K. (2018) "Social Closure and the Evolution of
% Cooperation via Indirect Reciprocity", Scientific Reports.


% Figure 2: Effect of the Initial Proportion of UR and CR strategies. Left Panel: Final average proportion of cooperators. Right
% Panel: Strategy that is dominating more often (colors) and proportion of simulations dominated by that strategy (lines). For
%each parameter combination 100 simulations were run on E-R random networks of 240 individuals with P_link = 0.10. Pevo = 0:05
%and Pfor = 0. The initial proportion of UR is indicated on the x-axis and the initial proportion of CR on the y-axis. The
% remaining population is initialized as equally divided among UC, UD, and SJ strategies (TFT is absent).

clear all
close all
clc

load NS_04_URCRStudy.mat %_long

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

for i=1:sizeUR
    for j=1:sizeCR
        % keep track of the strenght of absolute dominances (proportion)
        if DominantAbsolute(i,j) == 1; Prop_dom_UD(i,j)= N_UD(i,j); else; Prop_dom_UD(i,j)=NaN; end
        if DominantAbsolute(i,j) == 2; Prop_dom_TFT(i,j)= N_TFT(i,j); else; Prop_dom_TFT(i,j)=NaN; end
        if DominantAbsolute(i,j) == 3; Prop_dom_CR(i,j)= N_CR(i,j); else; Prop_dom_CR(i,j)=NaN; end
        if DominantAbsolute(i,j) == 4; Prop_dom_UR(i,j)= N_UR(i,j); else; Prop_dom_UR(i,j)=NaN; end
        if DominantAbsolute(i,j) == 5; Prop_dom_UC(i,j)= N_UC(i,j); else; Prop_dom_UC(i,j)=NaN; end
        if DominantAbsolute(i,j) == 6; Prop_dom_SJ(i,j)= N_SJ(i,j); else; Prop_dom_SJ(i,j)=NaN; end
    end
end


% i could also rapresent with darker color the ones where the dominat type
% is more dominant (not done yet)

% % (1) proporzione di converged 
% fignum = figure(1);
% axes1 = axes('Parent',fignum);
% hold(axes1,'on');
% box(axes1,'on');
% % Set the remaining axes properties
% set(axes1,'FontSize',25,'Layer','top','YTick',[0 0.1 0.2 0.3 0.4 0.5],...
%     'YTickLabel',{'0','0.1','0.2','0.3','0.4','0.5'});
% xlim([-0.025 0.525]);
% ylim([-0.025 0.525]);
% imagesc(Prop_UR,Prop_CR,numNOTconverged);% CONTROL POSITION OF ANCILLARY VARIABLES
% colorbar
% set(gca, 'CLim', [0, 1]);
% set(gca,'YDir','normal')
% xlabel('Prop UR','FontSize',25);
% ylabel('Prop CR','FontSize',25);
% tt=['Fig1a_Initial Proportions of UR and CR - Proportion Not converged'];
% title({'Initial Proportions of UR and CR','Proportion Not converged'},'FontSize',25) 
% fn=tt(~isspace(tt));
% saveas(fignum,fn);
% print('-depsc', fn);


% % (2) Proportion Cooperators (FIGURE 2: LEFT PANEL)
fignum = figure(2);
axes1 = axes('Parent',fignum);
hold(axes1,'on');
box(axes1,'on');
% Set the remaining axes properties
set(axes1,'FontSize',18,'Layer','top','YTick',[0 0.1 0.2 0.3 0.4 0.5],...
    'YTickLabel',{'0','0.1','0.2','0.3','0.4','0.5'});
xlim([-0.025 0.525]);
ylim([-0.025 0.525]);
imagesc(Prop_UR,Prop_CR,m_prop_coop);% CONTROL POSITION OF ANCILLARY VARIABLES
colorbar
set(gca, 'CLim', [0, 1]);
set(gca,'YDir','normal')
xlabel('Prop UR','FontSize',25);
ylabel('Prop CR','FontSize',25);
tt=['Fig1b_Initial Proportions of UR and CR - Proportion Cooperators'];
title({'Indirect Reciprocity','Proportion of Cooperators'},'FontSize',25) 
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

% FIGURE 2- RIGHT PANEL: (STRATEGY THAT WINS MOST OFTEN)
fignum=figure(3)
hSurf=imagesc(Prop_UR,Prop_CR,toprint); % This is the command to make a shaded contour plot
hSurfAx=(gca);
cRange= caxis; % get the default color map for the data range

tt=['Fig1c_Initial Proportions of UR and CR - Type dominating more often'];
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
xlabel('Prop UR','FontSize',25);
ylabel('Prop CR','FontSize',25);
title({'Indirect Reciprocity','Strategy dominating most frequently'},'FontSize',25) 
fn=tt(~isspace(tt));
saveas(fignum,fn);
print('-depsc', fn);


%%%%%%%%
%%% FIGURE 3
%%%%%%%
% I counnt panels of figure 3 left to right, top to bottom:
%1 2 3 4
%5 6 7 8

% FIGURE 3 - PANEL 3: EFFECT OF FORGIVENESS IN A COPY THE BEST SETTING
clear all
clc

load NS_05_PforStudy.mat % _long

[~, sizeIC, sizeKV, sizeREPL]=size(N_types);
prop_coop=number_true_cooperators./number_of_plays;

arrived_at=length(tconv); 
numNOTconverged=zeros(sizeIC,sizeKV);
RD_UD=zeros(sizeIC,sizeKV);
RD_TFT=zeros(sizeIC,sizeKV);
RD_CR=zeros(sizeIC,sizeKV);
RD_UR=zeros(sizeIC,sizeKV);
RD_UC=zeros(sizeIC,sizeKV); 
RD_SJ=zeros(sizeIC,sizeKV); % set counters for relative dominance to zero for all types

for i=1:sizeIC
    for j=1:sizeKV
        numNOTconverged(i,j)=length(find(squeeze(tconv(i,j,:))>=tmax)); % (1)
        numNOTconverged(i,j)=numNOTconverged(i,j)/Niter;
        m_prop_coop(i,j)=mean(squeeze(prop_coop(i,j,:))); % (2)
        std_prop_coop(i,j)=std(squeeze(prop_coop(i,j,:)));
        for z=1:sizeREPL %(9)
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
        [~, DominantAbsolute(i,j)]=max(vct);
    end
end
RD_UD=RD_UD./Niter;
RD_TFT=RD_TFT./Niter;
RD_CR=RD_CR./Niter;
RD_UR=RD_UR./Niter;
RD_UC=RD_UC./Niter;
N_SJ=N_SJ./Niter;


fignum = figure(4);
axes1 = axes('Parent',fignum);
hold(axes1,'on');
box(axes1,'on');
errorbar(Pfor,m_prop_coop(1,:),std_prop_coop(1,:),'r');
hold on
errorbar(Pfor,m_prop_coop(2,:),std_prop_coop(2,:),'k');
hold on
%errorbar(Pfor,m_prop_coop(3,:),std_prop_coop(3,:),'b');
%hold on
%errorbar(Pfor,m_prop_coop(4,:),std_prop_coop(4,:),'g');
%hold on
set(axes1,'FontSize',18);
ylim([0,1]);
xlim([-0.01,1.01]);
xlabel(' ','FontSize',25);
ylabel('Prop. of Cooperators','FontSize',25);
%legend('TFT=CR=UR=UD=UC=SJ=1/6','TFT=0, CR=UR=UD=UC=SJ=1/5','Location','best'); 
tt=['Fig2a_Effect of P_{for} - Proportion of cooperators'];
title({'Effect of Forgiveness','Copy the Best'},'FontSize',25) 
fn=tt(~isspace(tt));
fn=strrep(fn,'_{','');
fn=strrep(fn,'}','');
saveas(fignum,fn);
print('-depsc', fn);

%%%

% FIGURE 3 - PANEL 4: EFFECT EVOLUTIONARY PRESSURE IN A COPY THE BEST SETTING
clear all
clc

load NS_08_PevoStudy.mat % _long

[~, sizeIC, sizeKV, sizeREPL]=size(N_types);
prop_coop=number_true_cooperators./number_of_plays;

arrived_at=length(tconv); 
numNOTconverged=zeros(sizeIC,sizeKV);
RD_UD=zeros(sizeIC,sizeKV);
RD_TFT=zeros(sizeIC,sizeKV);
RD_CR=zeros(sizeIC,sizeKV);
RD_UR=zeros(sizeIC,sizeKV);
RD_UC=zeros(sizeIC,sizeKV); 
RD_SJ=zeros(sizeIC,sizeKV); % set counters for relative dominance to zero for all types

for i=1:sizeIC
    for j=1:sizeKV
        numNOTconverged(i,j)=length(find(squeeze(tconv(i,j,:))>=tmax)); % (1)
        numNOTconverged(i,j)=numNOTconverged(i,j)/Niter;
        m_prop_coop(i,j)=mean(squeeze(prop_coop(i,j,:))); % (2)
        std_prop_coop(i,j)=std(squeeze(prop_coop(i,j,:)));
        for z=1:sizeREPL %(9)
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
        [~, DominantAbsolute(i,j)]=max(vct);
    end
end
RD_UD=RD_UD./Niter;
RD_TFT=RD_TFT./Niter;
RD_CR=RD_CR./Niter;
RD_UR=RD_UR./Niter;
RD_UC=RD_UC./Niter;
RD_SJ=RD_SJ./Niter;

% (1) Proportion of true cooperators
fignum = figure(5);
axes1 = axes('Parent',fignum);
hold(axes1,'on');
box(axes1,'on');
errorbar(Pevo,m_prop_coop(1,:),std_prop_coop(1,:),'r');
hold on
errorbar(Pevo,m_prop_coop(2,:),std_prop_coop(2,:),'k');
%hold on
%errorbar(Pevo,m_prop_coop(3,:),std_prop_coop(3,:),'b');
%hold on
%errorbar(Pevo,m_prop_coop(4,:),std_prop_coop(4,:),'g');
%hold on
set(axes1,'FontSize',18);
ylim([0,1]);
xlim([-0.01,0.22]);
xlabel(' ','FontSize',25);
ylabel(' ','FontSize',25);
%legend('TFT=CR=UR=UD=UC=SJ=1/6','TFT=0, CR=UR=UD=UC=SJ=1/5','Location','best');  
tt=['Fig2b_Effect of P_{evo} - Proportion of cooperators'];
title({'Effect of Evolution','Copy the Best'},'FontSize',25) 
fn=tt(~isspace(tt));
fn=strrep(fn,'_{','');
fn=strrep(fn,'}','');
saveas(fignum,fn);
print('-depsc', fn);



% FIGURE 3 - PANEL 1: EFFECT OF POPULATION SIZE IN A COPY THE BEST SETTING
clear all
clc

load NS_09_NStudy.mat

[~, sizeIC, sizeKV, sizeREPL]=size(N_types);
prop_coop=number_true_cooperators./number_of_plays;

arrived_at=length(tconv); 
numNOTconverged=zeros(sizeIC,sizeKV);
RD_UD=zeros(sizeIC,sizeKV);
RD_TFT=zeros(sizeIC,sizeKV);
RD_CR=zeros(sizeIC,sizeKV);
RD_UR=zeros(sizeIC,sizeKV);
RD_UC=zeros(sizeIC,sizeKV); 
RD_SJ=zeros(sizeIC,sizeKV);% set counters for relative dominance to zero for all types

for i=1:sizeIC
    for j=1:sizeKV
        numNOTconverged(i,j)=length(find(squeeze(tconv(i,j,:))>=tmax)); % (1)
        numNOTconverged(i,j)=numNOTconverged(i,j)/Niter;
        m_prop_coop(i,j)=mean(squeeze(prop_coop(i,j,:))); % (2)
        std_prop_coop(i,j)=std(squeeze(prop_coop(i,j,:)));
        for z=1:sizeREPL %(9)
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
        
        N_UD(i,j)=length(find(squeeze(N_types(1,i,j,:))>(0.9*N(j))))/arrived_at; % (4-8)
        N_TFT(i,j)=length(find(squeeze(N_types(2,i,j,:))>(0.9*N(j))))/arrived_at;
        N_CR(i,j)=length(find(squeeze(N_types(3,i,j,:))>(0.9*N(j))))/arrived_at;
        N_UR(i,j)=length(find(squeeze(N_types(4,i,j,:))>(0.9*N(j))))/arrived_at;
        N_UC(i,j)=length(find(squeeze(N_types(5,i,j,:))>(0.9*N(j))))/arrived_at;
        N_SJ(i,j)=length(find(squeeze(N_types(6,i,j,:))>(0.9*N(j))))/arrived_at;
        N_NC(i,j)=(1-(N_UD(i,j)+N_TFT(i,j)+N_CR(i,j)+N_UR(i,j)+N_UC(i,j)+N_SJ(i,j))); % residual. Simulations that are not dominated.
        
        vct= [N_UD(i,j) N_TFT(i,j) N_CR(i,j) N_UR(i,j) N_UC(i,j) N_SJ(i,j)]; % (3)
        [~, DominantAbsolute(i,j)]=max(vct);
    end
end
RD_UD=RD_UD./Niter;
RD_TFT=RD_TFT./Niter;
RD_CR=RD_CR./Niter;
RD_UR=RD_UR./Niter;
RD_UC=RD_UC./Niter;
RD_SJ=RD_SJ./Niter;

% (1) Proportion of true cooperators
fignum = figure(6);
axes1 = axes('Parent',fignum);
hold(axes1,'on');
box(axes1,'on');
errorbar(N,m_prop_coop(1,:),std_prop_coop(1,:),'r');
hold on
errorbar(N,m_prop_coop(2,:),std_prop_coop(2,:),'k');
hold on
%errorbar(N,m_prop_coop(3,:),std_prop_coop(3,:),'b');
%hold on
%errorbar(N,m_prop_coop(4,:),std_prop_coop(4,:),'g');
hold on
set(axes1,'FontSize',18);
ylim([0,1]);
xlim([N(1)-5,N(end)+5]);
xlabel(' ','FontSize',25);
ylabel(' ','FontSize',25);
%legend('TFT=CR=UR=UD=UC=SJ=1/6','TFT=0, CR=UR=UD=UC=SJ=1/5','Location','best'); 
tt=['Fig2c_Effect of Population Size - Proportion of cooperators'];
title({'Effect of Population Size','Copy the Best'},'FontSize',25)
fn=tt(~isspace(tt));
fn=strrep(fn,'_{','');
fn=strrep(fn,'}','');
saveas(fignum,fn);
print('-depsc', fn);



% FIGURE 3 - PANEL 2: EFFECT OF NETWORK DENSITY IN A COPY THE BEST SETTING
clear all
clc

load NS_10_Density.mat % _long

[~, sizeIC, sizeKV, sizeREPL]=size(N_types);
prop_coop=number_true_cooperators./number_of_plays;

arrived_at=length(tconv); 
numNOTconverged=zeros(sizeIC,sizeKV);
RD_UD=zeros(sizeIC,sizeKV);
RD_TFT=zeros(sizeIC,sizeKV);
RD_CR=zeros(sizeIC,sizeKV);
RD_UR=zeros(sizeIC,sizeKV);
RD_UC=zeros(sizeIC,sizeKV);
RD_SJ=zeros(sizeIC,sizeKV);% set counters for relative dominance to zero for all types

for i=1:sizeIC
    for j=1:sizeKV
        numNOTconverged(i,j)=length(find(squeeze(tconv(i,j,:))>=tmax)); % (1)
        numNOTconverged(i,j)=numNOTconverged(i,j)/Niter;
        sq=squeeze(prop_coop(i,j,:)); 
        m_prop_coop(i,j)=mean(sq(find(~isnan(sq)))); % (2)
        std_prop_coop(i,j)=std(sq(find(~isnan(sq))));
        for z=1:sizeREPL %(9)
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
        [~, DominantAbsolute(i,j)]=max(vct);
    end
end
RD_UD=RD_UD./Niter;
RD_TFT=RD_TFT./Niter;
RD_CR=RD_CR./Niter;
RD_UR=RD_UR./Niter;
RD_UC=RD_UC./Niter;
RD_SJ=RD_SJ./Niter;

% (1) Proportion of true cooperators
fignum = figure(7);
axes1 = axes('Parent',fignum);
hold(axes1,'on');
box(axes1,'on');
set(axes1,'FontSize',18);
errorbar(P_Link,m_prop_coop(1,:),std_prop_coop(1,:),'r');
hold on
errorbar(P_Link,m_prop_coop(2,:),std_prop_coop(2,:),'k');
ylim([0,1]);
xlim([min(P_Link)-0.005,max(P_Link)+0.005]);
xlabel(' ','FontSize',25);
ylabel(' ','FontSize',25);
%legend('TFT=CR=UR=UD=UC=SJ=1/6','TFT=0, CR=UR=UD=UC=SJ=1/5','Location','best');  
tt=['Fig2d_Effect of Network Density - Proportion of cooperators'];
title({'Effect of Network Density','Copy the Best'},'FontSize',25)
fn=tt(~isspace(tt));
fn=strrep(fn,'_{','');
fn=strrep(fn,'}','');
saveas(fignum,fn);
print('-depsc', fn);


% FIGURE 3 - PANEL 7: EFFECT OF FORGIVENESS IN A COPY THE BETTER SETTING
clear all
clc

load NS_17_PforStudy_er.mat % _long

[~, sizeIC, sizeKV, sizeREPL]=size(N_types);
prop_coop=number_true_cooperators./number_of_plays;

arrived_at=length(tconv); 
numNOTconverged=zeros(sizeIC,sizeKV);
RD_UD=zeros(sizeIC,sizeKV);
RD_TFT=zeros(sizeIC,sizeKV);
RD_CR=zeros(sizeIC,sizeKV);
RD_UR=zeros(sizeIC,sizeKV);
RD_UC=zeros(sizeIC,sizeKV); 
RD_SJ=zeros(sizeIC,sizeKV); % set counters for relative dominance to zero for all types

for i=1:sizeIC
    for j=1:sizeKV
        numNOTconverged(i,j)=length(find(squeeze(tconv(i,j,:))>=tmax)); % (1)
        numNOTconverged(i,j)=numNOTconverged(i,j)/Niter;
        m_prop_coop(i,j)=mean(squeeze(prop_coop(i,j,:))); % (2)
        std_prop_coop(i,j)=std(squeeze(prop_coop(i,j,:)));
        for z=1:sizeREPL %(9)
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
        [~, DominantAbsolute(i,j)]=max(vct);
    end
end
RD_UD=RD_UD./Niter;
RD_TFT=RD_TFT./Niter;
RD_CR=RD_CR./Niter;
RD_UR=RD_UR./Niter;
RD_UC=RD_UC./Niter;
N_SJ=N_SJ./Niter;

% (1) Proportion of true cooperators
fignum = figure(8);
axes1 = axes('Parent',fignum);
hold(axes1,'on');
box(axes1,'on');
set(axes1,'FontSize',18);
errorbar(Pfor,m_prop_coop(1,:),std_prop_coop(1,:),'r');
hold on
errorbar(Pfor,m_prop_coop(2,:),std_prop_coop(2,:),'k');
%hold on
%errorbar(Pfor,m_prop_coop(3,:),std_prop_coop(3,:),'b');
%hold on
%errorbar(Pfor,m_prop_coop(4,:),std_prop_coop(4,:),'g');
%hold on
ylim([0,1]);
xlim([-0.01,1.01]);
xlabel('Prob. Forgiveness','FontSize',25);
ylabel('Prop. of Cooperators','FontSize',25);
legend('TFT=CR=UR=UD=UC=SJ=1/6','TFT=0, CR=UR=UD=UC=SJ=1/5','Location','best');
tt=['Fig2e_ER Effect of P_{for} - Proportion of cooperators'];
title({' ','Copy the Better'},'FontSize',25) 
fn=tt(~isspace(tt));
fn=strrep(fn,'_{','');
fn=strrep(fn,'}','');
saveas(fignum,fn);
print('-depsc', fn);


% FIGURE 3 - PANEL 8: EFFECT OF EVOLUTIONARY PRESSURE IN A COPY THE BETTER SETTING

clear all
clc

load NS_19_PevoStudy_er.mat % _long

[~, sizeIC, sizeKV, sizeREPL]=size(N_types);
prop_coop=number_true_cooperators./number_of_plays;

arrived_at=length(tconv); 
numNOTconverged=zeros(sizeIC,sizeKV);
RD_UD=zeros(sizeIC,sizeKV);
RD_TFT=zeros(sizeIC,sizeKV);
RD_CR=zeros(sizeIC,sizeKV);
RD_UR=zeros(sizeIC,sizeKV);
RD_UC=zeros(sizeIC,sizeKV); 
RD_SJ=zeros(sizeIC,sizeKV); % set counters for relative dominance to zero for all types

for i=1:sizeIC
    for j=1:sizeKV
        numNOTconverged(i,j)=length(find(squeeze(tconv(i,j,:))>=tmax)); % (1)
        numNOTconverged(i,j)=numNOTconverged(i,j)/Niter;
        m_prop_coop(i,j)=mean(squeeze(prop_coop(i,j,:))); % (2)
        std_prop_coop(i,j)=std(squeeze(prop_coop(i,j,:)));
        for z=1:sizeREPL %(9)
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
        [~, DominantAbsolute(i,j)]=max(vct);
    end
end
RD_UD=RD_UD./Niter;
RD_TFT=RD_TFT./Niter;
RD_CR=RD_CR./Niter;
RD_UR=RD_UR./Niter;
RD_UC=RD_UC./Niter;
RD_SJ=RD_SJ./Niter;

% (1) Proportion of true cooperators
fignum = figure(9);
axes1 = axes('Parent',fignum);
hold(axes1,'on');
box(axes1,'on');
set(axes1,'FontSize',18);
errorbar(Pevo,m_prop_coop(1,:),std_prop_coop(1,:),'r');
hold on
errorbar(Pevo,m_prop_coop(2,:),std_prop_coop(2,:),'k');
hold on
%errorbar(Pevo,m_prop_coop(3,:),std_prop_coop(3,:),'b');
%hold on
%errorbar(Pevo,m_prop_coop(4,:),std_prop_coop(4,:),'g');
%hold on
ylim([0,1]);
xlim([-0.01,0.22]);
xlabel('Prob. Evolution','FontSize',25);
ylabel(' ','FontSize',25);
%legend('TFT=CR=UR=UD=UC=1/6','TFT=0, CR=UR=UD=UC=1/5','Location','best'); 
tt=['Fig2f_ER Effect of P_{evo} - Proportion of cooperators'];
title({' ','Copy the Better'},'FontSize',25) 
fn=tt(~isspace(tt));
fn=strrep(fn,'_{','');
fn=strrep(fn,'}','');
saveas(fignum,fn);
print('-depsc', fn);


% FIGURE 3 - PANEL 5: EFFECT OF POPULATION SIZE IN A COPY THE BETTER SETTING
clear all
clc

load NS_20_NStudy_er.mat % _long

[~, sizeIC, sizeKV, sizeREPL]=size(N_types);
prop_coop=number_true_cooperators./number_of_plays;

arrived_at=length(tconv); 
numNOTconverged=zeros(sizeIC,sizeKV);
RD_UD=zeros(sizeIC,sizeKV);
RD_TFT=zeros(sizeIC,sizeKV);
RD_CR=zeros(sizeIC,sizeKV);
RD_UR=zeros(sizeIC,sizeKV);
RD_UC=zeros(sizeIC,sizeKV); 
RD_SJ=zeros(sizeIC,sizeKV);% set counters for relative dominance to zero for all types

for i=1:sizeIC
    for j=1:sizeKV
        numNOTconverged(i,j)=length(find(squeeze(tconv(i,j,:))>=tmax)); % (1)
        numNOTconverged(i,j)=numNOTconverged(i,j)/Niter;
        m_prop_coop(i,j)=mean(squeeze(prop_coop(i,j,:))); % (2)
        std_prop_coop(i,j)=std(squeeze(prop_coop(i,j,:)));
        for z=1:sizeREPL %(9)
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
        
        N_UD(i,j)=length(find(squeeze(N_types(1,i,j,:))>(0.9*N(j))))/arrived_at; % (4-8)
        N_TFT(i,j)=length(find(squeeze(N_types(2,i,j,:))>(0.9*N(j))))/arrived_at;
        N_CR(i,j)=length(find(squeeze(N_types(3,i,j,:))>(0.9*N(j))))/arrived_at;
        N_UR(i,j)=length(find(squeeze(N_types(4,i,j,:))>(0.9*N(j))))/arrived_at;
        N_UC(i,j)=length(find(squeeze(N_types(5,i,j,:))>(0.9*N(j))))/arrived_at;
        N_SJ(i,j)=length(find(squeeze(N_types(6,i,j,:))>(0.9*N(j))))/arrived_at;
        N_NC(i,j)=(1-(N_UD(i,j)+N_TFT(i,j)+N_CR(i,j)+N_UR(i,j)+N_UC(i,j)+N_SJ(i,j))); % residual. Simulations that are not dominated.
        
        vct= [N_UD(i,j) N_TFT(i,j) N_CR(i,j) N_UR(i,j) N_UC(i,j) N_SJ(i,j)]; % (3)
        [~, DominantAbsolute(i,j)]=max(vct);
    end
end
RD_UD=RD_UD./Niter;
RD_TFT=RD_TFT./Niter;
RD_CR=RD_CR./Niter;
RD_UR=RD_UR./Niter;
RD_UC=RD_UC./Niter;
RD_SJ=RD_SJ./Niter;

% (1) Proportion of true cooperators
fignum = figure(10);
axes1 = axes('Parent',fignum);
hold(axes1,'on');
box(axes1,'on');
set(axes1,'FontSize',18);
errorbar(N,m_prop_coop(1,:),std_prop_coop(1,:),'r');
hold on
errorbar(N,m_prop_coop(2,:),std_prop_coop(2,:),'k');
%hold on
%errorbar(N,m_prop_coop(3,:),std_prop_coop(3,:),'b');
%hold on
%errorbar(N,m_prop_coop(4,:),std_prop_coop(4,:),'g');
%hold on
ylim([0,1]);
xlim([N(1)-5,N(end)+5]);
xlabel('Population Size','FontSize',25);
ylabel(' ','FontSize',25);
%legend('TFT=CR=UR=UD=UC=1/6','TFT=0, CR=UR=UD=UC=1/5','Location','best'); 
tt=['Fig2g_ER Initial Proportions of UR and CR - Proportion of cooperators'];
title({' ','Copy the Better'},'FontSize',25)
fn=tt(~isspace(tt));
fn=strrep(fn,'_{','');
fn=strrep(fn,'}','');
saveas(fignum,fn);
print('-depsc', fn);


% FIGURE 3 - PANEL 6: EFFECT OF NETWORK DENSITY IN A COPY THE BETTER SETTING
clear all

clc

load NS_21_Density_er.mat % _long

[~, sizeIC, sizeKV, sizeREPL]=size(N_types);
prop_coop=number_true_cooperators./number_of_plays;

arrived_at=length(tconv); 
numNOTconverged=zeros(sizeIC,sizeKV);
RD_UD=zeros(sizeIC,sizeKV);
RD_TFT=zeros(sizeIC,sizeKV);
RD_CR=zeros(sizeIC,sizeKV);
RD_UR=zeros(sizeIC,sizeKV);
RD_UC=zeros(sizeIC,sizeKV);
RD_SJ=zeros(sizeIC,sizeKV);% set counters for relative dominance to zero for all types

for i=1:sizeIC
    for j=1:sizeKV
        numNOTconverged(i,j)=length(find(squeeze(tconv(i,j,:))>=tmax)); % (1)
        numNOTconverged(i,j)=numNOTconverged(i,j)/Niter;
        sq=squeeze(prop_coop(i,j,:)); 
        m_prop_coop(i,j)=mean(sq(find(~isnan(sq)))); % (2)
        std_prop_coop(i,j)=std(sq(find(~isnan(sq))));
        for z=1:sizeREPL %(9)
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
        [~, DominantAbsolute(i,j)]=max(vct);
    end
end
RD_UD=RD_UD./Niter;
RD_TFT=RD_TFT./Niter;
RD_CR=RD_CR./Niter;
RD_UR=RD_UR./Niter;
RD_UC=RD_UC./Niter;
RD_SJ=RD_SJ./Niter;

% (1) Proportion of true cooperators
fignum = figure(11);
axes1 = axes('Parent',fignum);
hold(axes1,'on');
box(axes1,'on');
set(axes1,'FontSize',18);
errorbar(P_Link,m_prop_coop(1,:),std_prop_coop(1,:),'r');
hold on
errorbar(P_Link,m_prop_coop(2,:),std_prop_coop(2,:),'k');
ylim([0,1]);
xlim([min(P_Link)-0.005,max(P_Link)+0.005]);
xlabel('Network Density','FontSize',25);
ylabel(' ','FontSize',25);
%legend('TFT=CR=UR=UD=UC=SJ=1/6','TFT=0, CR=UR=UD=UC=SJ=1/5','Location','best');  
tt=['Fig2h_ER Effect of Network Density - Proportion of cooperators'];
title({' ','Copy the Better'},'FontSize',25)
fn=tt(~isspace(tt));
fn=strrep(fn,'_{','');
fn=strrep(fn,'}','');
saveas(fignum,fn);
print('-depsc', fn);


%%%%
% FIGURE 4 -Effect of TFT efficiency (perfectness of recall) on which strategies 
%gain absolute dominance and on the proportion of cooperation. 
% Simulation runs with imperfect recall could clearly be separated into two
% scenarios. The Right Panel reports the proportion of simulations that end up 
% in these scenarios (i.e. with a final proportion of cooperators above and 
% below $1/2$), and the proportion of cooperation in each scenario. 
% Results are provided for an initialization where the population is equally 
% divided among the types of agents. Results come from 100 simulations for 
%each parameter combination for E-R random networks of 240 individuals with  
% $\lambda=0.10$. $P_{evo}=0.05$; $P_{for}=0$. 
% The rule of strategy update is the copy-the-best strategy.


clear all
close all

clc
load NS_11_TftEfficiency.mat % _long

[~, sizeIC, sizeREPL]=size(N_types);
prop_coop=number_true_cooperators./number_of_plays;
arrived_at=length(tconv); 
numNOTconverged=zeros(sizeIC,1);
RD_UD=zeros(sizeIC,1);
RD_TFT=zeros(sizeIC,1);
RD_CR=zeros(sizeIC,1);
RD_UR=zeros(sizeIC,1);
RD_UC=zeros(sizeIC,1);
RD_SJ=zeros(sizeIC,1);% set counters for relative dominance to zero for all types

for i=1:sizeIC
    numNOTconverged(i)=length(find(squeeze(tconv(i,:))>=tmax)); % (1)
    numNOTconverged(i)=numNOTconverged(i)/Niter;
    m_prop_coop(i)=mean(squeeze(prop_coop(i,:))); % (2)
    std_prop_coop(i)=std(squeeze(prop_coop(i,:)));
    for z=1:sizeREPL %(9)
        [~, pos_max]=max(squeeze(N_types(:,i,z)));
        if pos_max==1; RD_UD(i)=RD_UD(i)+1; end; % I update the counter of each types accordingly.
        if pos_max==2; RD_TFT(i)=RD_TFT(i)+1; end;
        if pos_max==3; RD_CR(i)=RD_CR(i)+1; end;
        if pos_max==4; RD_UR(i)=RD_UR(i)+1; end;
        if pos_max==5; RD_UC(i)=RD_UC(i)+1; end;
        if pos_max==6; RD_SJ(i)=RD_SJ(i)+1; end;
    end
    vct= [RD_UD(i) RD_TFT(i) RD_CR(i) RD_UR(i) RD_UC(i) RD_SJ(i)]; % (10)
    [~, DominantRelative(i)]=max(vct);

    N_UD(i)=length(find(squeeze(N_types(1,i,:))>(0.9*N)))/arrived_at; % (4-8)
    N_TFT(i)=length(find(squeeze(N_types(2,i,:))>(0.9*N)))/arrived_at;
    N_CR(i)=length(find(squeeze(N_types(3,i,:))>(0.9*N)))/arrived_at;
    N_UR(i)=length(find(squeeze(N_types(4,i,:))>(0.9*N)))/arrived_at;
    N_UC(i)=length(find(squeeze(N_types(5,i,:))>(0.9*N)))/arrived_at;
    N_SJ(i)=length(find(squeeze(N_types(6,i,:))>(0.9*N)))/arrived_at;
    N_NC(i)=(1-(N_UD(i)+N_TFT(i)+N_CR(i)+N_UR(i)+N_UC(i))); % residual. Simulations that are not dominated.

    vct= [N_UD(i) N_TFT(i) N_CR(i) N_UR(i) N_UC(i) N_SJ(i)]; % (3)
    [~, DominantAbsolute(i)]=max(vct);
end
RD_UD=RD_UD./Niter;
RD_TFT=RD_TFT./Niter;
RD_CR=RD_CR./Niter;
RD_UR=RD_UR./Niter;
RD_UC=RD_UC./Niter;
RD_SJ=RD_SJ./Niter;



for i=1:sizeIC
    prophigh(i)=sum(prop_coop(i,:)>0.50)/sizeREPL;
    proplow(i)=sum(prop_coop(i,:)<0.50)/sizeREPL;
    Coophigh_m(i)=mean(prop_coop(i,prop_coop(i,:)>0.50));
    Coophigh_std(i)=std(prop_coop(i,prop_coop(i,:)>0.50));
    Cooplow_m(i)=mean(prop_coop(i,prop_coop(i,:)<0.50));
    Cooplow_std(i)=std(prop_coop(i,prop_coop(i,:)<0.50));
end

load NS_31_TftEfficiency_NiceTFT.mat

[~, sizeIC, sizeREPL]=size(N_types);
prop_coop_nice=number_true_cooperators./number_of_plays;
arrived_at=length(tconv); 
numNOTconverged_nice=zeros(sizeIC,1);
RD_UD=zeros(sizeIC,1);
RD_TFT=zeros(sizeIC,1);
RD_CR=zeros(sizeIC,1);
RD_UR=zeros(sizeIC,1);
RD_UC=zeros(sizeIC,1);
RD_SJ=zeros(sizeIC,1);% set counters for relative dominance to zero for all types

for i=1:sizeIC
    numNOTconverged_nice(i)=length(find(squeeze(tconv(i,:))>=tmax)); % (1)
    numNOTconverged_nice(i)=numNOTconverged_nice(i)/Niter;
    m_prop_coop_nice(i)=mean(squeeze(prop_coop_nice(i,:))); % (2)
    std_prop_coop_nice(i)=std(squeeze(prop_coop_nice(i,:)));
    for z=1:sizeREPL %(9)
        [~, pos_max]=max(squeeze(N_types(:,i,z)));
        if pos_max==1; RD_UD(i)=RD_UD(i)+1; end; % I update the counter of each types accordingly.
        if pos_max==2; RD_TFT(i)=RD_TFT(i)+1; end;
        if pos_max==3; RD_CR(i)=RD_CR(i)+1; end;
        if pos_max==4; RD_UR(i)=RD_UR(i)+1; end;
        if pos_max==5; RD_UC(i)=RD_UC(i)+1; end;
        if pos_max==6; RD_SJ(i)=RD_SJ(i)+1; end;
    end
    vct= [RD_UD(i) RD_TFT(i) RD_CR(i) RD_UR(i) RD_UC(i) RD_SJ(i)]; % (10)
    [~, DominantRelative(i)]=max(vct);

    N_UD_nice(i)=length(find(squeeze(N_types(1,i,:))>(0.9*N)))/arrived_at; % (4-8)
    N_TFT_nice(i)=length(find(squeeze(N_types(2,i,:))>(0.9*N)))/arrived_at;
    N_CR_nice(i)=length(find(squeeze(N_types(3,i,:))>(0.9*N)))/arrived_at;
    N_UR_nice(i)=length(find(squeeze(N_types(4,i,:))>(0.9*N)))/arrived_at;
    N_UC_nice(i)=length(find(squeeze(N_types(5,i,:))>(0.9*N)))/arrived_at;
    N_SJ_nice(i)=length(find(squeeze(N_types(6,i,:))>(0.9*N)))/arrived_at;
    N_NC_nice(i)=(1-(N_UD_nice(i)+N_TFT_nice(i)+N_CR_nice(i)+N_UR_nice(i)+N_UC_nice(i))); % residual. Simulations that are not dominated.

    vct= [N_UD_nice(i) N_TFT_nice(i) N_CR_nice(i) N_UR_nice(i) N_UC_nice(i) N_SJ_nice(i)]; % (3)
    [~, DominantAbsolute_nice(i)]=max(vct);
end
RD_UD=RD_UD./Niter;
RD_TFT=RD_TFT./Niter;
RD_CR=RD_CR./Niter;
RD_UR=RD_UR./Niter;
RD_UC=RD_UC./Niter;
RD_SJ=RD_SJ./Niter;



for i=1:sizeIC
    prophigh_nice(i)=sum(prop_coop_nice(i,:)>0.50)/sizeREPL;
    proplow_nice(i)=sum(prop_coop_nice(i,:)<0.50)/sizeREPL;
    Coophigh_m_nice(i)=mean(prop_coop_nice(i,prop_coop_nice(i,:)>0.50));
    Coophigh_std_nice(i)=std(prop_coop_nice(i,prop_coop_nice(i,:)>0.50));
    Cooplow_m_nice(i)=mean(prop_coop_nice(i,prop_coop_nice(i,:)<0.50));
    Cooplow_std_nice(i)=std(prop_coop_nice(i,prop_coop_nice(i,:)<0.50));
end




% FIGURE 4: LEFT PANEL - FREQUENCY OF STRATEGY DOMINATION
fignum = figure(12);
subplot(1,2,1)
%axes1 = axes('Parent',fignum);
%hold(axes1,'on');
%box(axes1,'on');
%set(axes1,'FontSize',18);
plot(TFTEfficiency(6:end)',N_UR(6:end),'b');
hold on
plot(TFTEfficiency(6:end)',N_CR(6:end),'r');
hold on
plot(TFTEfficiency(6:end)',N_TFT(6:end),'k');
hold on
plot(TFTEfficiency(6:end)',N_UC(6:end),'g');
hold on
plot(TFTEfficiency(6:end)',N_SJ(6:end),'b-.');
hold on
plot(TFTEfficiency(6:end)',N_UD(6:end),'m');
hold on
ylim([0,1]);
xlim([0.49,1.01]);
xlabel('TFT Efficiency','FontSize',25);
ylabel('Prop. of Simulations','FontSize',25);
legend('UR','CR','TFT','UC','SJ','UD','Location','northwest');
%tt=['Fig3a_Limited Efficiency of TFT - Proportion of simulations absolutely dominated each type Evil'];
title({'Limited Memory TFT','Frequency of Strategy Domination'},'FontSize',25) 
%fn=tt(~isspace(tt));
%fn=strrep(fn,'_{','');
%fn=strrep(fn,'}','');
%saveas(fignum,fn);
%print('-depsc', fn);

% fignum = figure(13);
% axes1 = axes('Parent',fignum);
% hold(axes1,'on');
% box(axes1,'on');
% set(axes1,'FontSize',25);
% plot(TFTEfficiency',N_UR_nice,'b');
% hold on
% plot(TFTEfficiency',N_CR_nice,'r');
% hold on
% plot(TFTEfficiency',N_TFT_nice,'k');
% hold on
% plot(TFTEfficiency',N_UC_nice,'g');
% hold on
% plot(TFTEfficiency',N_SJ_nice,'b-.');
% hold on
% plot(TFTEfficiency',N_UD_nice,'m');
% hold on
% ylim([0,1]);
% xlim([-0.01,1.01]);
% xlabel('TFT Efficiency','FontSize',25);
% ylabel('Proportions','FontSize',25);
% legend('UR','CR','TFT','UC','SJ','UD','Location','best');
% tt=['Fig3b_Limited Efficiency of Nice TFT - Proportion of simulations absolutely dominated each type'];
% title({'Limited Memory of Nice TFT','Simulations dominated each type'},'FontSize',25) 
% fn=tt(~isspace(tt));
% fn=strrep(fn,'_{','');
% fn=strrep(fn,'}','');
% saveas(fignum,fn);
% print('-depsc', fn);


% FIGURE 4:  RIGHT PANEL - PROPORTION OF COOPERATORS

%fignum = figure(14);
%axes1 = axes('Parent',fignum);
%hold(axes1,'on');
%box(axes1,'on');
%set(axes1,'FontSize',18);
subplot(1,2,2)
xlabel('TFT Efficiency','FontSize',25);
tt=['Fig3c_Limited Efficiency of TFT - Proportion of Cooperators High and Low coperation Regimes'];
title({'Limited Memory TFT','Proportion of Cooperators'},'FontSize',25) 
%yyaxis left
errorbar(TFTEfficiency(6:end)',Coophigh_m(6:end),Coophigh_std(6:end),'b');
hold on
errorbar(TFTEfficiency(6:end)',Cooplow_m(6:end),Cooplow_std(6:end),'r');
hold on
%errorbar(TFTEfficiency',Coophigh_m_nice,Coophigh_std_nice,'b-.');
%hold on
%errorbar(TFTEfficiency',Cooplow_m_nice,Cooplow_std_nice,'r-.');
ylim([0,1]);
xlim([0.49,1.01]);
ylabel(' ','FontSize',25);
%set(gca,'Color','k')

plot(TFTEfficiency(6:end)',prophigh(6:end),'k-');
hold on
%plot(TFTEfficiency',prophigh_nice,'k-.');
%set(axes1,'Color','k')
hold on
ylim([0,1]);
xlim([0.49,1.01]);

legend('P(Coop)>1/2','P(Coop)<1/2','Prop. Sim. P(coop)> 1/2','Location','best');

fn=tt(~isspace(tt));
fn=strrep(fn,'_{','');
fn=strrep(fn,'}','');
saveas(fignum,fn);
print('-depsc', fn);

% 
% % - Bad TFT: do a simulation with efficiency loss with nice tft and copy the best + one where baseline behaviour is random
