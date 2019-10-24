load obs;
sp=read_sp3('igs13230.sp3');
NT=900;
S=zeros(4,NT);
obs=yebe.obs;
contador=0;
prns=yebe.prn;
tow=yebe.tow;
for i=1:length(obs)
    columna=obs(:,i);
    
    for j=1:length(columna)
        if columna(j)>0
            contador=contador+1;
            
        end
        
    end
    
    
end
resultado=zeros(contador,1);
resultado2=zeros(contador,1);
contador2=0;
for i=1:length(obs)
    columna=obs(:,i);
    
    for j=1:length(columna)
        if columna(j)>0
            contador2=contador2+1;
            resultado(contador2)=columna(j);
            resultado2(contador2)=prns(j);
            if j==1
                Xmad=[4855000; -325000; 4115000; 0.00];
                S(:,contador2)=get_pos(sp,tow,resultado2,resultado,Xmad);
            else
                S(:,contador2)=get_pos(sp,tow,resultado2,resultado,S(:,contador2-1));
            end
        
        end 
    end
end
