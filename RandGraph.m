function [Adj,numb_of_links]=RandGraph(N,P_Link)
% function Adj=RandGraph(N,P_Link)
%
% This file creates a Random undirected Graph with N vertices and
% P_Link probability of each link to exist.
%
% Simone Righi (inspired by  Timoteo Carletti)
%
% input : N number of nodes
%         L number of links
%
% output : Adj Adjacency matrix
%          numb_of_links: total number of links
%
Adj=zeros(N,N); %create the empty adjacency matrix

numb_of_links=0;
for i=1:N
    for j=1:N
        if (j>i) % since the network is symmetrical, i only fill half adj matrix
            if (rand<=P_Link)  %*0.5 note: for some reason i need to divide by two to obtain nodes with on average N*P_link connections
                numb_of_links=numb_of_links+2;
                Adj(i,j)=1;
                Adj(j,i)=1;
            end
        end
    end
end
    
    
    
% to show graphs
% for i=1:N
%     a=Adj(i).links;
%     b(i)=length(a);
% end
% hist(b,20)
    

