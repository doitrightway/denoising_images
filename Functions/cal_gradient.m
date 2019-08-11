function [gradient] = cal_gradient(Y, X, beta, N)

coeff = (Y-sqrt((X'*beta)+3/8)).*(1./(2*sqrt((X'*beta)+3/8)));
gradient = (X*coeff)/(-N);

end