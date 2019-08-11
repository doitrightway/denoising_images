B=imread('icon.png');
A= rgb2gray(B);
C=A(1:8,1:8);
C=double(C);
U=kron(dctmtx(8),dctmtx(8));
L=kron(dctmtx(8)',dctmtx(8)');
y=reshape(C,[],1);
theta=pinv(L)*(y-2);
% [q w]=barrier(y,L,theta);
alpha=1;
thetafin=theta;
J=zeros(200,1);
count=1;
lambda=5;
epsilon=4;
% final_output=zeros(64,5);
% final_output_plot=zeros(200,5);
% final_count=zeros(1,5);
% check=1;
mu=10;
for i=1:400
    [q, ge]=barrierlog(y,L,thetafin,epsilon,mu);
%     oldval=q+lambda*norm(thetafin,1);
    thetaold=thetafin;
    thetafin=thetafin-alpha*ge';
    p=barrierlog(y,L,thetafin,epsilon,mu);
    if (p>=q)
        thetafin=thetaold;
        alpha=alpha/2;
    else
        J(count)=newval;
        count=count+1;
    end
end