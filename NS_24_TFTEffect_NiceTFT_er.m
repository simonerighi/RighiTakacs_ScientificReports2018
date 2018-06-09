% Run simulations to explore the effect of the initial proportion of TFT in
% a population. The rest of the population is equally share among all types
% of agents. Evolution is copy the better, tit-for-tat is of the nice type.

clear all
close all
clc

Niter=100;
N=240;
P_Link=0.10;
tmax=100000; %%%%%%%%
Prop_TFT=[0 0.01];
Prop_TFT=[Prop_TFT [0.02:0.02:0.16]];
Prop_UD=(1-Prop_TFT)./5;
Prop_CR=(1-Prop_TFT)./5;
Prop_UR=(1-Prop_TFT)./5;
Prop_UC=(1-Prop_TFT)./5;
Prop_SJ=(1-Prop_TFT)./5;

Pevo=0.05; % evolution probability
Perr=0; % probability of committing errors
Pfor=0; % forgiveness


TFTtype='n'; % is set to 'e' for evil TFT (starts by defecting) by baseline. Set to 'n' for nice TFT. 
update_type='er'; % 'st': copy the best; 'er': copy the better

randseed=round(rand(Niter,1)*1000000);

p=parpool;

for j=1:length(Prop_TFT)
    clc
    display(['TFT= ' num2str(Prop_TFT(j))])
    P_UD=Prop_UD(j);
    P_TFT=Prop_TFT(j);
    P_CR=Prop_CR(j);
    P_UR=Prop_UR(j);
    P_UC=Prop_UC(j);
    P_SJ=Prop_SJ(j);
    parfor i=1:Niter
        display(['Iteration number ' num2str(i)])
            [N_types(:,j,i),number_of_cooperators(j,i),number_of_plays(j,i),...
                tconv(j,i),number_true_cooperators(j,i)]=RT2016_fct(N,P_Link,tmax,P_UD,P_TFT,...
                P_CR,P_UR,P_UC,P_SJ,Pevo,Perr,Pfor,randseed(i),1,TFTtype,update_type);
    end
    save('NS_24_TFTEffect_NiceTFT_er.mat')
end

delete(p);