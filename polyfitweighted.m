% Computes a weighted polynomial fit up to order 9
% Output: fit parameters and their uncertainties
% Syntax is:
% polyfitweighted(data, data_err, datasize)
function [param, param_err] = polyfitweighted(xdata, ydata, ydata_err, order)

error_weights = 1 ./ ydata_err.^2;

poly_type = strcat('poly', int2str(order));

fitresult = fit(xdata, ydata, poly_type, 'Weight', error_weights);

fit_param = order + 1;

%Change confidence level to 67% (default is 95%)  
param_unc = confint(fitresult, 0.67);

%Extract the parameter information from the fit object
param = zeros(1, fit_param);

param_err = zeros(1, fit_param);

for num_param = 1 : fit_param
    
    param(1, num_param) = eval(['fitresult.p', int2str(num_param), ';']);
    
    param_err(1, num_param) = abs(param(1, num_param) - param_unc(1, num_param));
    
end

end