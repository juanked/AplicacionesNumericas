function [XYZ_sat, cdT]=get_data_sats(sp,t,prn,N)
if nargin==3, N=8; end  % Si no se especifica, usamos N = 8 nodos
 nsat = length(prn); XYZ_sat=zeros(3,nsat); cdT=zeros(nsat,1);  
 % Si t = único, crea vector de t's iguales 
 if length(t)==1, t=t*ones(1,nsat); end  
   
return