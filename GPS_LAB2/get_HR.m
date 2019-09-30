function [H,R]=get_HR(XYZ,pos)
nsat = size(XYZ,2); H=zeros(nsat,4); R=zeros(nsat,1);
H = jacobian(XYZ, pos);

return
