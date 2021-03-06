clear all
clc
addpath(genpath('./'))
%% 参数设置区
fc = 70;              %载波频率
fs = 400;             %采样频率 
rs = 2;               %符号速率
N_code = 1000;          %符号数量
N_filter = 2000;       %滤波器阶数
snr = 0;              %信噪比

%% 功能函数
%%%%%%%%%%%%%%%%%%%%%%%%%%%调制信号，滤波，加噪声等%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[m,y] = qam16(N_code,fc,fs,rs);   %修改调制方式对应的函数，输出基带码元和对应的调制波形

[h,y_f] = fir_filter(fs,N_filter,fc-4*rs,fc+4*rs,y);   %设计滤波器并进行滤波

[n_b,y_n] = awgn_bl(fs,N_filter,fc-2*1.2*rs,fc+2*1.2*rs,y_f,snr);  %加噪声

% beta = sig_e(y_f)/sig_e(y) %滤波后保留的能量

% 画图区
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%码元序列，时域波形，频域%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%滤波器幅频特性+滤波后波形(第2章)%%%%%%%%%%%%%%%%%%%%%%
% figure()
% subplot(2,1,1)
% [h_f,w] = freqz(h,1);
% w = w*fs/2/pi;           %归一化频率转化为实际频率
% h_f = 20*log10(abs(h_f));  %转化为dB
% plot(w,h_f)
% grid on
% set(gca,'FontSize',10.5,'Fontname', 'Times New Roman');
% title('\fontname{宋体}带限滤波器幅频特性\fontname{Times New Roman}(\itB_l=\rm8\itR_s\rm)')
% xlabel('\fontname{宋体}频率/\fontname{Times New Roman}MHz')
% ylabel('\fontname{宋体}幅度响应\fontname{Times New Roman}(dB)')
% % xlim([0,fs/2])
% % ylim([-80,2])
% subplot(2,1,2)
% n = [1:fs/rs*N_code]/fs;
% plot(n,y_f);
% xlim([0,n(1,end)])
% set(gca,'FontSize',10.5,'Fontname', 'Times New Roman');
% title('\fontname{宋体}带限后时域波形')
% xlabel('\fontname{宋体}时间\fontname{Times New Roman}/ms')
% ylabel('\fontname{宋体}幅值')

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%加噪前，加噪后对比(第2章)%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure()
subplot(2,1,1)
n = [1:fs/rs*N_code]/fs;
plot(n,y_f);
xlim([0,n(1,end)])
set(gca,'FontSize',10.5,'Fontname', 'Times New Roman');
title('\fontname{宋体}理想\fontname{Times New Roman}16-QAM\fontname{宋体}信号时域波形')
xlabel('\fontname{宋体}时间\fontname{Times New Roman}/ms')
ylabel('\fontname{宋体}幅值')
subplot(2,1,2)
spec(y_f,fs,rs,N_code); 
title('\fontname{宋体}理想\fontname{Times New Roman}16-QAM\fontname{宋体}信号频谱')

figure()
subplot(2,1,1)
n = [1:fs/rs*N_code]/fs;
plot(n,y_n);
xlim([0,n(1,end)])
set(gca,'FontSize',10.5,'Fontname', 'Times New Roman');
title('\fontname{宋体}加噪声后\fontname{Times New Roman}16-QAM\fontname{宋体}信号时域波形')
xlabel('\fontname{宋体}时间\fontname{Times New Roman}/ms')
ylabel('\fontname{宋体}幅值')
subplot(2,1,2)
spec(y_n,fs,rs,N_code); 
title('\fontname{宋体}加噪声后\fontname{Times New Roman}16-QAM\fontname{宋体}信号频谱')

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%瞬时幅度，相位以及频率%%%%%%%%%%%%%%%%%%%%%%%%%%%
% [a,phi_NL,f]=int_inf(y_f,fc,fs);
% figure()
% subplot(4,1,1)
% n = [1:fs/rs*N_code]/fs;
% plot(n,y_f);
% xlim([0,n(1,end)])
% set(gca,'FontSize',10.5,'Fontname', 'Times New Roman');
% ylabel('\fontname{宋体}时域波形')
% xlabel('\fontname{宋体}时间\fontname{Times New Roman}/ms')
% subplot(4,1,2)
% plot(n,a);
% xlim([0,n(1,end)])
% set(gca,'FontSize',10.5,'Fontname', 'Times New Roman');
% ylabel('\fontname{宋体}瞬时幅度')
% xlabel('\fontname{宋体}时间\fontname{Times New Roman}/ms')
% grid on
% subplot(4,1,3)
% plot(n,phi_NL);
% ylabel('\fontname{宋体}瞬时相位')
% xlabel('\fontname{宋体}时间\fontname{Times New Roman}/ms')
% xlim([0,n(1,end)])
% grid on
% subplot(4,1,4)
% plot(n,f);
% ylabel('\fontname{宋体}瞬时频率')
% xlabel('\fontname{宋体}时间\fontname{Times New Roman}/ms')
% xlim([0,n(1,end)])
% %ylim([-6,6])
% grid on

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%复基带包络%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%