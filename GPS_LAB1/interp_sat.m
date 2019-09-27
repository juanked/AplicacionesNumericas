function [XYZ, cdT, Vxyz, D] = interp_sat(sp, tow, PRN, N)
    %  XYZ :  vector 3 x 1 con la posición XYZ (m) en tiempo t  
    %   cdT:  error de reloj del sat (m) en el tiempo t.
    % Vxyz :  vector 3 x 1 con la velocidad (Vx,Vy,Vz) del sat (m/s) 
    %    D :  deriva del reloj (m/s) en tiempo t.

    h = sp.delta;
    sp.tow(1);
    PRN = find(PRN == sp.prn);
    t = tow;
    x = (t - sp.tow(1)) / h;
    prev = floor(x) + 1;
    rg = (prev - N / 2 + 1:prev + N / 2);
    dif_XYZ = zeros(3, N);

    for j = 1:3
        ck = sp.XYZ(j, rg, PRN); %Para obtener cada coordenada
        dif_XYZ(j, :) = get_df(ck);
    end

    s = (N / 2 - 1) + mod(t, h) / h;
    S = get_S(s, N);
    dS=get_S(s,N);
    cdt = sp.cdT(PRN, rg);
    
    
    XYZ = dif_XYZ * S;
    cdT = get_df(cdt) * S;
    Vxyz= (dif_XYZ*dS)/h;
    D=(get_df(cdt)*dS)/h;


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



function [S, dS] = get_S(s, N)
    % Recibe s y devuelve vector de coefs S para usar en interpolación
    S = zeros(N, 1);
    dS=zeros(N,1);
    S(1, 1) = 1;
    dS(1,1)=0;

    for i = 1:N - 1
        S(i + 1, 1) = S(i, 1) * ((s - i + 1) / i);
    end

    for k=1:N-1
        dS(k+1, 1)=(S(k,1)+(s-k+1)*dS(k,1))/k;
    end    

    return
