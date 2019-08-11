function k=calcmse(X,Y)
G=X-Y;
G=G.^2;
g=sum(sum(G));
k=g/sum(sum(Y.^2));