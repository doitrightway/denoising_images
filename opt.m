A=imread('nature.jpeg');
B=double(A(1:8,1:8))
C=reshape(B,[],1)
cvx_begin
    variable m(64)
    D=reshape(m,8,8)
    minimize( sum(m)+0.5*sum(abs(reshape(dct2(D),[],1)))-sum(m.*log(C)))
    subject to
        all(m>=0)
cvx_end
        
