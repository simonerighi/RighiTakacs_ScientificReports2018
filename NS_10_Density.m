% Run simulations to explore the effect of Network Density in two types of populations starting with:
%- all type of agents equally represented 
%- with all type of agents equally represented except for TFT=0.
% The evolution is copy the best.


clear all
close all
clc

Niter=100;
N=240;
P_Link=[0.025:0.025:0.25];
tmax=100000; %%%%%%%%
Prop_TFT=[1/6 0];
Prop_CR=[1/6 1/5];
Prop_UR=[1/6 1/5];
Prop_UD=[1/6 1/5];
Prop_UC=[1/6 1/5];
Prop_SJ=[1/6 1/5];

Pevo=0.05; % evolution probability
Perr=0; % probability of committing errors
Pfor=0; % forgiveness

TFTtype='e'; % is set to 'e' for evil TFT (starts by defecting) by baseline. Set to 'n' for nice TFT. 
update_type='st';

randseed=round(rand(Niter,1)*1000000);


p=parpool;
for j=1:length(Prop_UD) % turn around the 4 lines
    for k=1:length(P_Link) % for each pevo
        clc
        display(['Experiment Number= ' num2str(j)])
        display(['Plink= ' num2str(P_Link(k))])
        P_UD=Prop_UD(j);
        P_TFT=Prop_TFT(j);
        P_CR=Prop_CR(j);
        P_UR=Prop_UR(j);
        P_UC=Prop_UC(j);
        P_SJ=Prop_SJ(j);
        P_Lin=P_Link(k);
        
        
        parfor i=1:Niter % 100 simulations

                display(['Iteration number ' num2str(i)])
                %if tconv(j,k,i)>=tmax_old %
                [N_types(:,j,k,i),number_of_cooperators(j,k,i),number_of_plays(j,k,i),...
                    tconv(j,k,i),number_true_cooperators(j,k,i)]=RT2016_fct(N,P_Lin,tmax,P_UD,P_TFT,...
                    P_CR,P_UR,P_UC,P_SJ,Pevo,Perr,Pfor,randseed(i),1,TFTtype,update_type);
                
        end
        save('NS_10_Density_extended.mat')
    end
end

delete(p)
