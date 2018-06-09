function [Vct_types] = Create_Vct_types(NAg,Prop_UD, Prop_TFT,Prop_conrec,Prop_unconrec,Prop_UC,Prop_SJ)
% Create and shuffle a vector with the proportion of agent's types
% specified in input. 
% 
% Inputs: NAg: Number of agents to create
%         Prop_UD: Proportion of Unconditional defectors in the population
%         (1)
%         Prop_CD: Proportion of Conditional defectors in the population
%         (2)
%         Prop_conrec: Proportion of Indirect reciprocal agents that
%         condition their behaviour on the action of agents connected with
%         them (3)
%         Prop_unconrec: Proportion of Indirect reciprocal agents that
%         condition their behaviour to the actions of agents connected with alter (4)
%         Prop_UC: Proportion of Conditional Cooperators in the population
%         (5)
%         Prop_SJ: Proportion of Stern Judging in the population
%         (6)
%
% Output: Vct_types: Vector (NAg x 1) where with the specified proportions
% of agents
%
% Created by Simone Righi 10/01/2013 
% 

% Calculate the number of each type of agent (corresponding to the
% proportions
if Prop_UD>1 || Prop_TFT>1 || Prop_conrec>1 || Prop_unconrec>1 || Prop_UC>1 || Prop_SJ>1 % i'm using absolute numbers
    NumUD=Prop_UD; %1
    NumCond=Prop_TFT; %2
    NumRecConn=Prop_conrec; %3
    NumRecUnConn=Prop_unconrec; %4
    NumUC=Prop_UC; %5
    NumSJ=Prop_SJ; %6
else % i'm using proportions
    NumUD=round(Prop_UD*NAg); %1
    NumCond=round(Prop_TFT*NAg); %2
    NumRecConn=round(Prop_conrec*NAg); %3
    NumRecUnConn=round(Prop_unconrec*NAg); %4
    if Prop_SJ==-1 % this indicates that we are excluding ex-ante the SJ (baseline model)
        NumUC=round(Prop_UC*NAg); %5
    else
        NumUC=round(Prop_UC*NAg);%5
        NumSJ=round(Prop_SJ*NAg);%6
    end
end

    


% Create a vector of types
Vct_types= zeros(NumUD+NumCond+NumRecConn+NumRecUnConn+NumUC+NumSJ,1);

Vct_types(1:NumUD)=1;
Vct_types(NumUD+1:NumUD+NumCond)=2;
Vct_types(NumUD+NumCond+1:NumUD+NumCond+NumRecConn)=3;
Vct_types(NumUD+NumCond+NumRecConn+1:NumUD+NumCond+NumRecConn+NumRecUnConn)=4;
if Prop_SJ==-1 % this indicates that we are excluding ex-ante the SJ (baseline model)
    if NumUC>0
        Vct_types(NumUD+NumCond+NumRecConn+NumRecUnConn+1:NumUD+NumCond+NumRecConn+NumRecUnConn+NumUC)=5;
    end
else
    Vct_types(NumUD+NumCond+NumRecConn+NumRecUnConn+1:NumUD+NumCond+NumRecConn+NumRecUnConn+NumUC)=5;
    if NumSJ>0
        Vct_types(NumUD+NumCond+NumRecConn+NumRecUnConn+NumUC+1:NumUD+NumCond+NumRecConn+NumRecUnConn+NumUC+NumSJ)=6;
    end
end
while length(Vct_types)<NAg % if there are still empty space, randomize among the available strategies (proportionally to the one present).
    Vct_types(length(Vct_types)+1)=Vct_types(ceil(rand*length(Vct_types)));
end

while length(Vct_types)>NAg % if there are too many agents eliminate one
    Vct_types(ceil(rand*length(Vct_types)))=[];
end
% shuffle the vector
order=randperm(NAg);
Vct_types=Vct_types(order);




