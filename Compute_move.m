function [move,Adj_LM] = Compute_move(Adj,me,other, Pfor,efficiencyTFT,Vct_types,Adj_LM,Adj_LMold,TFTtype)
% Compute Move of the agent (Defect or cooperate) depending on the type of
% the agent and on the one of the partner.
%
% Input: 
%   Adj: Adjacency matrix of the agents. 
%   me: the number of the individual for which i want to compute the move.
%   other: the number of the agent "me" is playing with
%   Pfor: probability of forgiving a defecting agents (only works for
%   Indirect reciprocal agents)
%   EfficiencyTFT: probability with which TFT remembers past action of the
%   interacting partner (1= perfect memory, 0= always baseline behaviour).
%   Vct_types: vector containing the type of each agent
%   Adj_LM= Adjacency matrix containing past action of each agent with each
%   other agent (-1: defect, 0 no interaction, 1 cooperate).
%   Adj_LMold: Adjacency matrix containing past action (at previous step),
%   update is syncronous
%   TFT type: starts off by cooperating (nice) or by defecting (evil).

% 
% Output: 
%   move: move made by the agent, is a char: either 1='C' or -1='D'
%   Adj_LM= Adjacency matrix containing past action of each agent with each
%   other agent (-1: defect, 0 no interaction, 1 cooperate).
%


switch Vct_types(me)
    case 1 % if unconditional defector
        move=-1;
         % 'D';
    case 2 % if TFT
        if rand<efficiencyTFT % if the agent remember this individual partner
            if Adj_LMold(other,me)==1 % if the link is positive
                move=1; %'C'
            else
                if TFTtype=='n' && Adj_LMold(other,me)==0 %nice TFT starts by cooperating
                    move=1;
                else
                    move=-1; % 'D'
                end
            end
        else
            move=-1; % 'D' 
            % but it could be random: if rand<0.5; move=-1; else; move=1; end;
        end
    case 3 % if undirected reciprocal (connected)
            
            Vcommon_friends=(Adj(me,:)+Adj(other,:))==2; %list of common friends
            Vcommon_friends(me)=0; % list of common friends - ego
            Vcommon_friends(other)=0; % list of common friends - ego - alter
            common_friends=find(Vcommon_friends==1);
            if ~isempty(common_friends)
                 select_rand_friend=ceil(rand*length(common_friends)); % select a random common friend 
                 Last_performed_action=Adj_LMold(other,common_friends(select_rand_friend));
                 % if strategy played with commonfriends ==C then C else ==D
                 switch Last_performed_action
                     case 1 % If the Other played C against select_rand_friend in the previous step --> cooperate
                         move=1;
                     case -1 % If the Other played D against select_rand_friend in the previous step --> defect
                         move=-1; % set the move to defection, in case no forgiveness is granted this time
                         % possibly give the partner another opportunity
                         if length(common_friends)-1>0 && (rand<Pfor)
                            common_friends(select_rand_friend)=[]; % eliminate the guy already choosen from the list of friends
                            select_rand_friend=ceil(rand*length(common_friends)); % select a random common friend 
                            Last_performed_action=Adj_LMold(other,common_friends(select_rand_friend));
                            switch Last_performed_action
                                case 1 % If the Other played C against select_rand_friend in the previous step --> cooperate
                                    move=1;
                                case -1 % If the Other played D against select_rand_friend in the previous step --> defect
                                    move=-1;
                                case 0
                                if rand>0.5 % If the Other player did not play against select_rand_friend in the previous step --> play randomly
                                    move=-1;
                                else
                                    move=1;
                                end
                            end
                        end
                     case 0
                        if rand>0.5 % If the Other player did not play against select_rand_friend in the previous step --> play randomly
                            move=-1;
                        else
                            move=1;
                        end
                 end
            else % if they have no common friends (it plays randomly)
               if rand>0.5  %play randomly
                    move=-1;
               else
                    move=1;
               end
            end
    case 4 % if undirected reciprocal (unconnected)
        VAdj_other=Adj(other,:); % list of connections of other
        VAdj_other(me)=0; % list of other friends - ego
        Adj_other=find(VAdj_other==1);
        if ~isempty(Adj_other)
             select_rand_friend=ceil(rand*length(Adj_other)); % select a random common friend 
             Last_performed_action=Adj_LMold(other,Adj_other(select_rand_friend));
             % if strategy played with commonfriends ==C then C else ==D
             switch Last_performed_action
                 case 1 % If the Other played C against select_rand_friend in the previous step --> cooperate
                     move=1;
                 case -1 % If the Other played D against select_rand_friend in the previous step --> defect
                     move=-1; % set move to -1 before possibly giving another opportunity
                     if length(Adj_other)-1>0 && (rand<Pfor)
                        Adj_other(select_rand_friend)=[]; % eliminate the guy already choosen from the list of friends
                        select_rand_friend=ceil(rand*length(Adj_other)); % select a random common friend 
                        Last_performed_action=Adj_LMold(other,Adj_other(select_rand_friend));
                        switch Last_performed_action % if strategy played with commonfriends ==C then C else ==D
                         case 1 % If the Other played C against select_rand_friend in the previous step --> cooperate
                             move=1;
                         case -1 % If the Other played D against select_rand_friend in the previous step --> defect
                             move=-1;
                         case 0 
                            if rand>0.5 % If the Other player did not play against select_rand_friend in the previous step --> play randomly
                                move=-1; %D
                            else
                                move=1; % C 
                            end
                        end
                    end
                 case 0 
                    if rand>0.5 % If the Other player did not play against select_rand_friend in the previous step --> play randomly
                        move=-1; %D
                    else
                        move=1; % C 
                    end
             end
        else % if the other does not have friends I play randomly
             if rand>0.5 
             	move=-1; %D
             else
                move=1; % C 
             end
        end
    case 5 % if unconditional cooperator
        move=1;
    case 6 % stern Judging
        Vcommon_friends=(Adj(me,:)+Adj(other,:))==2; %list of common friends
        Vcommon_friends(me)=0; % list of common friends - ego
        Vcommon_friends(other)=0; % list of common friends - ego - alter
        common_friends=find(Vcommon_friends==1);
        if ~isempty(common_friends)
            select_rand_friend=ceil(rand*length(common_friends)); % select a random common friend 
            LPA_OtherCommon=Adj_LMold(other,common_friends(select_rand_friend)); % Action of Other with common friend
            %LPA_CommonAlter=Adj_LMold(common_friends(select_rand_friend),other); % Action of common friend with Other
            LPA_CommonEgo=Adj_LMold(common_friends(select_rand_friend),me); % Action of common friend with me
            if LPA_OtherCommon==1 % if j cooperated with z
                if LPA_CommonEgo==1 %and z cooperated with i
                    move=1;
                else
                    move=-1; %and z defected with i
                end
            elseif LPA_OtherCommon==-1
                if LPA_CommonEgo==1 %and z cooperated with i
                    move=-1;
                else
                    move=1; %and z defected with i
                end
            else % if no move yet (act randomly)
                if rand>0.5 % If the Other player did not play against select_rand_friend in the previous step --> play randomly
                    move=-1; %D
                else
                    move=1; % C
                end
            end
        else
            if rand>0.5
                move=-1;
            else
                move=1;
            end
        end
end
Adj_LM(me,other)=move;

%NumUD %1
%NumCond %2
%NumRecConn %3
%NumRecUnConn %4
%NumUC %5
%Stern %6

