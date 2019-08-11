function [obj_fun_val] = cal_obj_fun_val(Y, X, beta, N, lambda)

obj_fun_val = (norm(Y-sqrt((X'*beta)+3/8),2)^2)/(2*N) + lambda*norm(beta,1);

end