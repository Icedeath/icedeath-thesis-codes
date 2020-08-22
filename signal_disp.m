clear all
clc
addpath signal_modulation
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%调制信号参数设置%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fc = 70;              %载波频率
fs = 400;             %采样频率 
rs = 2;               %符号速率
N_code = 50;          %符号数量
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[m,y] = msk(N_code,fc,fs,rs);   %修改调制方式对应的函数，输出基带码元和对应的调制波形

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%输出各种图%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure()
subplot(3,1,1)
m=[m;m(end,1)];
n = [0:N_code]+0.5;
stairs(n,m,'LineWidth',2)
xlabel('码元序号')
title('基带码元波形')
xlim([0.5,N_code+0.5])
subplot(3,1,2)
n = [1:fs/rs*N_code]/fs;
plot(y);
title('时域波形')
xlabel('时间/ms')
ylabel('幅值')
subplot(3,1,3)
spec(y,fs,rs,N_code);   %频谱
sig_e(y)