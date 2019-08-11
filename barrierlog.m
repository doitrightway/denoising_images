function [val, gradient]=barrierlog(y,U,theta,epsilon,mu)
kal=norm((sqrt(y+3/8)-sqrt(U*theta+3/8)),2).^2;
val= -1*mu*log(epsilon^2-kal);
gradient=-1*mu*(1/(epsilon^2-kal))*((sqrt(y+3/8)-sqrt(U*theta+3/8))./sqrt(U*theta+3/8))'*U;
