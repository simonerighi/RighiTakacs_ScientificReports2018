% Run simulations to explore the effect of Speed of evolution in four types of populations starting with:
%- all type of agents equally represented 
%- with all type of agents equally represented except for TFT=0.
%- WIth 60% of CR and the rest of the population divided among UD, UC,SJ.
%- WIth 60% of UR and the rest of the population divided among UD, UC,SJ.
% The evolution is copy the best.


clear all
close all
clc

Niter=100;
N=240;
P_Link=0.10;
tmax=100000; %%%%%%%%
Prop_TFT=[1/6 0 0 0];
Prop_CR=[1/6 1/5 6/10 0];
Prop_UR=[1/6 1/5 0 6/10];
Prop_UD=[1/6 1/5 4/30 4/30];
Prop_UC=[1/6 1/5 4/30 4/30];
Prop_SJ=[1/6 1/5 4/30 4/30];

Pevo=[0.01:0.02:0.21]; % evolution probability
Perr=0; % probability of committing errors
Pfor=0; % forgiveness

TFTtype='e'; % is set to 'e' for evil TFT (starts by defecting) by baseline. Set to 'n' for nice TFT. 
update_type='st'; % 'st': copy the best; 'er': copy the better

randseed=round(rand(Niter,1)*1000000);



p=parpool;


for j=1:length(Prop_UD) % turn around the 4 lines
    for k=1:length(Pevo) % for each pevo
        
        clc
        display(['Experiment Number= ' num2str(j)])
        display(['Pevo= ' num2str(Pevo(k))])

        P_UD=Prop_UD(j);
        P_TFT=Prop_TFT(j);
        P_CR=Prop_CR(j);
        P_UR=Prop_UR(j);
        P_UC=Prop_UC(j);
        P_SJ=Prop_SJ(j);
        Pev=Pevo(k);
        
        parfor i=1:Niter % 100 simulations
                display(['Iteration number ' num2str(i)])
                [N_types(:,j,k,i),number_of_cooperators(j,k,i),number_of_plays(j,k,i),...
                    tconv(j,k,i),number_true_cooperators(j,k,i)]=RT2016_fct(N,P_Link,tmax,P_UD,P_TFT,...
                    P_CR,P_UR,P_UC,P_SJ,Pev,Perr,Pfor,randseed(i),1,TFTtype,update_type);
        end
        save('NS_08_PevoStudy.mat')
    end
end

delete(p)
