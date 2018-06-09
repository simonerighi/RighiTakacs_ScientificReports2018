% Run simulations to explore the effect of TFT efficiency in a setup where
% TFT is nice (starts off by cooperating) and the evolution is copy best.

clear all
close all
clc

Niter=100;
N=240;
P_Link=0.10;
tmax=100000; %%%%%%%%
Prop_UD=1/6;
Prop_TFT=1/6;
Prop_CR=1/6;
Prop_UR=1/6;
Prop_UC=1/6;
Prop_SJ=1/6;

Pevo=0.05; % evolution probability
Perr=0; % probability of committing errors
Pfor=0; % forgiveness


TFTtype='n'; % is set to 'e' for evil TFT (starts by defecting) by baseline. Set to 'n' for nice TFT. 
update_type='st';

TFTEfficiency=0:0.1:1;

randseed=round(rand(Niter,1)*1000000);

p=parpool;

for i=1:length(TFTEfficiency) % for each pevo
    clc
    display(['Tft Efficiency= ' num2str(TFTEfficiency(i))])
    TFTEff=TFTEfficiency(i);
    parfor j=1:Niter % 100 simulations
                    
            display(['Iteration number ' num2str(j)])
            tic
            [N_types(:,i,j),number_of_cooperators(i,j),number_of_plays(i,j),tconv(i,j),number_true_cooperators(i,j)]...
                =RT2016_fct(N,P_Link,tmax,Prop_UD,Prop_TFT,Prop_CR,Prop_UR,Prop_UC,Prop_SJ,Pevo,Perr,Pfor,randseed(j),TFTEff,TFTtype,update_type);
            toc
    end
    save('NS_31_TftEfficiency_NiceTFT.mat')
end

delete(p)
