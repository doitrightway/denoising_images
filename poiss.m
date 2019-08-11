A=imread('/home/ankit/winter_project/p1.jpg');
I=[1000,10000];
A=double(A);
B=zeros(32*3,32*10);
C=zeros(32*3,32*10);
G=norm(A,1);
for i=1:3
  for j=1:10
    K=poissrnd(A*I(1)/G);
    P=poissrnd(A*I(2)/G);
    B(32*(i-1)+1:32*i,32*(j-1)+1:32*j)=K;
    C(32*(i-1)+1:32*i,32*(j-1)+1:32*j)=P;
  end
end

save("-ascii",'original1','B');
save("-ascii",'original2','C');
%save('saveB.mat','B');
%save('saveC.mat','C');

for i=1:3
  for j=1:10
    K=B(32*(i-1)+1:32*i,32*(j-1)+1:32*j);
    M=max(max(B(32*(i-1)+1:32*i,32*(j-1)+1:32*j)));
    L=C(32*(i-1)+1:32*i,32*(j-1)+1:32*j);
    N=max(max(C(32*(i-1)+1:32*i,32*(j-1)+1:32*j)));
    B(32*(i-1)+1:32*i,32*(j-1)+1:32*j)=K/M;
    C(32*(i-1)+1:32*i,32*(j-1)+1:32*j)=L/N;
  end
end



figure;
imshow(B);
figure;
imshow(C);

