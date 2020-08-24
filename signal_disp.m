clear all
clc
addpath signal_modulation
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%调制信号参数设置%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fc = 70;              %载波频率
fs = 400;             %采样频率 
rs = 2;               %符号速率
N_code = 10;         %符号数量
N_filter = 200;       %滤波器阶数
%%%%%%%%%%%%%%%%%%%%%%%%%%%调制信号并进行带限滤波%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[m,y] = ask8(N_code,fc,fs,rs);   %修改调制方式对应的函数，输出基带码元和对应的调制波形

[h,y_f] = fir_filter(fs,N_filter,fc-2*rs,fc+2*rs,y);   %设计滤波器并进行滤波

beta = sig_e(y_f)/sig_e(y)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%输出各种图%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% figure()
% subplot(3,1,1)
% m=[m;m(end,1)];
% n = [0:N_code]+0.5;
% stairs(n,m,'LineWidth',2)
% xlabel('码元序号')
% title('基带码元波形')
% xlim([0.5,N_code+0.5])
% subplot(3,1,2)
% n = [1:fs/rs*N_code]/fs;
% plot(y);
% title('时域波形')
% xlabel('时间/ms')
% ylabel('幅值')
% subplot(3,1,3)
% spec(y,fs,rs,N_code);   %频谱

figure()
subplot(3,1,1)
n = [1:fs/rs*N_code]/fs;
plot(y);
set(gca,'FontSize',10.5,'Fontname', 'Times New Roman');
title('\fontname{宋体}未带限时域波形')
xlabel('\fontname{宋体}时间/\fontname{Times New Roman}ms')
ylabel('\fontname{宋体}幅值')
subplot(3,1,2)
[h_f,w] = freqz(h,1);
w = w*fs/2/pi;           %归一化频率转化为实际频率
h_f = 20*log10(abs(h_f));  %转化为dB
plot(w,h_f)
grid on
set(gca,'FontSize',10.5,'Fontname', 'Times New Roman');
title('\fontname{宋体}带限滤波器幅频特性\fontname{Times New Roman}(\itB_l=4R_s\rm)')
xlabel('\fontname{宋体}频率/\fontname{Times New Roman}MHz')
ylabel('\fontname{宋体}幅度响应\fontname{Times New Roman}(dB)')
% xlim([0,fs/2])
% ylim([-80,2])
subplot(3,1,3)
n = [1:fs/rs*N_code]/fs;
plot(y_f);
set(gca,'FontSize',10.5,'Fontname', 'Times New Roman');
title('\fontname{宋体}带限后时域波形')
xlabel('\fontname{宋体}时间\fontname{Times New Roman}/ms')
ylabel('\fontname{宋体}幅值')