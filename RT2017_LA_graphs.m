function [prop_coop,prop_true_coop,tconv]=...
    RT2017_LA_graphs(N,P_Link,tmax,Prop_UD,Prop_TFT,Prop_conrec,Prop_unconrec,Prop_UC,Prop_SJ,init_C,Perr,Pfor,...
    randseed,efficiencyTFT,TFTtype,update_type)
% runs the model with all agents of type CR and creates files (vector,
% partition and network) for visualization in Pajek (Figures S16)

rng(randseed)

%%%%%%%%%%%%%%%
%global repetition


% GAME TYPE PARAMETERS
Temptation=5;
Reward=3;
Punishment=1;
Sucker=0;


% time saving parameters
%repetition=1; % is it a repetition then ==1, if you want the historic of vars then set to 0.

%%%%%%%%%%%%%%%
% Probes
repetition=1;
if repetition==0
    N_types=zeros(6,tmax); % number of agents types at each time (5xtmax size)
else
    N_types=zeros(6,1);
end


%%%%%%%%%%%%%%%

tic
% INITIALIZATIONS
if P_Link==-1 % this signal to use the lattice method
    Adj=lattice_structure(N); %create lattice network
else
    [Adj, ~]=RandGraph(N,P_Link); % create network
    adj2pajek(Adj,'random.net');

end
[Vct_types] = Create_Vct_types(N, Prop_UD, Prop_TFT,Prop_conrec,Prop_unconrec,Prop_UC,Prop_SJ); % create types
[Adj_LM] = Initialize_Actions (Adj,N,init_C); % initalize previous actions


% Initialize probes
converged=0;
tconv=NaN;
[converged,N_types,tconv]=check_convergence(N,N_types,1,converged,tmax,tconv,Vct_types);
number_of_cooperators=zeros(tmax,1);
number_of_plays=zeros(tmax,1);
number_true_cooperators=zeros(tmax,1);
%[init_degrees, init_meandegree]=compute_degrees(Adj,N);

Adj_LMold=Adj_LM; %valutare se occorre mettere questa assegnazine

countgraph=1;
for t=2:tmax
    if mod(t,100)==1
        t
    end
    
    ListCoop=zeros(N,1);
    ListTot=zeros(N,1);
    
    Adj_LMold=Adj_LM; %valutare se occorre mettere questa assegnazine
    
    for ego=1:N % per tutti gli agenti % CHECK THAT ERROR DOES NOT CREATE PROBLEM WITH PLAYING TWICE EACH COUPLE
        PARTNERS=find(Adj(ego,:)==1);
        for j=1:length(PARTNERS) % for each partner of each agent
            alter=PARTNERS(j);
            
            [play_ego, Adj_LM] = Compute_move(Adj,ego,alter,Pfor,efficiencyTFT,Vct_types,Adj_LM,Adj_LMold,TFTtype); % compute PD strategy of ego
            err_e=1; if rand<Perr; play_ego=-play_ego; Adj_LM(ego,alter)=play_ego; err_e=0; end % sometimes there is an error in behaviour (instead of playing D you play C and viceversa);
            [play_alter, Adj_LM] = Compute_move(Adj,alter,ego,Pfor,efficiencyTFT,Vct_types,Adj_LM,Adj_LMold,TFTtype); % compute PD strategy of alter
            err_a=1; if rand<Perr; play_alter=-play_alter; Adj_LM(alter,ego)=play_alter; err_a=0; end % sometimes there is an error in behaviour (instead of playing D you play C and viceversa);

            if play_ego==1; ListCoop(ego)=ListCoop(ego)+1; end
            if play_alter==1; ListCoop(alter)=ListCoop(alter)+1; end
            ListTot(ego)= ListTot(ego)+1;
            ListTot(alter)= ListTot(alter)+1;

            
            
            if play_ego==1; number_of_cooperators(t)=number_of_cooperators(t)+1; number_true_cooperators(t)=number_true_cooperators(t)+1*err_e; end % if ego played C in increase the counter of cooperation
            if play_alter==1; number_of_cooperators(t)=number_of_cooperators(t)+1; number_true_cooperators(t)=number_true_cooperators(t)+1*err_a; end % if alter played C in increase the counter of cooperation
            number_of_plays(t)=number_of_plays(t)+2; % if we are here they played and i count it.
            
        end
    end
    
    if number_of_cooperators(t)==number_of_plays(t) || number_of_cooperators(t)==0
        converged=1;
        tconv=t;
        break;
    else
        converged=0;
    end
        
    % copy commented code below here if you are interested in network shocks or in
    % network open and closed driads.
    
    if t>=tmax-10
       namevect=['vect_' num2str(countgraph) '.vec'];
       fraction=ListCoop./ListTot;
       create_vector(fraction,namevect);
       countgraph=countgraph+1;
    end
    
    
    
end


toc

if converged==0 % set time of convergence in absence of convergence
    tconv=tmax;
end

if P_Link==-1 && repetition==0
    create_partition(Vct_types,'partition.clu')
    fraction=ListCoop./ListTot
    create_vector(fraction,'vector.vec');
end

prop_true_coop=number_true_cooperators(tconv)./number_of_plays(tconv);
prop_coop=number_of_cooperators(tconv)./number_of_plays(tconv);

    
% figure(2)
% plot(number_of_cooperators(1:tconv)./number_of_plays(1:tconv))
% xlabel('Time')
% ylabel('Proportion of Cooperators')
% title('Proportion of Cooperators vs Time')


