clear;
clc;

B=imread('icon.png');
A= rgb2gray(B);
k=size(A);
C=poissrnd(A);
C=double(C);
%C=A(1:8,1:8);
%C=double(C);
U=kron(dctmtx(8)',dctmtx(8)');
%y=reshape(C,[],1);
%theta=zeros(64,1);
%orig=y;
%y=poissrnd(y);
% [q w]=unconstrain(y,L,theta);
%alpha=10;
%thetafin=theta;
%J=zeros(400,1);
finalmatrix=zeros(k(1),k(2));
matrixcount=zeros(k(1),k(2));
adder=ones(8,8);
%check=1
%count=1;
lambda=0.1;
for i=1:k(1)-7
  for j=1:k(2)-7
    y=reshape(C(i:i+7,j:j+7),[],1);
    theta=U'*y;
    thetafin=theta;
    alpha=1.0000;
    J=zeros(400,1);
    count=1;
%    disp(check);
    for t=1:400
        [q, ge]=unconstrain(y,U,thetafin);
        oldval=q+lambda*norm(thetafin,1);
        thetaold=thetafin;
        thetafin=thetafin-alpha*ge';
%        p=unconstrain(y,U,thetafin);
%        if (p>=q)
%            thetafin=thetaold;
%            alpha=alpha/2;
%        else
          
          si=find(abs(thetafin)<lambda);
          thetafin(thetafin>0)=thetafin(thetafin>0)-lambda;
          thetafin(thetafin<0)=thetafin(thetafin<0)+lambda;
          thetafin(si)=0;
          x=U*thetafin;
          pos=find(x<0);
          x(pos)=0;
          thetafin=U'*x;
          [g,ge]=unconstrain(y,U,thetafin);
          newval=g+lambda*norm(thetafin,1);
          if(newval>=oldval)
            thetafin=thetaold;
            alpha=alpha/2;
          else
            J(count)=newval;
            count=count+1;
          end
%          disp (alpha);
%         end
    end
    finalmatrix(i:i+7,j:j+7)=finalmatrix(i:i+7,j:j+7)+reshape(U*thetafin,8,8);
    matrixcount(i:i+7,j:j+7)=matrixcount(i:i+7,j:j+7)+adder;
%    check=check+1;
  end
end
imagematrix=(finalmatrix./matrixcount);

re_d = sqrt(sum((A(:)-imagematrix(:)).^2)/(sum(A(:).^2)))
re_o = sqrt(sum((A(:)-C(:)).^2)/(sum(A(:).^2)))
    