clear all
close all
clc
% FIGURE S10 - THE IMPACT OF TFT EFFICIENCY - COPY THE BEST - EVIL TFT (TOP
% PANELS)



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






% Figure S10 (TOP LEFT PANEL) - Frequency of Stategy domination - Copy the
% best - EVIL TFT
fignum = figure(1);
axes1 = axes('Parent',fignum);
hold(axes1,'on');
box(axes1,'on');
set(axes1,'FontSize',18);
plot(TFTEfficiency',N_UR,'b');
hold on
plot(TFTEfficiency',N_CR,'r');
hold on
plot(TFTEfficiency',N_TFT,'k');
hold on
plot(TFTEfficiency',N_UC,'g');
hold on
plot(TFTEfficiency',N_SJ,'b-.');
hold on
plot(TFTEfficiency',N_UD,'m');
hold on
ylim([0,1]);
xlim([-0.01,1.01]);
xlabel('TFT Efficiency','FontSize',18);
ylabel('Prop. of Simulations','FontSize',18);
legend('UR','CR','TFT','UC','SJ','UD','Location','northwest');
tt=['Best Limited Efficiency of Evil TFT - Proportion of simulations absolutely dominated each type Evil'];
title({'Limited Memory Evil TFT','Frequency of Strategy Domination'},'FontSize',18) 
fn=tt(~isspace(tt));
fn=strrep(fn,'_{','');
fn=strrep(fn,'}','');
saveas(fignum,fn);
print('-depsc', fn);


% Figure S10 (TOP RIGHT PANEL) - Proportion of cooperators - Copy the
% best - EVIL TFT
fignum = figure(2);
axes1 = axes('Parent',fignum);
hold(axes1,'on');
box(axes1,'on');
set(axes1,'FontSize',18);
xlabel('TFT Efficiency','FontSize',18);
tt=['Best Limited Efficiency of Evil TFT - Proportion of Cooperators High and Low coperation Regimes'];
title({'Limited Memory Evil TFT','Proportion of Cooperators'},'FontSize',18) 
%yyaxis left
errorbar(TFTEfficiency',Coophigh_m,Coophigh_std,'b');
hold on
errorbar(TFTEfficiency',Cooplow_m,Cooplow_std,'r');
hold on
%errorbar(TFTEfficiency',Coophigh_m,Coophigh_std,'b-.');
%hold on
%errorbar(TFTEfficiency',Cooplow_m,Cooplow_std,'r-.');
ylim([0,1]);
xlim([-0.01,1.01]);
ylabel(' ','FontSize',18);
%set(gca,'Color','k')
plot(TFTEfficiency',prophigh,'k-');
hold on
ylim([0,1]);
xlim([-0.01,1.01]);
legend('P(Coop)>1/2','P(Coop)<1/2','Prop. Sim. P(coop)> 1/2','Location','best');
fn=tt(~isspace(tt));
fn=strrep(fn,'_{','');
fn=strrep(fn,'}','');
saveas(fignum,fn);
print('-depsc', fn);


% FIGURE S10 - THE IMPACT OF TFT EFFICIENCY - COPY THE BEST - NICE TFT
% (BOTTOM PANELS)

clear all
load NS_31_TftEfficiency_NiceTFT.mat

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

% Figure S10 (BOTTOM LEFT PANEL) - FREQUENCY OF STRATEGY DOMINATION - Copy the
% best - NICE TFT
fignum = figure(3);
axes1 = axes('Parent',fignum);
hold(axes1,'on');
box(axes1,'on');
set(axes1,'FontSize',18);
plot(TFTEfficiency',N_UR,'b');
hold on
plot(TFTEfficiency',N_CR,'r');
hold on
plot(TFTEfficiency',N_TFT,'k');
hold on
plot(TFTEfficiency',N_UC,'g');
hold on
plot(TFTEfficiency',N_SJ,'b-.');
hold on
plot(TFTEfficiency',N_UD,'m');
hold on
ylim([0,1]);
xlim([-0.01,1.01]);
xlabel('TFT Efficiency','FontSize',18);
ylabel('Prop. of Simulations','FontSize',18);
legend('UR','CR','TFT','UC','SJ','UD','Location','northwest');
tt=['Best Limited Efficiency of Nice TFT - Proportion of simulations absolutely dominated each type Evil'];
title({'Limited Memory Nice TFT','Frequency of Strategy Domination'},'FontSize',18) 
fn=tt(~isspace(tt));
fn=strrep(fn,'_{','');
fn=strrep(fn,'}','');
saveas(fignum,fn);
print('-depsc', fn);


% Figure S10 (BOTTOM RIGHT PANEL) - PROPORTION OF COOPERATORS - Copy the
% best - NICE TFT
fignum = figure(4);
axes1 = axes('Parent',fignum);
hold(axes1,'on');
box(axes1,'on');
set(axes1,'FontSize',18);
xlabel('TFT Efficiency','FontSize',18);
tt=['Best Limited Efficiency of Nice TFT - Proportion of Cooperators High and Low coperation Regimes'];
title({'Limited Memory Nice TFT','Proportion of Cooperators'},'FontSize',18) 
%yyaxis left
errorbar(TFTEfficiency',Coophigh_m,Coophigh_std,'b');
hold on
errorbar(TFTEfficiency',Cooplow_m,Cooplow_std,'r');
hold on
%errorbar(TFTEfficiency',Coophigh_m,Coophigh_std,'b-.');
%hold on
%errorbar(TFTEfficiency',Cooplow_m,Cooplow_std,'r-.');
ylim([0,1]);
xlim([-0.01,1.01]);
ylabel(' ','FontSize',18);
%set(gca,'Color','k')
plot(TFTEfficiency',prophigh,'k-');
hold on
ylim([0,1]);
xlim([-0.01,1.01]);
legend('P(Coop)>1/2','P(Coop)<1/2','Prop. Sim. P(coop)> 1/2','Location','best');
fn=tt(~isspace(tt));
fn=strrep(fn,'_{','');
fn=strrep(fn,'}','');
saveas(fignum,fn);
print('-depsc', fn);




% FIGURE S11 - THE IMPACT OF TFT EFFICIENCY - COPY THE BETTER - EVIL TFT
% (TOP PANELS)


clear all
clc
load NS_22_TftEfficiency_er.mat % _long

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


% Figure S11 (TOP LEFT PANEL) - FREQ. OF STRATEGY DOMINATION - Copy the
% BETTER - EVIL TFT
fignum = figure(5);
axes1 = axes('Parent',fignum);
hold(axes1,'on');
box(axes1,'on');
set(axes1,'FontSize',18);
plot(TFTEfficiency',N_UR,'b');
hold on
plot(TFTEfficiency',N_CR,'r');
hold on
plot(TFTEfficiency',N_TFT,'k');
hold on
plot(TFTEfficiency',N_UC,'g');
hold on
plot(TFTEfficiency',N_SJ,'b-.');
hold on
plot(TFTEfficiency',N_UD,'m');
hold on
ylim([0,1]);
xlim([-0.01,1.01]);
xlabel('TFT Efficiency','FontSize',18);
ylabel('Prop. of Simulations','FontSize',18);
legend('UR','CR','TFT','UC','SJ','UD','Location','northwest');
tt=['Better Limited Efficiency of Evil TFT - Proportion of simulations absolutely dominated each type Evil'];
title({'Limited Memory Evil TFT','Frequency of Strategy Domination'},'FontSize',18) 
fn=tt(~isspace(tt));
fn=strrep(fn,'_{','');
fn=strrep(fn,'}','');
saveas(fignum,fn);
print('-depsc', fn);


% Figure S11 (TOP RIGHT PANEL) - PROP. OF COOPERATORS - Copy the
% BETTER - EVIL TFT
fignum = figure(6);
axes1 = axes('Parent',fignum);
hold(axes1,'on');
box(axes1,'on');
set(axes1,'FontSize',18);
xlabel('TFT Efficiency','FontSize',18);
tt=['Better Limited Efficiency of Evil TFT - Proportion of Cooperators High and Low coperation Regimes'];
title({'Limited Memory Evil TFT','Proportion of Cooperators'},'FontSize',18) 
%yyaxis left
errorbar(TFTEfficiency',Coophigh_m,Coophigh_std,'b');
hold on
errorbar(TFTEfficiency',Cooplow_m,Cooplow_std,'r');
hold on
%errorbar(TFTEfficiency',Coophigh_m,Coophigh_std,'b-.');
%hold on
%errorbar(TFTEfficiency',Cooplow_m,Cooplow_std,'r-.');
ylim([0,1]);
xlim([-0.01,1.01]);
ylabel(' ','FontSize',18);
%set(gca,'Color','k')
plot(TFTEfficiency',prophigh,'k-');
hold on
ylim([0,1]);
xlim([-0.01,1.01]);
legend('P(Coop)>1/2','P(Coop)<1/2','Prop. Sim. P(coop)> 1/2','Location','best');
fn=tt(~isspace(tt));
fn=strrep(fn,'_{','');
fn=strrep(fn,'}','');
saveas(fignum,fn);
print('-depsc', fn);


% FIGURE S11 - THE IMPACT OF TFT EFFICIENCY - COPY THE BETTER - NICE TFT
% (TOP PANELS)


clear all
load NS_32_TftEfficiency_er.mat

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

% Figure S11 (BOTTOM LEFT PANEL) - FREQ. OF STRATEGY DOMINATION - Copy the
% BETTER - NICE TFT
fignum = figure(7);
axes1 = axes('Parent',fignum);
hold(axes1,'on');
box(axes1,'on');
set(axes1,'FontSize',18);
plot(TFTEfficiency',N_UR,'b');
hold on
plot(TFTEfficiency',N_CR,'r');
hold on
plot(TFTEfficiency',N_TFT,'k');
hold on
plot(TFTEfficiency',N_UC,'g');
hold on
plot(TFTEfficiency',N_SJ,'b-.');
hold on
plot(TFTEfficiency',N_UD,'m');
hold on
ylim([0,1]);
xlim([-0.01,1.01]);
xlabel('TFT Efficiency','FontSize',18);
ylabel('Prop. of Simulations','FontSize',18);
legend('UR','CR','TFT','UC','SJ','UD','Location','northwest');
tt=['Better Limited Efficiency of nice TFT - Proportion of simulations absolutely dominated each type Evil'];
title({'Limited Memory Nice TFT','Frequency of Strategy Domination'},'FontSize',18) 
fn=tt(~isspace(tt));
fn=strrep(fn,'_{','');
fn=strrep(fn,'}','');
saveas(fignum,fn);
print('-depsc', fn);


% Figure S11 (BOTTOM RIGHT PANEL) - PROPORTION OF COOPERATORS - Copy the
% BETTER - NICE TFT
fignum = figure(8);
axes1 = axes('Parent',fignum);
hold(axes1,'on');
box(axes1,'on');
set(axes1,'FontSize',18);
xlabel('TFT Efficiency','FontSize',18);
tt=['Better Limited Efficiency of Nice TFT - Proportion of Cooperators High and Low coperation Regimes'];
title({'Limited Memory Nice TFT','Proportion of Cooperators'},'FontSize',18) 
%yyaxis left
errorbar(TFTEfficiency',Coophigh_m,Coophigh_std,'b');
hold on
errorbar(TFTEfficiency',Cooplow_m,Cooplow_std,'r');
hold on
%errorbar(TFTEfficiency',Coophigh_m,Coophigh_std,'b-.');
%hold on
%errorbar(TFTEfficiency',Cooplow_m,Cooplow_std,'r-.');
ylim([0,1]);
xlim([-0.01,1.01]);
ylabel(' ','FontSize',18);
%set(gca,'Color','k')
plot(TFTEfficiency',prophigh,'k-');
hold on
ylim([0,1]);
xlim([-0.01,1.01]);
legend('P(Coop)>1/2','P(Coop)<1/2','Prop. Sim. P(coop)> 1/2','Location','best');
fn=tt(~isspace(tt));
fn=strrep(fn,'_{','');
fn=strrep(fn,'}','');
saveas(fignum,fn);
print('-depsc', fn);

