function [Vct_types]=strategy_update(Adj, payoff_avg,N,Pevo,Vct_types,update_type)
% Evolutionary Mechanism for  Righi S., Takacs K. (2018) "Social Closure and the Evolution of
% Cooperation via Indirect Reciprocity", Scientific Reports.
% Interactions are constrained on a network. When one agent is selected for
% update (with probability Pevo) he compares its payoff with that of
% neighbours, adopting the behaviour of one of them:
% either the BEST OF THEM (the one with the highest payoff)
% or just one of the BETTER (one with a payoff higher than his own.

Vct_typesOld=Vct_types;

if update_type=='st'
    % copy the best strategy
    for i=1:N
        if rand<Pevo
            my_connections=Adj(i,:);%  i connections
            my_connections(i)=1; % i also take in consideration itself.
            [Mpayoff,pos]=max(payoff_avg.*my_connections'); % find the maximum payoff in i neighbourhood
            Max_agents=find(payoff_avg==Mpayoff); % find who are the agents carrying that payoff
            transformed_into=Max_agents(ceil(rand*length(Max_agents))); %choose one of them
            Vct_types(i)=Vct_typesOld(transformed_into); % i transform itself in that agent
            clear Mpayoff Max_agents transformed_into my_connections
        end
    end
else % copy the (strictly) better
     for i=1:N
        if rand<Pevo
             my_connections=Adj(i,:);%  i connections
             my_connections(i)=1; % i also take in consideration itself.
             Mpayoff=payoff_avg.*my_connections';
             largerpayoffs=find(Mpayoff>payoff_avg(i)); % select those who have larger payoffs than myself
             if (largerpayoffs)>0
                 transformed_into=largerpayoffs(ceil(rand*length(largerpayoffs))); %choose one of them
                 Vct_types(i)=Vct_typesOld(transformed_into); % i transform itself in that agent
             end
        end
     end
end


