%Usaremos N=8 dado que es un valor típico
N=8;
h=900;
sp=read_sp3('IGS12651.SP3');
primero=sp.tow(1);
seg=9*3600+20*60;
t=primero+seg;
x=(t-sp.tow(1))/sp.delta;
prev=floor(x)+1;
rg=(prev-(N/2)+1:prev+N/2);
tk=sp.tow(rg);
xk=sp.XYZ(1,rg,25);
% yk=sp.XYZ(2,rg,25);
% zk=sp.XYZ(3,rg,25);
% ek=sp.cdT(25,rg);
% mat=[tk, xk, yk, zk, ek];
dx=get_df(xk);
% fprintf('%.3f ',xk);
% fprintf('\n');
% fprintf('%.3f ',dx);
s=(N/2-1)+mod(t,h)/h;
S=get_S(s,N);

dx*S
% fprintf('%.3f',suma)
% xk=sp.XYZdT(1,rg,3)


