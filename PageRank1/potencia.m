function [autovalor, autovector]=potencia(A,niter)
    N=7;
    x1=ones(N,1);
    for k=1:niter
        x=x1;
        x=x/norm(x);
        x1=A*x;
    end
    lambda=x'*x1;
    autovector=x;
    autovalor=lambda;
return