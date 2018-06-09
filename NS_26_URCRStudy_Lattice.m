% Run simulations to study the relative performance of Indirect Reciprocity
% strategies, in presence  of SJ in the population, and on a Lattice
% network instead of the baseline random network.


clear all
close all
clc

Niter=100;
N=240;
P_Link=-1;
tmax=100000; %%%%%%%%
Prop_TFT=0;
Prop_CR=[0:0.05:0.5];
Prop_UR=[0:0.05:0.5];


Pevo=0.05; % evolution probability
Perr=0; % probability of committing errors
Pfor=0; % forgiveness


TFTtype='e'; % is set to 'e' for evil TFT (starts by defecting) by baseline. Set to 'n' for nice TFT. 
update_type='st'; % 'st': copy the best; 'er': copy the better

randseed=round(rand(Niter,1)*1000000);


p=parpool;

for j=1:length(Prop_CR)
    
    
    for k=1:length(Prop_UR)
        clc
        display(['CR= ' num2str(Prop_CR(j))])
        display(['UR= ' num2str(Prop_CR(k))])
        Prop_UD=(1-Prop_CR(j)-Prop_UR(k))/3;
        Prop_UC=(1-Prop_CR(j)-Prop_UR(k))/3;
        Prop_SJ=(1-Prop_CR(j)-Prop_UR(k))/3;
        
        P_CR=Prop_CR(j);
        P_UR=Prop_UR(k);
        parfor i=1:Niter
            
                
                display(['Iteration number ' num2str(i)])
                [N_types(:,j,k,i),number_of_cooperators(j,k,i),number_of_plays(j,k,i),...
                    tconv(j,k,i),number_true_cooperators(j,k,i)]=RT2016_fct(N,P_Link,tmax,Prop_UD,Prop_TFT,...
                    P_CR,P_UR,Prop_UC,Prop_SJ,Pevo,Perr,Pfor,randseed(i),1,TFTtype,update_type);
            
        end
        save('NS_26_URCRStudy_lattice_newlattice.mat')
    end
end

delete(p)