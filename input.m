function array=input(A,U)
C=reshape(A,[],1)
cvx_begin
    variable m(64)
    minimize( sum(U*m)+0.5*sum(abs(m))-sum(C.*log(U*m)))
    subject to
        U*m>0
cvx_end
array=reshape(U*m,8,8)