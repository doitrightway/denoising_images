function [beta_hat] = PGA_L1(Y, X, lambda, n, c, D)

% Input Parameters
% lambda: Regularization parameter
% n: Update factor (>1)
% c: (>0)
% alpha_min, alpha_max: 0 < alpha_min < 1 < alpha_max
% M: integer > 0

% Y: Observation vector (Nx1)
% X: Sensing matrix (d x N)

% Output = beta_hat (dx1)


% Initialization

rng(0);
X = (X'*D)';

[d, N] = size(X);
Y = sqrt(Y+3/8);

tol = 1e-6;                     % Tolerance (to exit outermost loop)

t = 0;                          % iteration counter
beta_curr = rand([d,1]);       % Initial estimate for beta(t)

beta_prev = zeros([d,1]);       % beta(t-1)
beta_next = zeros([d,1]);       % beta(t+1)

flag_out = true;
while(flag_out)
    
    % Choose step-size
    
    if (t==0)
        alpha = 1;
    else
        alpha = choose_alpha(Y, X, beta_curr, beta_prev, N);
        %alpha = 1;
    end
    
    % Update steps
    
    flag_in = true;
    while(flag_in)
        
        u = beta_curr - (1/alpha)*cal_gradient(Y, X, beta_curr, N);
        beta_next = wthresh(u,'s', lambda/alpha);
        sig = D*beta_next;
        sig(sig<0)=0;
        beta_next = D'*sig;
        alpha = alpha*n;
        
        if (norm(beta_curr-u,2)/norm(beta_curr,2)<tol)
            break;
        end
        
        flag_in = check_condn_inner_loop(Y, X, beta_next, beta_curr, beta_prev, N, lambda, c, alpha);
    
    end
    
    t = t+1;
    beta_prev = beta_curr;
    beta_curr = beta_next;
    flag_out = (norm(beta_curr-beta_prev,2)/norm(beta_curr,2)>tol);
    
end

beta_hat = beta_curr;    

end

