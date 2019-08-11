function array = myfun(A,U,lambda)
C=reshape(A,[],1)
cvx_begin
    cvx_solver ecos
    variable m(64)
    minimize(sum(m)+lambda*sum(abs(U*m))-sum(C.*log(m)))
    subject to
        m>0
cvx_end
array=reshape(m,8,8);