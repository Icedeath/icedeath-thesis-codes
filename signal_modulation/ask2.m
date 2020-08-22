function [m,y]=ask2(N_code,fc,fs,rs)
M = 2;     %2ASK调制
xsym = randi([0 M-1],N_code,1); %符号序列
N_s = fs/rs;       %单个符号采样数
m = zeros(1,N_s*N_code);     
for i = 1:N_code
    m(1,(i-1)*N_s+1:(i-1)*N_s+N_s) = xsym(i);    %生成NRZ码元序列
end

m = m*0.6 + 0.2;        %对应文中调制参数，0和1对应调制幅度为0.2与0.8

y = modulate(m,fc,fs,'am');  %载波调制