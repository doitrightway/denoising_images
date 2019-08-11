function [ th ] = minEstimate(x, lambda, U)
    cvx_begin quiet
    cvx_solver ecos
        variables theta(64);
        minimise (sum(U * theta) - x' * log(U * theta) + lambda * norm(theta, 1))
        subject to
            U * theta >= 0
    cvx_end
    th = theta;    
end
