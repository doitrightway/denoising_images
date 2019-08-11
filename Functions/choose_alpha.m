function [alpha] = choose_alpha(Y, X, beta_curr, beta_prev, N)

del = beta_curr-beta_prev;
g = cal_gradient(Y, X, beta_curr, N)-cal_gradient(Y, X, beta_prev, N);

alpha = (del'*g)/(del'*del);


end