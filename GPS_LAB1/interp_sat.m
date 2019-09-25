function [XYZ, cdT]=interp_sat(sp,tow,PRN,N)
% CRISTOBAL PASCUAL, DAVID
% DONCEL APARICIO, ALBERTO

% Parametros entrada: sp -> estructura con datos pertinentes.
% tow -> tiempo de la semana en seg
% PRN del sat en el que estamos interesados
% N, número de nodos a usar.
% Parametros SALIDA: XYZ=vector 3x1 con la posición interpolada (en mt)
% cdT = error reloj (en mt) interpolado en tiempo t.

% Siguiendo lo realizado en el ejercicio 2:

h=900;
primero=sp.tow(1);
seg=9*3600+20*60;
t=primero+seg;
prev=floor(x)+1;
rg=(prev-(N/2)+1:prev+N/2);

dif_XYZ = zeros(3,N);

for i=1:N
    for e=1:3
        ck=sp.XYZ(e,rg,25); %Para obtener cada coordenada
        dif_XYZ(e,i)=get_df(ck);
    end
end

s=(N/2-1)+mod(tow,h)/h;
S=get_S(s,N);


return

function df=get_df(f)
% Función que recibe un vector f y devuelve vector df con
% las correspondientes diferencias finitas
    N=length(f); f=reshape(f,1,N); % asegura que es un vector fila
    NumDF=1;
while length(f)>NumDF
    I=length(f);
    while I>NumDF
        f(I)=f(I)-f(I-1);
        I=I-1;
    end
    NumDF=NumDF+1;
end
df=f;
fprintf('%.3f ',df);
return

function S = get_S(s,N)
% Recibe s y devuelve vector de coefs S para usar en interpolación
    dS=zeros(N,1);
    dS(1,1)=1;
    for i=2:N
        k=i-1;
        dS(i,1) = dS(i-1,1)*((s-k+1)/k);
    end
    fprintf('%.5f ',dS);
return