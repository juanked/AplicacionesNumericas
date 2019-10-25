load obs;
sp=read_sp3('igs13230.sp3');
NT=900;
S=zeros(4,NT);
obs=yebe.obs;
prns=yebe.prn;
tow=yebe.tow;
prnsmat=zeros(26,900);
Xmad=[4855000; -325000; 4115000; 0.00];
c = 2.99792458e8;

contador=0;
columnaobs=obs(:,1);   
for j=1:length(columnaobs)
        if columnaobs(j)>0
            contador=contador+1;
        end
end
     resultadoobs=zeros(contador,1);
     resultadoprn=zeros(1,contador);
     contador=0;
for j=1:length(columnaobs)        
        if columnaobs(j)>0
            contador=contador+1;
            resultadoobs(contador)=columnaobs(j);
            resultadoprn(contador)=prns(j);
        end
end
S(:,1)=get_pos(sp,tow(1),resultadoprn,resultadoobs,Xmad);
for i=2:900
    contador=0;
    columnaobs=obs(:,i);   
    for j=1:length(columnaobs)
          if columnaobs(j)>0
              contador=contador+1;
          end
    end
        resultadoobs=zeros(contador,1);
         resultadoprn=zeros(1,contador);
        contador=0;
    for j=1:length(columnaobs)        
            if columnaobs(j)>0
                contador=contador+1;
                resultadoobs(contador)=columnaobs(j);
                resultadoprn(contador)=prns(j);
            end
    end
    S(:,i)=get_pos(sp,tow(i),resultadoprn,resultadoobs,S(:,(i-1)));
 end

errorrel=S(4,:);
errorrel=errorrel/c*1000;
plot(1:900,errorrel);
