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
prnsmat=prnsmat(prnsmat~=0);
obs=obs(obs~=0);
S(:,1)=get_pos(sp,tow(1),prnsmat(:,1),obs(:,1),Xmad);
for i=2:900
    S(:,i)=get_pos(sp,tow(1),prnsmat(:,1),obs(:,1),S(:,i-1));
end
