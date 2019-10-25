clear all;
load obs;
sp=read_sp3('igs13230.sp3');
NT=900;
S=zeros(4,NT);
obs=yebe.obs;
prns=yebe.prn;
tow=yebe.tow;
prnsmat=zeros(26,900);
Xmad=[4855000; -325000; 4115000; 0.00];
% S(:,1)=get_pos(sp,tow(1),prnsmat,obs,Xmad);

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

% contador=0;
% columnaobs=obs(:,2);   
% for j=1:length(columnaobs)
%         if columnaobs(j)>0
%             contador=contador+1;
%         end
% end
%      resultadoobs=zeros(contador,1);
%      resultadoprn=zeros(1,contador);
%      contador=0;
% for j=1:length(columnaobs)        
%         if columnaobs(j)>0
%             contador=contador+1;
%             resultadoobs(contador)=columnaobs(j);
%             resultadoprn(contador)=prns(j);
%         end
% end
% S(:,2)=get_pos(sp,tow(2),resultadoprn,resultadoobs,S(:,1));
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




% for i=1:length(obs)
%     columna=obs(:,i);
%     for j=1:length(columna)
%         if obs(j,i)<=0
%             prnsmat(j,i)=0;
%             obs(j,i)=0;
%         end
%     end
%     
% end
% prnsmat2=prnsmat(prnsmat~=0);
% prnsmat= prnsmat2.';
% obs=obs(obs~=0);
% S(:,1)=get_pos(sp,tow(1),prnsmat,obs,Xmad);
% for i=2:900
%     %S(:,i)=get_pos(sp,tow(i),prnsmat(:,1),obs(:,1),S(:,i-1));
% end
