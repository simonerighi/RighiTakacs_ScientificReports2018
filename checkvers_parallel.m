% checks which version of matlab is running and uses the correct
% parallelization command.

if position=='open'
    if version('-date')<datetime(2014,1,1,6:7,0,0)
        matlabpool open;
    else
        p=parpool;
    end
else

    if version('-date')<datetime(2014,1,1,6:7,0,0)
        matlabpool close;
    else
        delete(p);
    end
end

