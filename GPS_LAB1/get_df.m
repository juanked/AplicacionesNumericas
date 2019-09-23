function df=get_df(f)
    N=length(f); f=reshape(f,1,N); % asegura que es un vector fila
    NumDF=1;
while length(f)>NumDF
    I=length(f);
    while I>NumDF
        f(I)=f(I)-f(I-1);
        I=I-1;
    end
    NumDF=NumDF+1;
end
df=f;
fprintf('%.3f ',df);
end
%F=[3 4 1 -1 -2];
