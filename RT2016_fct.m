function [N_types,number_of_cooperators,number_of_plays,tconv,number_true_cooperators]=...
RT2016_fct(N,P_Link,tmax,Prop_UD,Prop_TFT,Prop_conrec,Prop_unconrec,Prop_UC,Prop_SJ,Pevo,Perr,Pfor,randseed,efficiencyTFT,TFTtype,update_type)
% Contains a single iteration of the model discussed in Righi S., Takacs K. (2018) "Social Closure and the Evolution of
% Cooperation via Indirect Reciprocity", Scientific Reports.
%
% Output: 
%   N_types: number of agents that, at the end of the simulation, play each strategy)
%   number_of_cooperators: number of cooperation acts in the last step of the simulation
%   number_of_plays: number of actions (either of cooperate or defect) in the last step of the simulation
%   tconv: time at which the model has converged.
%   number_true_cooperators:  number of cooperation acts in the last step of the simulation - those that cooperated due to trembling hand.
%
%Input:
%   N: number of agents
%   P_Link: density of Erdos-Renyi random graph on which interactions are
%   constrained
%   tmax: maximum number of steps allowed
%   Prop_UD,Prop_TFT,Prop_conrec, Prop_unconrec,Prop_UC,Prop_SJ: proportion of each type of agents (must sum to one)
%   Pevo: probability of an agent to evolve its strategy at each step
%   Perr: probability of an agent to play the opposite strategy of what his  strategy dictates (trembling hand)
%   Pfor: probability of indirectly reciprocal agents to forgive Defection and observe another interaction to condition own behaviour.
%   randseed: random seed (to have the same populations on different parameter sets
%   efficiencyTFT: probability that TFT remembers past behaviour of interacting partner
%   TFTtype: TFT starts by defecting (evil tft) or by cooperating (nice tft)
%   update_type: copy the best or copy the better


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
end
[Vct_types] = Create_Vct_types(N, Prop_UD, Prop_TFT,Prop_conrec,Prop_unconrec,Prop_UC,Prop_SJ); % create types
[Adj_LM] = Initialize_Actions (Adj,N); % initalize previous actions 


% Initialize probes
converged=0;
tconv=NaN;
[converged,N_types,tconv]=check_convergence(N,N_types,1,converged,tmax,tconv,Vct_types);
number_of_cooperators=zeros(tmax,1);
number_of_plays=zeros(tmax,1);
number_true_cooperators=zeros(tmax,1);
%[init_degrees, init_meandegree]=compute_degrees(Adj,N);

Adj_LMold=Adj_LM; %valutare se occorre mettere questa assegnazine

for t=2:tmax
    if repetition==0;
        clc
        t
    end
    
    payoff_total=zeros(N,1);
    ninteractions=zeros(N,1);
    
    Adj_LMold=Adj_LM; %valutare se occorre mettere questa assegnazine

    for ego=1:N % per tutti gli agenti % CHECK THAT ERROR DOES NOT CREATE PROBLEM WITH PLAYING TWICE EACH COUPLE
        PARTNERS=find(Adj(ego,:)==1);
        for j=1:length(PARTNERS) % for each partner of each agent
            alter=PARTNERS(j);

            [play_ego, Adj_LM] = Compute_move(Adj,ego,alter,Pfor,efficiencyTFT,Vct_types,Adj_LM,Adj_LMold,TFTtype); % compute PD strategy of ego
            err_e=1; if rand<Perr; play_ego=-play_ego; Adj_LM(ego,alter)=play_ego; err_e=0; end; % sometimes there is an error in behaviour (instead of playing D you play C and viceversa);
            [play_alter, Adj_LM] = Compute_move(Adj,alter,ego,Pfor,efficiencyTFT,Vct_types,Adj_LM,Adj_LMold,TFTtype); % compute PD strategy of alter
            err_a=1; if rand<Perr; play_alter=-play_alter; Adj_LM(alter,ego)=play_alter; err_a=0; end; % sometimes there is an error in behaviour (instead of playing D you play C and viceversa);
            [payoff_ego, payoff_alter]= Compute_Payoffs (play_ego,play_alter,Punishment,Sucker,Temptation,Reward); % payoff from play.
       
            payoff_total(ego)=payoff_total(ego) + payoff_ego;
            payoff_total(alter)=payoff_total(alter) + payoff_alter;
            ninteractions(ego)=ninteractions(ego)+1;
            ninteractions(alter)=ninteractions(alter)+1;
       
            if play_ego==1; number_of_cooperators(t)=number_of_cooperators(t)+1; number_true_cooperators(t)=number_true_cooperators(t)+1*err_e; end; % if ego played C in increase the counter of cooperation
            if play_alter==1; number_of_cooperators(t)=number_of_cooperators(t)+1; number_true_cooperators(t)=number_true_cooperators(t)+1*err_a; end; % if alter played C in increase the counter of cooperation
            number_of_plays(t)=number_of_plays(t)+2; % if we are here they played and i count it.
    	end
    end
    payoff_avg=payoff_total./ninteractions; % compute average payoffs    
    [Vct_types]=strategy_update(Adj, payoff_avg,N,Pevo,Vct_types,update_type); % copy the best!
    [converged,N_types,tconv]=check_convergence(N,N_types,t,converged,tmax,tconv,Vct_types);
    if converged==1 && t>2*tconv; break; end % if it has converged
  
% copy commented code below here if you are interested in network shocks or in
% network open and closed driads.    
end
toc
%[final_degrees, final_meandegree]=compute_degrees(Adj,N);

if converged==0 % set time of convergence in absence of convergence
    tconv=tmax;
end



if repetition==0 % time figure if this is a single iteration of the model
    figure(1)
    plot(N_types(1,1:tconv)/N,'k')
    hold on
    plot(N_types(2,1:tconv)/N,'b')
    hold on
    plot(N_types(3,1:tconv)/N,'r')
    hold on
    plot(N_types(4,1:tconv)/N,'g')
    hold on
    plot(N_types(5,1:tconv)/N,'m')
    xlabel('Time')
    ylabel('Proportion of agents')
    title('Proportion of types vs time')
    legend('UD','TFT','Reciprocal Connected','Reciprocal UnConnected','UC',0)

    figure(2)
    plot(number_of_cooperators(1:tconv)./number_of_plays(1:tconv))
    xlabel('Time')
    ylabel('Proportion of Cooperators')
    title('Proportion of Cooperators vs Time')
   
    
    
end


number_of_cooperators=number_of_cooperators(tconv);
number_of_plays=number_of_plays(tconv);
number_true_cooperators=number_true_cooperators(tconv);

%NumUD %1
%NumCond %2
%NumRecConn %3
%NumRecUnConn %4
%NumUC %5



% copy commented code above if you are interested in network shocks or in
% network open and closed driads.
%   n_link=count_links(Adj, N); % count the number of links
%   % Include random shocks to the network
%   if P_shock>0
%     Adj=Rand_ntw_shock(Adj,N, n_link,P_shock);  
%   end
%     
%   for i=1:N
%       if rand<Pclose % if there is a triad to close
%         [Adj]=closetriad(Adj,i);
%       end
%       if rand<Popen % if there is a triad to open. 
%         [Adj]=opentriad(Adj,i,N);
%       end 
%   end
%     figure(8)
%     subplot(2,1,1);
%     histfit(init_degrees./N)
%     xlabel('Normalized Degree')
%     ylabel('Frequency')
%     title('Initial Degree Distribution')
%     subplot(2,1,2);
%     histfit(final_degrees./N)
%     xlabel('Normalized Degree')
%     ylabel('Frequency')
%     title('Final Degree Distribution')

