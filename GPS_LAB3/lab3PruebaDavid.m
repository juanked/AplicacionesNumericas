tic;
load obs;
sp=read_sp3('igs13230.sp3');
NT=900;
S=zeros(4,NT);
obs=yebe.obs;
contador=0;
prns=yebe.prn;
tow=yebe.tow;
prnsmat=zeros(26,900);
Xmad=[4855000; -325000; 4115000; 0.00];
c = 2.99792458e8;
for i=1:900
    prnsmat(:,i)=prns';
    
end
for i=1:length(obs)
    columna=obs(:,i);
    for j=1:length(columna)
        if obs(j,i)<=0
            prnsmat(j,i)=0;
            obs(j,i)=0;
        end
    end
    
end
% prnsmat=prnsmat(prnsmat~=0);
% obs=obs(obs~=0);
% nuevoobs=zeros(9,900);
% for i=1:800
%     columna=obs(:,i);
%     columna(columna<=0)=[];
% %     obs(:,i)=columna(:,i);
% end
% S(:,1)=get_pos(sp,tow(1),prnsmat(:,1),obs(:,1),Xmad);
% 
% for i=2:900
%     S(:,i)=get_pos(sp,tow(i),prnsmat(:,i),obs(:,i),S(:,i-1));
% end

toc;