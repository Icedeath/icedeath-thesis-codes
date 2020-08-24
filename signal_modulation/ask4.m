function [m,y]=ask4(N_code,fc,fs,rs)
M = 4;     %4ASK调制
m = randi([0 M-1],N_code,1); %符号序列
N_s = fs/rs;       %单个符号采样数
xsym = zeros(1,N_s*N_code);     

for i = 1:N_code
    xsym(1,(i-1)*N_s+1:(i-1)*N_s+N_s) = m(i);    %生成NRZ码元序列
end

xsym = (xsym+1)/8;        %对应文中调制参数，0~7对应调制幅度为0.125~1

y = modulate(xsym,fc,fs,'am');  %载波调制