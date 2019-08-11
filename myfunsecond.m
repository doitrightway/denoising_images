function second=myfunsecond(A,L)
C=reshape(A,[],1);
cvx_begin
    variables m(64);
    minimize(norm(m,1))
    subject to
       sum(C+3/8)+sum(L*m+3/8)-2*sum(sqrt((C+3/8).*(L*m+3/8)))<=50;
       L*m>=0;
cvx_end
second=reshape(L*m,8,8);