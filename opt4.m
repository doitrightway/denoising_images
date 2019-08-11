% B=imread('icon.png');
% A= rgb2gray(B);
U=kron(dctmtx(8),dctmtx(8));
L=kron(dctmtx(8)',dctmtx(8)');
% example = load('saveB.mat','-ascii');
% B = example.B;
% example = load('saveC.mat','-ascii');
% C = example.C;
B=load('original1','-ascii');
C=load('original2','-ascii');
lambda=-5:2;
k=[32,32];
count1=zeros(k(1),k(2));
mymatrix1=zeros(k(1),k(2));
mymatrix2=zeros(k(1),k(2));
adder=ones(8,8);

finalmse1=zeros(1,30);
finalmse2=zeros(1,30);
finalB=zeros(32*3,32*10);
finalC=zeros(32*3,32*10);
mse1=zeros(1,8);
mse2=zeros(1,8);
minmse1=100000000;
minmse2=100000000;
for q=1:3
  for w=1:10
    A=B(32*(q-1)+1:32*q,32*(w-1)+1:32*w);
    Z=C(32*(q-1)+1:32*q,32*(w-1)+1:32*w);
    for l = lambda
        for i=1:k(1)-7
            for j=1:k(2)-7
                mymatrix1(i:i+7,j:j+7)=mymatrix1(i:i+7,j:j+7) + myfun(A(i:i+7,j:j+7),U,10^l);
                mymatrix2(i:i+7,j:j+7)=mymatrix2(i:i+7,j:j+7) + myfun(Z(i:i+7,j:j+7),U,10^l);
                count1(i:i+7,j:j+7)= count1(i:i+7,j:j+7)+adder;
            end
        end
        mymatrix1=mymatrix1./count1;
        mymatrix2=mymatrix2./count1;
        mse1(l+6)=calcmse(mymatrix1,A);
        mse2(l+6)=calcmse(mymatrix2,Z);
        if(mse1(l+6)<minmse1)
            minmse1=mse1(l+6);
            final_matrix1=mymatrix1;
        end
        if(mse2(l+6)<minmse2)
            minmse2=mse2(l+6);
            final_matrix2=mymatrix2;
        end
        count1=zeros(k(1),k(2));
        mymatrix1=zeros(k(1),k(2));
        mymatrix2=zeros(k(1),k(2));
    end
    finalmse1(w*(q-1)+w)=minmse1;
    finalmse2(w*(q-1)+w)=minmse2;
    finalB(32*(q-1)+1:32*q,32*(w-1)+1:32*w)=final_matrix1;
    finalC(32*(q-1)+1:32*q,32*(w-1)+1:32*w)=final_matrix2;
    mse1=zeros(1,8);
    mse2=zeros(1,8);
    minmse1=100000000;
    minmse2=100000000;
  end
end
% mymatrix=mymatrix./count;
% imshow(uint8(mymatrix));