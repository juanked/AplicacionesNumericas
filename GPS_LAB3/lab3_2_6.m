sats=[1 2 5 6 14 16 21 25 30];
lista=nchoosek(sats,4);
PDoP5=zeros(1,126);
for i=1:length(lista)
    XYZ=get_data_sats(sp,t,lista(i,:),N);
    H=get_HR(XYZ,pos);
    Q=(H'*H)^(-1);
    PDoP5(1,i)=sqrt(Q(1,1)+Q(2,2)+Q(3,3));
end

satmin=lista(find(PDoP5==minimo),:);
satmax=lista(find(PDoP5==maximo),:);
XYZ=get_data_sats(sp,t,lista(i,:),N);
plot(XYZog(1,:),XYZog(2,:),'bo')
hold on
XYZog=get_data_sats(sp, t, satmin, N);
plot(XYZog(1,:),XYZog(2,:),'r.')
XYZog=get_data_sats(sp, t, satmax, N);
hold on
plot(XYZog(1,:),XYZog(2,:),'g.')
legend('satelites', 'minimo', 'maximo')