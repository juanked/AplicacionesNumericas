clear all
sp=read_sp3('igs13230.sp3');
sats=[1 2 5 6 14 16 21 25 30];
N=8;
t=7200;
pos=~[4855000; -325000; 4115000];
sats=[1 2 5 6 14 16 21 25 30];
lista=nchoosek(sats,4);
PDoP5=zeros(1,126);
for i=1:length(lista)
    XYZ=get_data_sats(sp,t,lista(i,:),N);
    H=get_HR(XYZ,pos);
    Q=(H'*H)^(-1);
    PDoP5(1,i)=sqrt(Q(1,1)+Q(2,2)+Q(3,3));
end
semilogy(PDoP5);
hold on
minimo=min(PDoP5);
maximo=max(PDoP5);
plot(find(PDoP5==minimo),minimo,'bo');
hold on
plot(find(PDoP5==maximo),maximo,'ro');
hold on
legend ('PDoP5','minimo','maximo')
