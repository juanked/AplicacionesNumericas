% David Cristóbal Pascual
% Alberto Doncel Aparicio


function X = get_pos(sp, Tr, sats, obs, X, N)

    if nargin < 6, N = 8; end% Si no se especifica, usamos N = 8 nodos

        if nargin < 5, X = [0; 0; 0; 0]; end% Por defecto X=[0; 0; 0; 0];
            c = 2.99792458e8;
            deltaX = zeros(4, 1);
            pos = zeros(3, 1);
            i = 1;

            while (1)
                
                pos = X(1:3, 1);
                cdt = X(4, 1);
                Tr_gps = Tr - cdt / c;
                Tx_gps = Tr_gps - 0.070;
                [XYZ, cdT] = get_data_sats(sp, Tx_gps, sats, N);
                [H, R] = get_HR(XYZ, pos);
                pred = R + cdt - cdT;
                difRho = obs - pred;
                deltaX = H \ difRho; %vector 4x1
                X = X + deltaX;
                if (norm(deltaX) < 0.01)
                    break;
                end

            end
return

function [XYZ_sat, cdT]=get_data_sats(sp,t,prn,N)
if nargin==3, N=8; end  % Si no se especifica, usamos N = 8 nodos
 nsat = length(prn); XYZ_sat=zeros(3,nsat); cdT=zeros(nsat,1);  
 % Si t = �nico, crea vector de t's iguales 
 if length(t)==1, t=t*ones(1,nsat); end  
 for i=1:nsat
     [XYZ, cdTa]=interp_sat(sp,t(i),prn(i),N);
     XYZ_sat(:,i)=XYZ;
     cdT(i,1)=cdTa;
 end
 %find(PRN == sp.prn)
 
return

function [H,R]=get_HR(XYZ,pos)
nsat = size(XYZ,2);
H=zeros(nsat,4);
R=zeros(nsat,1);
for i=1:nsat
   R(i,1)=sqrt(((XYZ(1,i)-pos(1))^2)+((XYZ(2,i)-pos(2))^2)+((XYZ(3,i)-pos(3))^2));
   H(i,1)=(-(XYZ(1,i)-pos(1)))/(R(i,1));
   H(i,2)=(-(XYZ(2,i)-pos(2)))/(R(i,1));
   H(i,3)=(-(XYZ(3,i)-pos(3)))/(R(i,1));%H(i,3)=(-(XYZ(3,1)-pos(3)))/(R(i,1));
   H(i,4)=1;
end

return