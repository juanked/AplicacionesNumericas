function X = get_pos(sp, Tr, sats, obs, X, N)

    if nargin < 6, N = 8; end% Si no se especifica, usamos N = 8 nodos


    if nargin < 5, X = [0; 0; 0; 0]; end% Por defecto X=[0; 0; 0; 0];
    c = 2.99792458e8;
    deltaX=zeros(4,1);
    pos=zeros(3,1);
    i=1;
    while (i<length(sats)+1)
        sats(i) = find(sats(i) == sp.prn);
        i=i+1;
    end
%     if (length(Tr)==1)
%         Tr2=zeros(1,length(sats));
%         i=1;
%         while (i<length(sats)+1)
%             Tr2(i)=Tr;
%             
%             i=i+1;
%         end
%     end     
    while (1)
        
        pos = X(1:3,1)
        cdt = X(4,1)
        Tr
        Tr_gps = Tr - cdt
        Tx_gps = Tr_gps - 0.070
        [XYZ, cdT] = get_data_sats(sp, Tx_gps, sats, N);

        [H, R] = get_HR(XYZ, pos);
        pred = R + cdt - cdT;
        difRho = pred - obs; %o al revés, ni zorra
        deltaX = H\difRho %vector 4x1
        X = X + deltaX
        i=i+1;
        if (norm(deltaX)<0.01)
            break;
        end
    end
return

