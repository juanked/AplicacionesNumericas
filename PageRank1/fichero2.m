% Cristóbal Pascual, David
% Doncel Aparicio, Alberto

clear all
i=[5 3 3 7 7 8 11 11 11];
j=[11 10 8 8 11 9 9 10 2];
N=11; % Dimensión de la matriz
alpha=0.85;
C=sparse(j,i,1,N,N);
%C=sparse(1:7,1:7,1,N,N)
 % Crea la matriz dispersa C de tamaño NxN tal que C(j(k),i(k))=1.
 % Los vectores i, j del mismo tamaño contienen los nodos de entrada y de salida
full(C) % Visualizamos la matriz completa.
Ccompleta=full(C); % Creamos la matriz completa
whos % Vemos el tamaño que ocupan en memoria las matrices C y Ccompleta 

Nj=sum(C);
Dj=zeros(1,N);
Dj(find(Nj==0))=1;
S=C;
for k=1:N
    ceros=zeros(N,1);
    if Dj(k)==1
        S(:,k)=ones(N,1)/N;
    else
        S(:,k)=S(:,k)/Nj(k);
    end
end
%G=zeros(size(S));
G=alpha*S+(1-alpha)*ones(N)/N;
[V D]=eig(G);
autovalores=diag(abs(D));
autovectores=sum(abs(V));

[lambda,x]=potencia(G,50);
precision1=norm(G*x-lambda*x);
precision2=abs(lambda-1);
[autovalor,pagerank]=getPageRank(G,50,N);
bar(pagerank)
function [autovalor, autovector]=potencia(A,niter)
    N=11;
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
function [autovalor, pagerank]=getPageRankfu(A,niter,N)
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