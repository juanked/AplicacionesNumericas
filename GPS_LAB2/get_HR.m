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
 