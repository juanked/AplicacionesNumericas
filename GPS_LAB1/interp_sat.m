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


sp2=read_sp3(sp);
h=sp2.delta;
sp2.tow(1);
% primero=sp2.tow(1);
% seg=9*3600+20*60;
t=tow;
x=(t-sp2.tow(1))/h;
prev=floor(x)+1;
rg=(prev-N/2+1:prev+N/2);
dif_XYZ = zeros(3,N);

    for j=1:3
        ck=sp2.XYZ(j,rg,PRN); %Para obtener cada coordenada
        dif_XYZ(j,:)=get_df(ck);
    end

s=(N/2-1)+mod(t,h)/h;
S=get_S(s,N);
XYZ=dif_XYZ*S;
cdt=sp2.cdT(PRN,rg);
cdT=cdt*S;
%fprintf('XYZ= [%.2f %.2f %.2f]',XYZ);

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

return

function S = get_S(s,N)
% Recibe s y devuelve vector de coefs S para usar en interpolación
    dS=zeros(N,1);
    dS(1,1)=1;
    for i=1:N-1
        dS(i+1,1) = dS(i,1)*((s-i+1)/i);
    end
S=dS;
return
