function [val,newtheta]=unconstrain(y,U,theta)
val=(norm(sqrt(y+3/8)-sqrt(U*theta+3/8),2)).^2;
newtheta= -1*((sqrt(y+3/8)-sqrt(U*theta+3/8))./sqrt(U*theta+3/8))'*U;