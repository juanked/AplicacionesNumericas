function dS = get_S(s,N)
    dS=zeros(N,1);
    dS(1,1)=1;
    for i=2:N
        k=i-1;
        dS(i,1) = dS(i-1,1)*((s-k+1)/k);
    end
    fprintf('%.5f ',dS);
return

% s=1; N=3; get_S(s,N)