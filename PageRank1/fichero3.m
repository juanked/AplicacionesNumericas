% Cristóbal Pascual, David
% Doncel Aparicio, Alberto

clear all

%Matriz A de conexiones
A=[0 0 0 0 0 0 0;
   0.333 0 0 0.5 0 0 0.5;
   0 0.5 0 0 0 0 0;
   0.333 0 0.5 0 0 0.333 0.5;
   0.333 0 0 0 0 0.333 0;
   0 0 0.5 0 0 0 0;
   0 0.5 0 0.5 0 0.333 0];

N=10;p=5;i=randi(N,1,p*N);j=randi(N,1,p*N);C=sparse(i,j,1,N,N);niter=20;
%N=dimensión, p=#medio links salida, niter=# iteraciones
full(C) % Visualizamos la matriz completa.
Ccompleta=full(C); % Creamos la matriz completa
whos % Vemos el tamaño que ocupan en memoria las matrices C y Ccompleta 
alpha=0.85;
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
bar(x)
precision=max(precision1,precision2);
ordenpagerank=sort(x,'descend');