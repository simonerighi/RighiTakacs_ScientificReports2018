% Run a single iteration of the model, with all agents of type CR. This
% version of the software creates the files for pajek visualization in
% figure S16

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

init_C=0.2; % initial proportiono of Cooperation Actions

thisinitC=init_C(1);

[prop_coop,prop_true_coop,tconv]=...
    RT2017_LA_graphs(N,P_Link,tmax,Prop_UD,Prop_TFT,...
    Prop_CR,Prop_UR,Prop_UC,Prop_SJ,thisinitC,Perr,Pfor,...
    randseed(1),efficiencyTFT,TFTtype,update_type);


    