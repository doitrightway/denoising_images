function [flag] = check_condn_inner_loop(Y, X, beta_next, beta_curr, beta_prev, N, lambda, c, alpha)

phi_next = cal_obj_fun_val(Y, X, beta_next, N, lambda);
phi_curr = cal_obj_fun_val(Y, X, beta_curr, N, lambda);
phi_prev = cal_obj_fun_val(Y, X, beta_prev, N, lambda);

diff = c*(alpha/2)*(norm(beta_next-beta_curr,2)^2);
thres = max([phi_curr-diff, phi_prev-diff]);

%flag = (phi_next > thres);
flag = (phi_next > phi_curr);

end