function [converged,N_types,tconv]=check_convergence(N,N_types,t,converged,tmax,tconv,Vct_types)
%  keeps track of number of agents of each type at this
% time step and verifies that convergence has been reached in the model (if all agents
% are of one type).

repetition=1; % by default we run statistical iteration and we set this to one (it is necessary as for single simulations N_types needs to save all times steps).

types=zeros(N,1); % compute the number of agents of each kind (
if repetition==0
    N_types(1,t)=length(find(Vct_types==1));
    N_types(2,t)=length(find(Vct_types==2));
    N_types(3,t)=length(find(Vct_types==3));
    N_types(4,t)=length(find(Vct_types==4));
    N_types(5,t)=length(find(Vct_types==5));
else
    N_types(1,1)=length(find(Vct_types==1));
    N_types(2,1)=length(find(Vct_types==2));
    N_types(3,1)=length(find(Vct_types==3));
    N_types(4,1)=length(find(Vct_types==4));
    N_types(5,1)=length(find(Vct_types==5));
end

if repetition==0 % if the whole population is made up of one type of agents, stop the simululation
    if (N_types(1,t)==N) || (N_types(2,t)==N) || (N_types(3,t)==N) || (N_types(4,t)==N) || (N_types(5,t)==N)
        if converged==0
            converged=1;
            tconv=t;
        else
            tconv=tconv;
        end
    else
        converged=0;
        tconv=tmax;
    end
else
    if (N_types(1,1)==N) || (N_types(2,1)==N) || (N_types(3,1)==N) || (N_types(4,1)==N) || (N_types(5,1)==N)
        if converged==0
            converged=1;
            tconv=t;
        else
            tconv=tconv;
        end
    else
        converged=0;
        tconv=tmax;
    end 
end