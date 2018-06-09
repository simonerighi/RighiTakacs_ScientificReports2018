% Creates a network with agents of only one type (UR) and a given initial
% level of cooperation. Run until the level of cooperation stabilizes
% From line 51

clear all
close all
clc

Niter=10;
N=240;
P_Link=-1;
tmax=100000;
Prop_UD=0;
Prop_TFT=0;
Prop_CR=0;
Prop_UR=1;
Prop_UC=0;
Prop_SJ=0;

Pevo=0.05; % evolution probability
Perr=0; % probability of committing errors %0.01
Pfor=0; % forgiveness % 0.3
efficiencyTFT=1;

TFTtype='e'; % is set to 'e' for evil TFT (starts by defecting) by baseline. Set to 'n' for nice TFT. 
update_type='st'; % 'st': copy the best; 'er': copy the better

randseed=round(rand(Niter,1)*1000000);
p=parpool;

init_C=[0:0.05:1]; % initial proportiono of Cooperation Actions

for j=1:length(init_C)
    thisinitC=init_C(j);
    parfor i=1:Niter
        [thisinitC i]
        
        [prop_coop(i,j),prop_true_coop(i,j),tconv(i,j)]=...
            RT2017_LA(N,P_Link,tmax,Prop_UD,Prop_TFT,...
            Prop_CR,Prop_UR,Prop_UC,Prop_SJ,thisinitC,Perr,Pfor,...
            randseed(i),efficiencyTFT,TFTtype,update_type);
        %end
    end
    save('NS_29_testUR_newlattice.mat')
end
  
delete(p);

%%%%%%%
% Run the same simulations as above but with agents all of type CR.

clear all
close all
clc
Niter=10;

N=240;
P_Link=-1;
tmax=100000;
Prop_UD=0;
Prop_TFT=0;
Prop_CR=1;
Prop_UR=0;
Prop_UC=0;
Prop_SJ=0;

Pevo=0.05; % evolution probability
Perr=0; % probability of committing errors %0.01
Pfor=0; % forgiveness % 0.3
efficiencyTFT=1;

TFTtype='e'; % is set to 'e' for evil TFT (starts by defecting) by baseline. Set to 'n' for nice TFT. 
update_type='st'; % 'st': copy the best; 'er': copy the better

randseed=round(rand(Niter,1)*1000000);

p=parpool;

init_C=[0:0.05:1]; % initial proportiono of Cooperation Actions

for j=1:length(init_C)
    thisinitC=init_C(j);
    parfor i=1:Niter
        [thisinitC i]
        
        [prop_coop(i,j),prop_true_coop(i,j),tconv(i,j)]=...
            RT2017_LA(N,P_Link,tmax,Prop_UD,Prop_TFT,...
            Prop_CR,Prop_UR,Prop_UC,Prop_SJ,thisinitC,Perr,Pfor,...
            randseed(i),efficiencyTFT,TFTtype,update_type);
    end
    save('NS_29_testCR_newlattice.mat')
end

    
delete(p);
