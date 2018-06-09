function [Adj_LM] = Initialize_Actions_LA (Adj,N,init_C)
%In the setup for figure S15 we need a given proportion of initial
%collaboration. This versione of Initialize action assigns to any
%interaction among agents a previous behaviour (cooperate/defect) according
%to a probability init_C of cooperating.


Adj_LM=zeros(size(Adj));
for i=1:N
    for j=1:N
        if Adj(i,j)==1
            if rand<=init_C
                Adj_LM(i,j)=1;
            else
                Adj_LM(i,j)=-1;
            end
        end
    end
end







