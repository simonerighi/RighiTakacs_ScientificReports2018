% Run 1000 simulations for population starting off as equally shared among
% all types of agents and copy the best evolutionary rule. Interactions are
% constrained on a Lattice.

clear all
close all
clc

Niter=1000;
N=240;
P_Link=-1;
tmax=100000;
Prop_UD=1/6;
Prop_TFT=1/6;
Prop_CR=1/6;
Prop_UR=1/6;
Prop_UC=1/6;
Prop_SJ=1/6;

Pevo=0.05; % evolution probability
Perr=0; % probability of committing errors %0.01
Pfor=0; % forgiveness % 0.3


TFTtype='e'; % is set to 'e' for evil TFT (starts by defecting) by baseline. Set to 'n' for nice TFT. 
update_type='st'; % 'st': copy the best; 'er': copy the better

randseed=round(rand(Niter,1)*1000000);


p=parpool;

parfor i=1:Niter
    i        [N_types(:,i),number_of_cooperators(i),number_of_plays(i),...
            tconv(i),number_true_cooperators(i)]=RT2016_fct(N,P_Link,tmax,Prop_UD,Prop_TFT,...
            Prop_CR,Prop_UR,Prop_UC,Prop_SJ,Pevo,Perr,Pfor,randseed(i),1,TFTtype,update_type);
end
save('NS_25_AllEqual_lattice_newlattice.mat')

    
delete(p)