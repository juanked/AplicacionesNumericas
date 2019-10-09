function X = get_pos(sp, Tr, sats, obs, X, N)

    if nargin < 6, N = 8; end% Si no se especifica, usamos N = 8 nodos

        if nargin < 5, X = [0; 0; 0; 0]; end% Por defecto X=[0; 0; 0; 0];
            c = 2.99792458e8;
            deltaX=1;

            while (norm(deltaX > 0.01))
                pos = X(1:3);
                cdt = X(4);
                Tr_gps = Tr - cdt;
                Tx_gps = Tr_gps - 0.070;
                [XYZ, cdT] = get_data_sats(sp, Tx_gps, sats, N);
                [H, R] = get_HR(XYZ, pos);
                pred = R + cdt - cdT;
                difRho = obs - pre; %o al revés, ni zorra
                deltaX = difRho / H; %vector 4x1
                X = X + deltaX;
            end

            return
