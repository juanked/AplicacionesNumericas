clear all
sp=read_sp3('igs13230.sp3');
sats=[1 2 5 6 14 16 21 25 30];
N=8;
t=7200;
pos=~[4855000; -325000; 4115000];
for i=1:1000
    for j=1:4
        XYZ(:,j)=XYZ(:,j)+randn(3,1);
    end
end
H=get_HR(XYZ,pos);
Q=(H'*H)^-1;
varx=sqrt(Q(1,1));
vary=sqrt(Q(2,2));
varz=sqrt(Q(3,3));
PDoP3=sqrt(Q(1,1)+Q(2,2)+Q(3,3));