clear all
sp=read_sp3('igs13230.sp3');
sats=[1 2 5 6 14 16 21 25 30];
N=8;
t=7200;
pos=~[4855000; -325000; 4115000];
sats=[6 16 25 30];
XYZ=get_data_sats(sp,t,sats,N);
H=get_HR(XYZ,pos);
Q=(H'*H)^-1;
PDoP2=sqrt(Q(1,1)+Q(2,2)+Q(3,3));