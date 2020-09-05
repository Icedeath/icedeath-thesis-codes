clear all
clc
addpath(genpath('./'))
%% 参数设置区
fc = 70;              %载波频率
fs = 400;             %采样频率 
rs = 2;               %符号速率
N_code = 15;          %符号数量
N_filter = 200;       %滤波器阶数
snr = 10;              %信噪比


[m,y] = ask2(N_code,fc,fs,rs);   %修改调制方式对应的函数，输出基带码元和对应的调制波形
flag = 'scale';
win = hamming(N_filter+1);

h2  = fir1(N_filter, [fc-4*rs fc+4*rs]/(fs/2), 'bandpass', win, flag);

h2n  = fir1(N_filter, [fc-1.2*4*rs fc+1.2*4*rs]/(fs/2), 'bandpass', win, flag);

[h,y_f] = fir_filter(fs,N_filter,fc-4*rs,fc+4*rs,y);   %设计滤波器并进行滤波

[n_b,y_n1] = awgn_bl(fs,N_filter,fc-4*1.2*rs,fc+4*1.2*rs,y_f,snr);  %加噪声

y_n = process(h2,h2n,y,N_filter,snr);

subplot(2,1,1)
plot(y_n1)
subplot(2,1,2)
plot(y_n)