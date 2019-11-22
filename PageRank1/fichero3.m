% Cristóbal Pascual, David
% Doncel Aparicio, Alberto

clear all
N=10;p=5;i=randi(N,1,p*N);j=randi(N,1,p*N);C=sparse(i,j,1,N,N);niter=20;
%N=dimensiÃ³n, p=#medio links salida, niter=# iteraciones
alpha=0.85;
Nj=sum(C);
Dj=zeros(1,N);
Dj(find(Nj==0))=1;
S=C;
for k=1:N
 if Dj(k)==1
 S(:,k)=ones(N,1)/N;
 else
 S(:,k)=S(:,k)/Nj(k);
 end
end
G=alpha*S+(1-alpha)*ones(N)/N;
[lambda,x]=potencia(G,50);
precision1=norm(G*x-lambda*x);
precision2=abs(lambda-1);
[lambda,pagerank]=getPageRank(G,50,N);
bar(pagerank);
precision=max(precision1,precision2)
ordenpagerank=sort(pagerank,'descend')
function [autovalor, pagerank]=getPageRank(A,niter,N)
 x1=ones(N,1);
 for k=1:niter
 x=x1;
 x=x/norm(x);
 x1=A*x;
 end
 lambda=x'*x1;
 pagerank=x/sum(x);
 autovalor=lambda;
return
end
function [autovalor, autovector]=potencia(A,niter)
 N=10;
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
end
