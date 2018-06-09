close all
clear all
clc

% The script generates SI figures from S6 to S9, first the top panels are
% generated (simulations with copy the best setup) and then the bottomo
% panels (copy the better setup)



%%%%%
% FIGURE S6 - THE IMPORTANCE OF FORGIVENESS - COPY THE BEST (TOP PANELS)




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

% FIGURE S6 (TOP LEFT PANEL) - IMPORTANCE OF FORGIVENESS - COPY THE BEST -
% WITH TFT
fignum=figure(1);
axes1 = axes('Parent',fignum);
hold(axes1,'on');
set(axes1,'FontSize',18);
xlim([0-0.025 max(Pfor)+0.025])
ylim([0 1])
bar(Pfor,[N_UD(1,:);N_TFT(1,:);N_CR(1,:);N_UR(1,:);N_UC(1,:);N_SJ(1,:);N_NC(1,:)]','stacked');
xlabel('Prob. of Forgiveness','FontSize',18);
ylabel('Prop. of Simulations','FontSize',18);
legend('UD','TFT','CR','UR','UC','SJ','Mixed','Location','northwest')
title({'Effect of Forgiveness','Dominating Strategy','TFT=CR=UR=UD=UC=SJ=1/6'},'FontSize',18)
tt=['BestEffect of Forgiveness','Simulations Dominated by each strategy','TFT=CR=UR=UD=UC=SJ=1/6'];
fn=tt(~isspace(tt));
fn=fn(fn~='/');
saveas(fignum,fn);
print('-depsc', fn);

% FIGURE S6 (TOP RIGHT PANEL) - IMPORTANCE OF FORGIVENESS - COPY THE BEST -
% WITHOUT TFT
fignum=figure(2);
axes1 = axes('Parent',fignum);
hold(axes1,'on');
set(axes1,'FontSize',18);
xlim([0-0.025 max(Pfor)+0.025])
ylim([0 1])
placeholder=zeros(size(N_UD(2,:)));
bar(Pfor,[N_UD(2,:);placeholder;N_CR(2,:);N_UR(2,:);N_UC(2,:);N_SJ(2,:);N_NC(2,:)]','stacked');
xlabel('Prob. of Forgiveness','FontSize',18);
ylabel('Prop. of Simulations','FontSize',18);
legend('UD','TFT','CR','UR','UC','SJ','Mixed','Location','southeast')
title({'Effect of Forgiveness','Dominating Strategy','TFT=0, CR=UR=UD=UC=SJ=1/5'},'FontSize',18)
tt=['BestEffect of Forgiveness','Simulations Dominated by each strategy','TFT=0, CR=UR=UD=UC=SJ=1/5'];
fn=tt(~isspace(tt));
fn=fn(fn~='/');
fn=fn(fn~=',');
saveas(fignum,fn);
print('-depsc', fn);



%%%%%
% FIGURE S7 - SPEED OF EVOLUTION - COPY THE BEST (TOP PANELS)



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

% FIGURE S7 (TOP LEFT PANEL) - SPEED OF EVOLUTION - COPY THE BEST -
% WITH TFT
fignum=figure(3);
axes1 = axes('Parent',fignum);
hold(axes1,'on');
set(axes1,'FontSize',18);
xlim([0 max(Pevo)+0.01])
ylim([0 1])
bar(Pevo,[N_UD(1,:);N_TFT(1,:);N_CR(1,:);N_UR(1,:);N_UC(1,:);N_SJ(1,:);N_NC(1,:)]','stacked');
xlabel('Prob. of Evolution','FontSize',18);
ylabel('Prop. of Simulations','FontSize',18);
legend('UD','TFT','CR','UR','UC','SJ','Mixed','Location','northwest')
title({'Effect of Evolution','Dominating Strategy','TFT=CR=UR=UD=UC=SJ=1/6'},'FontSize',18)
tt=['BestEffect of Evolution','Simulations Dominated by each strategy','TFT=CR=UR=UD=UC=SJ=1/6'];
fn=tt(~isspace(tt));
fn=fn(fn~='/');
saveas(fignum,fn);
print('-depsc', fn);

% FIGURE S7 (TOP RIGHT PANEL) - SPEED OF EVOLUTION - COPY THE BEST -
% WITHOUT TFT
fignum=figure(4);
axes1 = axes('Parent',fignum);
hold(axes1,'on');
set(axes1,'FontSize',18);
xlim([0 max(Pevo)+0.01])
ylim([0 1])
placeholder=zeros(size(N_UD(2,:)));
bar(Pevo,[N_UD(2,:);placeholder;N_CR(2,:);N_UR(2,:);N_UC(2,:);N_SJ(2,:);N_NC(2,:)]','stacked');
xlabel('Prob. of Evolution','FontSize',18);
ylabel('Prop. of Simulations','FontSize',18);
legend('UD','TFT','CR','UR','UC','SJ','Mixed','Location','southeast')
title({'Effect of Evolution','Dominating Strategy','TFT=0, CR=UR=UD=UC=SJ=1/5'},'FontSize',18)
tt=['BestEffect of Evolution','Simulations Dominated by each strategy','TFT=0, CR=UR=UD=UC=SJ=1/5'];
fn=tt(~isspace(tt));
fn=fn(fn~='/');
fn=fn(fn~=',');
saveas(fignum,fn);
print('-depsc', fn);






%%%%%
% FIGURE S8 - POPULATION SIZE - COPY THE BEST (TOP PANELS)



clear all
clc

load NS_09_NStudy.mat % _long

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

% FIGURE S8 (TOP LEFT PANEL) - POPULATION SIZE - COPY THE BEST -
% WITH TFT
fignum=figure(5);
axes1 = axes('Parent',fignum);
hold(axes1,'on');
set(axes1,'FontSize',18);
xlim([40 620])
ylim([0 1])
bar(N,[N_UD(1,:);N_TFT(1,:);N_CR(1,:);N_UR(1,:);N_UC(1,:);N_SJ(1,:);N_NC(1,:)]','stacked');
xlabel('Population Size','FontSize',18);
ylabel('Prop. of Simuations','FontSize',18);
legend('UD','TFT','CR','UR','UC','SJ','Mixed','Location','northeast')
title({'Effect of Population Size','Dominating Strategy','TFT=CR=UR=UD=UC=SJ=1/6'},'FontSize',18)
tt=['BestEffect of Population Size','Simulations Dominated by each strategy','TFT=CR=UR=UD=UC=SJ=1/6'];
fn=tt(~isspace(tt));
fn=fn(fn~='/');
saveas(fignum,fn);
print('-depsc', fn);

% FIGURE S8 (TOP RIGHT PANEL) - POPULATION SIZE - COPY THE BEST -
% WITHOUT TFT
fignum=figure(6);
axes1 = axes('Parent',fignum);
hold(axes1,'on');
set(axes1,'FontSize',18);
xlim([40 620])
ylim([0 1])
placeholder=zeros(size(N_UD(2,:)));
bar(N,[N_UD(2,:);placeholder;N_CR(2,:);N_UR(2,:);N_UC(2,:);N_SJ(2,:);N_NC(2,:)]','stacked');
xlabel('Population Size','FontSize',18);
ylabel('Prop. of Simulations','FontSize',18);
legend('UD','TFT','CR','UR','UC','SJ','Mixed','Location','southeast')
title({'Effect of Population Size','Dominating Strategy','TFT=0, CR=UR=UD=UC=SJ=1/5'},'FontSize',18)
tt=['BestEffect of Population Size','Simulations Dominated by each strategy','TFT=0, CR=UR=UD=UC=SJ=1/5'];
fn=tt(~isspace(tt));
fn=fn(fn~='/');
fn=fn(fn~=',');
saveas(fignum,fn);
print('-depsc', fn);




%%%%%
% FIGURE S9 - NETWORK DENSITY - COPY THE BEST (TOP PANELS)

clear all
clc
load NS_10_Density_extended.mat % _long

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

% FIGURE S9 (TOP LEFT PANEL) - NETWORK DENSITY - COPY THE BEST -
% WITH TFT
fignum=figure(7);
axes1 = axes('Parent',fignum);
hold(axes1,'on');
set(axes1,'FontSize',18);
xlim([0.01 0.26])
ylim([0 1])
bar(P_Link,[N_UD(1,:);N_TFT(1,:);N_CR(1,:);N_UR(1,:);N_UC(1,:);N_SJ(1,:);N_NC(1,:)]','stacked');
xlabel('Network Density','FontSize',18);
ylabel('Prop. of Simulations','FontSize',18);
legend('UD','TFT','CR','UR','UC','SJ','Mixed','Location','northeast')
title({'Effect of Network Density','Dominating Strategy','TFT=CR=UR=UD=UC=SJ=1/6'},'FontSize',18)
tt=['BestEffect of Network Density','Simulations Dominated by each strategy','TFT=CR=UR=UD=UC=SJ=1/6'];
fn=tt(~isspace(tt));
fn=fn(fn~='/');
saveas(fignum,fn);
print('-depsc', fn);

% FIGURE S9 (TOP RIGHT PANEL) - NETWORK DENSITY - COPY THE BEST -
% WITHOUT TFT
fignum=figure(8);
axes1 = axes('Parent',fignum);
hold(axes1,'on');
set(axes1,'FontSize',18);
xlim([0.01 0.26])
ylim([0 1])
placeholder=zeros(size(N_UD(2,:)));
bar(P_Link,[N_UD(2,:);placeholder;N_CR(2,:);N_UR(2,:);N_UC(2,:);N_SJ(2,:);N_NC(2,:)]','stacked');
xlabel('Network Density','FontSize',18);
ylabel('Prop. of Simulations','FontSize',18);
legend('UD','TFT','CR','UR','UC','SJ','Mixed','Location','southeast')
title({'Effect of Network Density','Dominating Strategy','TFT=0, CR=UR=UD=UC=SJ=1/5'},'FontSize',18)
tt=['BestEffect of Network Density','Simulations Dominated by each strategy','TFT=0, CR=UR=UD=UC=SJ=1/5'];
fn=tt(~isspace(tt));
fn=fn(fn~='/');
fn=fn(fn~=',');
saveas(fignum,fn);
print('-depsc', fn);




%%%%%
% FIGURE S6 - EFFECT OF FORGIVENESS - COPY THE BETTER (BOTTOM PANELS)



close all
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

% FIGURE S6 (BOTTOM LEFT PANEL) - EFFECT OF FORGIVENESS - COPY THE BETTER -
% WITH TFT
fignum=figure(9);
axes1 = axes('Parent',fignum);
hold(axes1,'on');
set(axes1,'FontSize',18);
xlim([0-0.025 max(Pfor)+0.025])
ylim([0 1])
bar(Pfor,[N_UD(1,:);N_TFT(1,:);N_CR(1,:);N_UR(1,:);N_UC(1,:);N_SJ(1,:);N_NC(1,:)]','stacked');
xlabel('Prob. of Forgiveness','FontSize',18);
ylabel('Prop. of Simulations','FontSize',18);
legend('UD','TFT','CR','UR','UC','SJ','Mixed','Location','southwest')
title({'Effect of Forgiveness','Dominating Strategy','TFT=CR=UR=UD=UC=SJ=1/6'},'FontSize',18)
tt=['BetterEffect of Forgiveness','Simulations Dominated by each strategy','TFT=CR=UR=UD=UC=SJ=1/6'];
fn=tt(~isspace(tt));
fn=fn(fn~='/');
saveas(fignum,fn);
print('-depsc', fn);

% FIGURE S6 (BOTTOM RIGHT PANEL) - EFFECT OF FORGIVENESS - COPY THE BETTER -
% WITHOUT TFT
fignum=figure(10);
axes1 = axes('Parent',fignum);
hold(axes1,'on');
set(axes1,'FontSize',18);
xlim([0-0.025 max(Pfor)+0.025])
ylim([0 1])
placeholder=zeros(size(N_UD(2,:)));
bar(Pfor,[N_UD(2,:);placeholder;N_CR(2,:);N_UR(2,:);N_UC(2,:);N_SJ(2,:);N_NC(2,:)]','stacked');
xlabel('Prob. of Forgiveness','FontSize',18);
ylabel('Prop. of Simulations','FontSize',18);
legend('UD','TFT','CR','UR','UC','SJ','Mixed','Location','northeast')
title({'Effect of Forgiveness','Dominating Strategy','TFT=0, CR=UR=UD=UC=SJ=1/5'},'FontSize',18)
tt=['BetterEffect of Forgiveness','Simulations Dominated by each strategy','TFT=0, CR=UR=UD=UC=SJ=1/5'];
fn=tt(~isspace(tt));
fn=fn(fn~='/');
fn=fn(fn~=',');
saveas(fignum,fn);
print('-depsc', fn);


%%%%%
% FIGURE S7 - SPEED OF EVOLUTION - COPY THE BETTER (BOTTOM PANELS)

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

% FIGURE S7 (BOTTOM LEFT PANEL) - SPEED OF EVOLUTION - COPY THE BETTER -
% WITH TFT
fignum=figure(11);
axes1 = axes('Parent',fignum);
hold(axes1,'on');
set(axes1,'FontSize',18);
xlim([0 max(Pevo)+0.01])
ylim([0 1])
bar(Pevo,[N_UD(1,:);N_TFT(1,:);N_CR(1,:);N_UR(1,:);N_UC(1,:);N_SJ(1,:);N_NC(1,:)]','stacked');
xlabel('Prob. of Evolution','FontSize',18);
ylabel('Prop. of Simulations','FontSize',18);
legend('UD','TFT','CR','UR','UC','SJ','Mixed','Location','southwest')
title({'Effect of Evolution','Dominating Strategy','TFT=CR=UR=UD=UC=SJ=1/6'},'FontSize',18)
tt=['BetterEffect of Evolution','Simulations Dominated by each strategy','TFT=CR=UR=UD=UC=SJ=1/6'];
fn=tt(~isspace(tt));
fn=fn(fn~='/');
saveas(fignum,fn);
print('-depsc', fn);

% FIGURE S7 (BOTTOM RIGHT PANEL) - SPEED OF EVOLUTION - COPY THE BETTER -
% WITHOUT TFT
fignum=figure(12);
axes1 = axes('Parent',fignum);
hold(axes1,'on');
set(axes1,'FontSize',18);
xlim([0 max(Pevo)+0.01])
ylim([0 1])
placeholder=zeros(size(N_UD(2,:)));
bar(Pevo,[N_UD(2,:);placeholder;N_CR(2,:);N_UR(2,:);N_UC(2,:);N_SJ(2,:);N_NC(2,:)]','stacked');
xlabel('Prob. of Evolution','FontSize',18);
ylabel('Prop. of Simulations','FontSize',18);
legend('UD','TFT','CR','UR','UC','SJ','Mixed','Location','southwest')
title({'Effect of Evolution','Dominating Strategy','TFT=0, CR=UR=UD=UC=SJ=1/5'},'FontSize',18)
tt=['BetterEffect of Evolution','Simulations Dominated by each strategy','TFT=0, CR=UR=UD=UC=SJ=1/5'];
fn=tt(~isspace(tt));
fn=fn(fn~='/');
fn=fn(fn~=',');
saveas(fignum,fn);
print('-depsc', fn);





%%%%%
% FIGURE S8 - POPULATION SIZE - COPY THE BETTER (BOTTOM PANELS)



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

% FIGURE S8 (BOTTOM LEFT PANEL) - POPULATION SIZE - COPY THE BETTER -
% WITH TFT
fignum=figure(13);
axes1 = axes('Parent',fignum);
hold(axes1,'on');
set(axes1,'FontSize',18);
xlim([40 620])
ylim([0 1])
bar(N,[N_UD(1,:);N_TFT(1,:);N_CR(1,:);N_UR(1,:);N_UC(1,:);N_SJ(1,:);N_NC(1,:)]','stacked');
xlabel('Population Size','FontSize',18);
ylabel('Prop. of Simulations','FontSize',18);
legend('UD','TFT','CR','UR','UC','SJ','Mixed','Location','northeast')
title({'Effect of Population Size','Dominating Strategy','TFT=CR=UR=UD=UC=SJ=1/6'},'FontSize',18)
tt=['BetterEffect of Population Size','Simulations Dominated by each strategy','TFT=CR=UR=UD=UC=SJ=1/6'];
fn=tt(~isspace(tt));
fn=fn(fn~='/');
saveas(fignum,fn);
print('-depsc', fn);

% FIGURE S8 (BOTTOM RIGHT PANEL) - POPULATION SIZE - COPY THE BETTER -
% WITHOUT TFT
fignum=figure(14);
axes1 = axes('Parent',fignum);
hold(axes1,'on');
set(axes1,'FontSize',18);
xlim([40 620])
ylim([0 1])
placeholder=zeros(size(N_UD(2,:)));
bar(N,[N_UD(2,:);placeholder;N_CR(2,:);N_UR(2,:);N_UC(2,:);N_SJ(2,:);N_NC(2,:)]','stacked');
xlabel('Population Size','FontSize',18);
ylabel('Prop. of Simulations','FontSize',18);
legend('UD','TFT','CR','UR','UC','SJ','Mixed','Location','southeast')
title({'Effect of Population Size','Dominating Strategy','TFT=0, CR=UR=UD=UC=SJ=1/5'},'FontSize',18)
tt=['BetterEffect of Population Size','Simulations Dominated by each strategy','TFT=0, CR=UR=UD=UC=SJ=1/5'];
fn=tt(~isspace(tt));
fn=fn(fn~='/');
fn=fn(fn~=',');
saveas(fignum,fn);
print('-depsc', fn);


%%%%%
% FIGURE S9 - NETWORK DENSITY - COPY THE BETTER (BOTTOM PANELS)


clear all
clc
load NS_21_Density_er_extended.mat % _long

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

% FIGURE S9 (BOTTOM LEFT PANEL) - NETWORK DENSITY - COPY THE BETTER -
% WITH TFT
fignum=figure(15);
axes1 = axes('Parent',fignum);
hold(axes1,'on');
set(axes1,'FontSize',18);
xlim([0.01 0.26])
ylim([0 1])
bar(P_Link,[N_UD(1,:);N_TFT(1,:);N_CR(1,:);N_UR(1,:);N_UC(1,:);N_SJ(1,:);N_NC(1,:)]','stacked');
xlabel('Network Density','FontSize',18);
ylabel('Prop. of Simulations','FontSize',18);
legend('UD','TFT','CR','UR','UC','SJ','Mixed','Location','southeast')
title({'Effect of Network Density','Dominating Strategy','TFT=CR=UR=UD=UC=SJ=1/6'},'FontSize',18)
tt=['BetterEffect of Network Density','Simulations Dominated by each strategy','TFT=CR=UR=UD=UC=SJ=1/6'];
fn=tt(~isspace(tt));
fn=fn(fn~='/');
saveas(fignum,fn);
print('-depsc', fn);

% FIGURE S9 (BOTTOM RIGHT PANEL) - NETWORK DENSITY - COPY THE BETTER -
% WITHOUT TFT
fignum=figure(16);
axes1 = axes('Parent',fignum);
hold(axes1,'on');
set(axes1,'FontSize',18);
xlim([0.01 0.26])
ylim([0 1])
placeholder=zeros(size(N_UD(2,:)));
bar(P_Link,[N_UD(2,:);placeholder;N_CR(2,:);N_UR(2,:);N_UC(2,:);N_SJ(2,:);N_NC(2,:)]','stacked');
xlabel('Network Density','FontSize',18);
ylabel('Prop. of Simulations','FontSize',18);
legend('UD','TFT','CR','UR','UC','SJ','Mixed','Location','northeast')
title({'Effect of Network Density','Dominating Strategy','TFT=0, CR=UR=UD=UC=SJ=1/5'},'FontSize',18)
tt=['BetterEffect of Network Density','Simulations Dominated by each strategy','TFT=0, CR=UR=UD=UC=SJ=1/5'];
fn=tt(~isspace(tt));
fn=fn(fn~='/');
fn=fn(fn~=',');
saveas(fignum,fn);
print('-depsc', fn);