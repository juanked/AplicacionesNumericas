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


dif_XYZ = zeros(3,N);

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
end
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