% This script Reproduces Figure 3 of Righi, Takacs (2018), Scientific
% Reports as one figure.
% The scripts extract from the simulations the necessary data that are then passed to a function (create figure 3 as Uified)which
% generates the actual figure. 
% NOTE: to work in needs to be placed in the location of the simulations'
% outputs



% 1 populationsize - copy the best
% 2 network density - copy the best
% 3 forgiveness - copy the best
% 4 Evolution - copy the best
% 5 populationsize - copy the better
% 6 network density - copy the better
% 7 forgiveness - copy the better
% 8 Evolution - copy the better
% 
% Xvalue, Yvalue,StdValue



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

Pfor=[Pfor;Pfor];
Pfor_Copythebest=Pfor;
Pfor_m_prop_coop_r_Copythebest=m_prop_coop(1:2,:);
Pfor_std_prop_coop_r_Copythebest=std_prop_coop(1:2,:);
save('dataforfigure3_1.mat','Pfor_Copythebest','Pfor_m_prop_coop_r_Copythebest','Pfor_std_prop_coop_r_Copythebest');

clear all

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

Pevo=[Pevo;Pevo];
Pevo_Copythebest=Pevo;
Pevo_m_prop_coop_r_Copythebest=m_prop_coop(1:2,:);
Pevo_std_prop_coop_r_Copythebest=std_prop_coop(1:2,:);
save('dataforfigure3_2.mat','Pevo_Copythebest','Pevo_m_prop_coop_r_Copythebest','Pevo_std_prop_coop_r_Copythebest');
clear all



% Grafici: (1) proportion of true cooperators (2-6) proportion of simulations dominated (absolutely) by: TFT, CR, UR, UD, UC
% (7-11) proportion of simulations dominated (relatively) by: TFT, CR, UR, UD, UC
%asse x: reference variable (Pfor) one 
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


N=[N;N];
N_Copythebest=N;
N_m_prop_coop_r_Copythebest=m_prop_coop(1:2,:);
N_std_prop_coop_r_Copythebest=std_prop_coop(1:2,:);
save('dataforfigure3_3.mat','N_Copythebest','N_m_prop_coop_r_Copythebest','N_std_prop_coop_r_Copythebest');
clear all


% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%   TENTH PART (PLINK Study)  %%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Grafici: (1) proportion of true cooperators (2-6) proportion of simulations dominated (absolutely) by: TFT, CR, UR, UD, UC
% (7-11) proportion of simulations dominated (relatively) by: TFT, CR, UR, UD, UC
%asse x: reference variable (Pfor) one 
clear all

clc


load NS_10_Density_extended.mat% _long

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


P_Link=[P_Link;P_Link];
P_Link_Copythebest=P_Link;
P_Link_m_prop_coop_r_Copythebest=m_prop_coop(1:2,:);
P_Link_std_prop_coop_r_Copythebest=std_prop_coop(1:2,:);
save('dataforfigure3_4.mat','P_Link_Copythebest','P_Link_m_prop_coop_r_Copythebest','P_Link_std_prop_coop_r_Copythebest');
clear all





% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%   17 PART (Pfor Study er)  %%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Grafici: (1) proportion of true cooperators (2-6) proportion of simulations dominated (absolutely) by: TFT, CR, UR, UD, UC
% (7-11) proportion of simulations dominated (relatively) by: TFT, CR, UR, UD, UC
%asse x: reference variable (Pfor) one 
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


Pfor_Copythebetter=Pfor;
Pfor_m_prop_coop_r_Copythebette=m_prop_coop(1:2,:);
Pfor_std_prop_coop_r_Copythebetter=std_prop_coop(1:2,:);
save('dataforfigure3_5.mat','Pfor_Copythebetter','Pfor_m_prop_coop_r_Copythebette','Pfor_std_prop_coop_r_Copythebetter');
clear all


% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%   19 PART (Pevo Study er)  %%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Grafici: (1) proportion of true cooperators (2-6) proportion of simulations dominated (absolutely) by: TFT, CR, UR, UD, UC
% (7-11) proportion of simulations dominated (relatively) by: TFT, CR, UR, UD, UC
%asse x: reference variable (Pfor) one 
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


Pevo_Copythebetter=Pevo;
Pevo_m_prop_coop_r_Copythebette=m_prop_coop(1:2,:);
Pevo_std_prop_coop_r_Copythebetter=std_prop_coop(1:2,:);
save('dataforfigure3_6.mat','Pevo_Copythebetter','Pevo_m_prop_coop_r_Copythebette','Pevo_std_prop_coop_r_Copythebetter');
clear all



% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%   20 PART (N Study er)  %%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Grafici: (1) proportion of true cooperators (2-6) proportion of simulations dominated (absolutely) by: TFT, CR, UR, UD, UC
% (7-11) proportion of simulations dominated (relatively) by: TFT, CR, UR, UD, UC
%asse x: reference variable (Pfor) one 
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

N_Copythebetter=N;
N_m_prop_coop_r_Copythebette=m_prop_coop(1:2,:);
N_std_prop_coop_r_Copythebetter=std_prop_coop(1:2,:);
save('dataforfigure3_7.mat','N_Copythebetter','N_m_prop_coop_r_Copythebette','N_std_prop_coop_r_Copythebetter');
clear all




% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%   21 PART (PLINK Study)  %%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Grafici: (1) proportion of true cooperators (2-6) proportion of simulations dominated (absolutely) by: TFT, CR, UR, UD, UC
% (7-11) proportion of simulations dominated (relatively) by: TFT, CR, UR, UD, UC
%asse x: reference variable (Pfor) one 
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


P_Link_Copythebetter=P_Link;
P_Link_m_prop_coop_r_Copythebette=m_prop_coop(1:2,:);
P_Link_std_prop_coop_r_Copythebetter=std_prop_coop(1:2,:);
save('dataforfigure3_8.mat','P_Link_Copythebetter','P_Link_m_prop_coop_r_Copythebette','P_Link_std_prop_coop_r_Copythebetter');
clear all

load dataforfigure3_1.mat
load dataforfigure3_2.mat
load dataforfigure3_3.mat
load dataforfigure3_4.mat
load dataforfigure3_5.mat
load dataforfigure3_6.mat
load dataforfigure3_7.mat
load dataforfigure3_8.mat

% 1 populationsize - copy the best
% 2 network density - copy the best
% 3 forgiveness - copy the best
% 4 Evolution - copy the best
% 5 populationsize - copy the better
% 6 network density - copy the better
% 7 forgiveness - copy the better
% 8 Evolution - copy the better
% 
% Xvalue, Yvalue,StdValue

createfigure3_asunified(N_Copythebest,N_m_prop_coop_r_Copythebest,N_std_prop_coop_r_Copythebest,...
P_Link_Copythebest,P_Link_m_prop_coop_r_Copythebest,P_Link_std_prop_coop_r_Copythebest,...
Pfor_Copythebest,Pfor_m_prop_coop_r_Copythebest,Pfor_std_prop_coop_r_Copythebest,...
Pevo_Copythebest,Pevo_m_prop_coop_r_Copythebest,Pevo_std_prop_coop_r_Copythebest,...
N_m_prop_coop_r_Copythebette,N_std_prop_coop_r_Copythebetter,...
P_Link_m_prop_coop_r_Copythebette,P_Link_std_prop_coop_r_Copythebetter,...
Pfor_m_prop_coop_r_Copythebette,Pfor_std_prop_coop_r_Copythebetter,...
Pevo_m_prop_coop_r_Copythebette,Pevo_std_prop_coop_r_Copythebetter);