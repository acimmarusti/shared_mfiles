function [avgs, errs] = avg_bystep(data, step)
% [avgs, errs] = avg_bystep(data, step)
% Computes average of data by steps

max_dat = size(data, 1);

maxnum = floor(max_dat / step);

avgs = zeros(maxnum , 1);

stdevs = zeros(maxnum, 1);

nstep = 1;

i = 1;

while (i < max_dat && nstep <= maxnum)
    
    avgs(nstep) = mean(data(i : i + step - 1));
    
    stdevs(nstep) = std(data(i : i + step - 1));
    
    i = i + step;
    
    nstep = nstep + 1;
    
end

errs = stdevs / sqrt(step);

end