function create_partition(Vct_types,filename)
% create a partition file (pajek format) for the agents' type in the network

n = size(Vct_types,1); % number of nodes 
fid = fopen(filename,'wt','native');
fprintf(fid,'*Vertices  %6i\n',n);

for i=1:n
    sting_to_print=Vct_types(i);
    fprintf(fid,'%1i\n',sting_to_print);
end

fclose(fid);

