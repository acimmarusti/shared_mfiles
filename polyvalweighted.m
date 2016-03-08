% Evaluates a weighted polynomial fit up to order 9
% Output: y values with their uncertainties
% Inputs: parameters and uncertainties resulting from polyfitweighted
% Range: start_pos - end_pos (integers)
% Syntax is:
% polyvalweighted(param, param_err, start_pos, end_pos)
function [yvalue, y_err] = polyvalweighted(param, param_err, xdata)

%Number of parameters (order of polynomial + 1)
num_param = size(param, 1);

datapoints = size(xdata, 1);

y_err2 = zeros(1, datapoints - 1);

%Propagation of error from parameters into y-values of the fit
for iter = 1 : num_param
    
    for propa_err = 1 : datapoints - 1
    
        y_err2(1, propa_err) = y_err2(1, propa_err) + (param_err(iter) * propa_err^(num_param - iter))^2;
        
    end
    
end

%Evaluation of the y-values and errors
yvalue = polyval(param, xdata);
    
y_err = sqrt(y_err2);

end