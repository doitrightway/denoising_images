B=imread('icon.png');
A= rgb2gray(B);
k=size(A);
C=poissrnd(A);
C=double(C);
%C=A(1:8,1:8);
%C=double(C);
U=kron(dctmtx(8)',dctmtx(8)');
%y=reshape(C,[],1);
%theta=U'*y;
% theta=zeros(64,1);
% [q w]=barrier(y,L,theta);
%alpha=1;
%thetafin=theta;
%J=zeros(200,1);
%count=1;
epsilon=12;
finalmatrix=zeros(k(1),k(2));
matrixcount=zeros(k(1),k(2));
adder=ones(8,8);
%final_output=zeros(64,6);
%final_output_plot=zeros(200,6);
%final_count=zeros(1,6);
%check=1;
%mu=100;
%for i=1:200
%    [q, ge]=barrierlog(y,U,thetafin,epsilon,mu);
%    printf("%f",q);
%%    oldval=q+norm(thetafin,1);
%    thetaold=thetafin;
%    thetafin=thetafin-alpha*ge';
%    p=barrierlog(y,U,thetafin,epsilon,mu);
%        printf("%f",p);
%
%    if (p>=q)
%        thetafin=thetaold;
%        alpha=alpha/10;
%    else
%        J(count)=newval;
%        count=count+1;
%    end
%end
mu=100;
%for mu=[100,10,1,0.1]
lambda=1/mu;
for i=1:k(1)-7
  for j=1:k(2)-7
    y=reshape(C(i:i+7,j:j+7),[],1);
    theta=U'*y;
    thetafin=theta;
    alpha=10;
    J=zeros(200,1);
    count=1;
    for t=1:200
        [q, ge]=barrierlog(y,U,thetafin,epsilon,mu);
        oldval=q+norm(thetafin,1);
        thetaold=thetafin;
        thetafin=thetafin-alpha*ge';
    %    p=barrierlog(y,U,thetafin,epsilon,mu);
    %    if (p>=q)
    %        thetafin=thetaold;
    %        alpha=alpha/2;
    %    else
            si=find(abs(thetafin)<lambda);
            thetafin(thetafin>0)=thetafin(thetafin>0)-lambda;
            thetafin(thetafin<0)=thetafin(thetafin<0)+lambda;
            thetafin(si)=0;
            x=U*thetafin;
            pos=find(x<0);
            x(pos)=0;
            thetafin=U'*x;
            g=barrierlog(y,U,thetafin,epsilon,mu);
            newval=g+norm(thetafin,1);
            if(newval>=oldval)
                thetafin=thetaold;
                alpha=alpha/2;
            else
                J(count)=newval;
                count=count+1;
            end
    %    end
    end
    finalmatrix(i:i+7,j:j+7)=finalmatrix(i:i+7,j:j+7)+reshape(U*thetafin,8,8);
    matrixcount(i:i+7,j:j+7)=matrixcount(i:i+7,j:j+7)+adder;
%final_output(:,check)=thetafin;
%final_output_plot(:,check)=J;
%final_count(check)=count;
%alpha=1;
%thetafin=theta;
%J=zeros(200,1);
%count=1;
%check=check+1;
  end
end
imagematrix=uint8(finalmatrix./matrixcount);
