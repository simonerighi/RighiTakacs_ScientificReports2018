
clear all
close all
clc

%%%
% FIGURE S1


% FIGURE S1 (LEFT PANEL) - EFFECT OF INITIAL PROPORTION OF AGENTS - COPY THE BEST - TFT
% EFFECT (EVIL)


load('NS_03_TFTEffect.mat') %_long

prop_coop=number_true_cooperators./number_of_plays; %compute the proportion of cooperators
proptft=squeeze(N_types(2,:,:)./N); %compute the proportion of TFTs
m_prop_coop=mean(prop_coop,2); %average proportion of cooperators 
std_prop_coop=std(prop_coop,0,2); % std proportion of cooperators
m_prop_tft=mean(proptft,2); %average proportion of cooperators 
std_prop_tft=std(proptft,0,2); % std proportion of cooperators


arrived_at=length(tconv); 
for i=1:length(Prop_TFT)
    N_UD(i)=length(find(squeeze(N_types(1,i,:))>(0.9*N)))/arrived_at;
    N_TFT(i)=length(find(squeeze(N_types(2,i,:))>(0.9*N)))/arrived_at;
    N_CR(i)=length(find(squeeze(N_types(3,i,:))>(0.9*N)))/arrived_at;
    N_UR(i)=length(find(squeeze(N_types(4,i,:))>(0.9*N)))/arrived_at;
    N_UC(i)=length(find(squeeze(N_types(5,i,:))>(0.9*N)))/arrived_at;
    N_SJ(i)=length(find(squeeze(N_types(6,i,:))>(0.9*N)))/arrived_at;
    N_NC(i)=(1-(N_UD(i)+N_TFT(i)+N_CR(i)+N_UR(i)+N_UC(i)+N_SJ(i))); % residual. Simulations that are not dominated.
end

fignum= figure(1);
axes1 = axes('Parent',fignum);
hold(axes1,'on');
box(axes1,'on');
set(axes1,'FontSize',18);
errorbar(Prop_TFT,m_prop_coop,std_prop_coop,'r-.'); % 
hold on
plot(Prop_TFT,N_NC,'k.'); 
hold on
plot(Prop_TFT,N_TFT,'b-'); % 
hold on
plot(Prop_TFT,N_UD,'m--'); % 
hold on
plot(Prop_TFT,N_CR,'c-'); %
hold on
plot(Prop_TFT,N_UR,'y.'); %
hold on
plot(Prop_TFT,N_UC,'b-.'); %
hold on
plot(Prop_TFT,N_SJ,'r-'); %
hold on
xlim([-0.01 0.16]);
ylim([-0.01 1.1]);
xlabel('Initial Proportion TFT','FontSize',18)
ylabel('Proportions','FontSize',18)
legend({'Prop. Coop.','Mixed','TFT','UD','CR','UR','UC','SJ'},'Location','northeast','Orientation','Vertical')
tt=['Simulation dominated and Cooperation vs Initial Proportion of Evil TFT'];
title({'Dominating Strategies',' by Initial Proportion of Evil TFT'},'FontSize',18) 
fn=tt(~isspace(tt));
saveas(fignum,fn);
print('-depsc', fn);


% FIGURE S1 (RIGHT PANEL) - EFFECT OF INITIAL PROPORTION OF AGENTS - COPY THE BEST - TFT
% EFFECT (NICE)


clear all
clc
load('NS_13_TFTEffect_NiceTFT.mat') %_long

prop_coop=number_true_cooperators./number_of_plays; %compute the proportion of cooperators
proptft=squeeze(N_types(2,:,:)./N); %compute the proportion of TFTs
m_prop_coop=mean(prop_coop,2); %average proportion of cooperators 
std_prop_coop=std(prop_coop,0,2); % std proportion of cooperators
m_prop_tft=mean(proptft,2); %average proportion of cooperators 
std_prop_tft=std(proptft,0,2); % std proportion of cooperators

%Grafico con la proporzione di simulazioni dominate da TFT [MEDIA e std] (in uscita), not converged e contestualmente di prop_coop [MEDIA e std]
%asse x: proporzione TFT in entrata
% 1 hist with dominant type (single type having more than 90%=(0.9*N) agents at tmax or convergence).
arrived_at=length(tconv); 
for i=1:length(Prop_TFT)
    N_UD(i)=length(find(squeeze(N_types(1,i,:))>(0.9*N)))/arrived_at;
    N_TFT(i)=length(find(squeeze(N_types(2,i,:))>(0.9*N)))/arrived_at;
    N_CR(i)=length(find(squeeze(N_types(3,i,:))>(0.9*N)))/arrived_at;
    N_UR(i)=length(find(squeeze(N_types(4,i,:))>(0.9*N)))/arrived_at;
    N_UC(i)=length(find(squeeze(N_types(5,i,:))>(0.9*N)))/arrived_at;
    N_SJ(i)=length(find(squeeze(N_types(6,i,:))>(0.9*N)))/arrived_at;
    N_NC(i)=(1-(N_UD(i)+N_TFT(i)+N_CR(i)+N_UR(i)+N_UC(i)+N_SJ(i))); % residual. Simulations that are not dominated.
end

fignum= figure(2);
axes1 = axes('Parent',fignum);
hold(axes1,'on');
box(axes1,'on');
set(axes1,'FontSize',18);
errorbar(Prop_TFT,m_prop_coop,std_prop_coop,'r-.'); % 
hold on
plot(Prop_TFT,N_NC,'k.'); 
hold on
plot(Prop_TFT,N_TFT,'b-'); % 
hold on
plot(Prop_TFT,N_UD,'m--'); % 
hold on
plot(Prop_TFT,N_CR,'c-'); %
hold on
plot(Prop_TFT,N_UR,'y.'); %
hold on
plot(Prop_TFT,N_UC,'b-.'); %
hold on
plot(Prop_TFT,N_SJ,'r-'); %
hold on
xlim([-0.01 0.16]);
ylim([-0.01 1.1]);
xlabel('Initial Proportion TFT','FontSize',18)
ylabel('Proportions','FontSize',18)
legend('Prop. Coop.','Mixed','TFT','UD','CR','UR','UC','SJ','Location','northeast')
tt=['Simulation dominated and Cooperation vs Initial Proportion of Nice TFT'];
title({'Dominating Strategies',' by Initial Proportion of Nice TFT'},'FontSize',18) 
fn=tt(~isspace(tt));
saveas(fignum,fn);
print('-depsc', fn);







%%%%%
% FIGURE S2 - PERFORMANCE OF INDIRECT RECIPROCITY STRATEGIES
% PANELS ARE COUNTED LEFT TO RIGHT, TOP TO BOTTOM:
% 1 2 3
% 4 5 6










% CR vs UR (proportion dominated)

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
        [~, DominantAbsolute(i,j)]=max(vct);
    end
end
RD_UD=RD_UD./Niter;
RD_TFT=RD_TFT./Niter;
RD_CR=RD_CR./Niter;
RD_UR=RD_UR./Niter;
RD_UC=RD_UC./Niter;
RD_SJ=RD_SJ./Niter;


% FIGURE S2 (PANEL 6) - PROPORTION OF SIMULATIONS WITHOUT ABSOLUTE DOMINANCE
fignum = figure(3);
axes1 = axes('Parent',fignum);
hold(axes1,'on');
set(axes1,'FontSize',18);
xlim([-0.025 0.525]);
ylim([-0.025 0.525]);
imagesc(Prop_UR,Prop_CR,numNOTconverged);
colorbar
set(gca, 'CLim', [0, 1]);
set(gca,'YDir','normal')
xlabel('Prop UR','FontSize',18);
ylabel('Prop CR','FontSize',18);
tt=['Initial Proportions of UR and CR - No Dominance'];
title({'Initial Proportions of UR and CR','No Dominance'},'FontSize',18) 
fn=tt(~isspace(tt));
saveas(fignum,fn);
print('-depsc', fn);

% FIGURE S2 (PANEL 5) - PROPORTION OF SIMULATIONS DOMINATED BY UD
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
tt=['Initial Proportions of UR and CR - Proportion Dominated by UD'];
title({'Initial Proportions of UR and CR','Proportion Dominated by UD'},'FontSize',18) 
fn=tt(~isspace(tt));
saveas(fignum,fn);
print('-depsc', fn);


% FIGURE S2 (PANEL 4) - PROPORTION OF SIMULATIONS DOMINATED BY UC
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
tt=['Initial Proportions of UR and CR - Proportion Dominated by UC'];
title({'Initial Proportions of UR and CR','Proportion Dominated by UC'},'FontSize',18) 
fn=tt(~isspace(tt));
saveas(fignum,fn);
print('-depsc', fn);

% FIGURE S2 (PANEL 3) - PROPORTION OF SIMULATIONS DOMINATED BY SJ
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
tt=['Initial Proportions of UR and CR - Proportion Dominated by SJ'];
title({'Initial Proportions of UR and CR','Proportion Dominated by SJ'},'FontSize',18) 
fn=tt(~isspace(tt));
saveas(fignum,fn);
print('-depsc', fn);


% FIGURE S2 (PANEL 2) - PROPORTION OF SIMULATIONS DOMINATED BY UR
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
tt=['Initial Proportions of UR and CR - Proportion Dominated by UR'];
title({'Initial Proportions of UR and CR','Proportion Dominated by UR'},'FontSize',18) 
fn=tt(~isspace(tt));
saveas(fignum,fn);
print('-depsc', fn);

% FIGURE S2 (PANEL 1) - PROPORTION OF SIMULATIONS DOMINATED BY CR
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
tt=['Initial Proportions of UR and CR - Proportion Dominated by CR'];
title({'Initial Proportions of UR and CR','Proportion Dominated by CR'},'FontSize',18) 
fn=tt(~isspace(tt));
saveas(fignum,fn);
print('-depsc', fn);




%%%%%
% FIGURE S2 - PERFORMANCE OF INDIRECT RECIPROCITY STRATEGIES WITHOUT SJ
% AGENTS
% PANELS ARE COUNTED LEFT TO RIGHT, TOP TO BOTTOM:
% 1 2 3
% 4 5 6

clear all
clc
load NS_33_URCRStudy_NOSJ_00.mat

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
        [~, DominantAbsolute(i,j)]=max(vct);
    end
end
RD_UD=RD_UD./Niter;
RD_TFT=RD_TFT./Niter;
RD_CR=RD_CR./Niter;
RD_UR=RD_UR./Niter;
RD_UC=RD_UC./Niter;
RD_SJ=RD_SJ./Niter;

% i could also rapresent with darker color the ones where the dominat type
% is more dominant (not done yet)

% FIGURE S3 (PANEL 1) - PROPORTION OF COOPERATORS
fignum = figure(10);
axes1 = axes('Parent',fignum);
hold(axes1,'on');
set(axes1,'FontSize',18);
xlim([-0.025 0.525]);
ylim([-0.025 0.525]);
imagesc(Prop_UR,Prop_CR,m_prop_coop);
colorbar
set(gca, 'CLim', [0, 1]);
set(gca,'YDir','normal')
xlabel('Prop UR','FontSize',18);
ylabel('Prop CR','FontSize',18);
tt=['NOSJInitial Proportions of UR and CR - Proportion Cooperators'];
title({'Initial Proportions of UR and CR','Proportion of Cooperators'},'FontSize',18) 
fn=tt(~isspace(tt));
saveas(fignum,fn);
print('-depsc', fn);


% FIGURE S3 (PANEL 6) - PROPORTION OF SIMULATION WITHOUT AN ABSOLUTELY
% DOMINANT STRATEGY
fignum = figure(11);
axes1 = axes('Parent',fignum);
hold(axes1,'on');
set(axes1,'FontSize',18);
xlim([-0.025 0.525]);
ylim([-0.025 0.525]);
imagesc(Prop_UR,Prop_CR,numNOTconverged);
colorbar
set(gca, 'CLim', [0, 1]);
set(gca,'YDir','normal')
xlabel('Prop UR','FontSize',18);
ylabel('Prop CR','FontSize',18);
tt=['NOSJInitial Proportions of UR and CR - No Dominance'];
title({'Initial Proportions of UR and CR','No Dominance'},'FontSize',18) 
fn=tt(~isspace(tt));
saveas(fignum,fn);
print('-depsc', fn);

% FIGURE S3 (PANEL 5) - PROPORTION OF SIMULATION DOMINATED BY UD
fignum = figure(12);
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
tt=['NOSJInitial Proportions of UR and CR - Proportion Dominated by UD'];
title({'Initial Proportions of UR and CR','Proportion Dominated by UD'},'FontSize',18) 
fn=tt(~isspace(tt));
saveas(fignum,fn);
print('-depsc', fn);


% FIGURE S3 (PANEL 4) - PROPORTION OF SIMULATION DOMINATED BY UC
fignum = figure(14);
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
tt=['NOSJInitial Proportions of UR and CR - Proportion Dominated by UC'];
title({'Initial Proportions of UR and CR','Proportion Dominated by UC'},'FontSize',18) 
fn=tt(~isspace(tt));
saveas(fignum,fn);
print('-depsc', fn);



% FIGURE S3 (PANEL 3) - PROPORTION OF SIMULATION DOMINATED BY UR
fignum = figure(16);
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
tt=['NOSJInitial Proportions of UR and CR - Proportion Dominated by UR'];
title({'Initial Proportions of UR and CR','Proportion Dominated by UR'},'FontSize',18) 
fn=tt(~isspace(tt));
saveas(fignum,fn);
print('-depsc', fn);

% FIGURE S3 (PANEL 2) - PROPORTION OF SIMULATION DOMINATED BY CR
fignum = figure(17);
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
tt=['NOSJInitial Proportions of UR and CR - Proportion Dominated by CR'];
title({'Initial Proportions of UR and CR','Proportion Dominated by CR'},'FontSize',18) 
fn=tt(~isspace(tt));
saveas(fignum,fn);
print('-depsc', fn);








