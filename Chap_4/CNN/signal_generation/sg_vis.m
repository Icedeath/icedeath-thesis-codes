%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%CNN信号生成（训练集）%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
close all;
clear all;
clc;

warning off
%% 参数设置区
fc = 70;              %载波频率
fs = 200;             %采样频率 
rs = 2;               %符号速率
N_code = 200;           %符号数量
N_filter = 200;       %滤波器阶数
length = 14000;

num_classes = 15;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
snr = 20;


%%
y_r = zeros(length,15);
m = zeros(N_code,15);

tic;

[mr,yr] = ask2(N_code,fc,fs,rs);
[~,yr] = fir_filter(fs,N_filter,fc-2*rs,fc+2*rs,yr);
y(1,:) = awgn_bl(fs,N_filter,fc-2*1.2*rs,fc+2*1.2*rs,yr,snr)';
m(:,1) = mr';

[mr,yr] = ask4(N_code,fc,fs,rs);
[~,yr] = fir_filter(fs,N_filter,fc-2*rs,fc+2*rs,yr);
y(2,:) = awgn_bl(fs,N_filter,fc-2*1.2*rs,fc+2*1.2*rs,yr,snr)';
m(:,2) = mr';

[mr,yr] = ask8(N_code,fc,fs,rs);
[~,yr] = fir_filter(fs,N_filter,fc-2*rs,fc+2*rs,yr);
y(3,:) = awgn_bl(fs,N_filter,fc-2*1.2*rs,fc+2*1.2*rs,yr,snr)';
m(:,3) = mr';

[mr,yr] = fsk2(N_code,fc,fs,rs);
[~,yr] = fir_filter(fs,N_filter,fc-4*rs,fc+4*rs,yr);
y(4,:) = awgn_bl(fs,N_filter,fc-4*1.2*rs,fc+4*1.2*rs,yr,snr)';
m(:,4) = mr';

[mr,yr] = fsk4(N_code,fc,fs,rs);
[~,yr] = fir_filter(fs,N_filter,fc-4*rs,fc+4*rs,yr);
y(5,:) = awgn_bl(fs,N_filter,fc-4*1.2*rs,fc+4*1.2*rs,yr,snr)';
m(:,5) = mr';

[mr,yr] = fsk8(N_code,fc,fs,rs);
[~,yr] = fir_filter(fs,N_filter,fc-4*rs,fc+4*rs,yr);
y(6,:) = awgn_bl(fs,N_filter,fc-4*1.2*rs,fc+4*1.2*rs,yr,snr)';
m(:,6) = mr';

[mr,yr] = psk2(N_code,fc,fs,rs);
[~,yr] = fir_filter(fs,N_filter,fc-4*rs,fc+4*rs,yr);
y(7,:) = awgn_bl(fs,N_filter,fc-4*1.2*rs,fc+4*1.2*rs,yr,snr)';
m(:,7) = mr';

[mr,yr] = psk4(N_code,fc,fs,rs);
[~,yr] = fir_filter(fs,N_filter,fc-4*rs,fc+4*rs,yr);
y(8,:) = awgn_bl(fs,N_filter,fc-4*1.2*rs,fc+4*1.2*rs,yr,snr)';
m(:,8) = mr';

[mr,yr] = psk8(N_code,fc,fs,rs);
[~,yr] = fir_filter(fs,N_filter,fc-4*rs,fc+4*rs,yr);
y(9,:) = awgn_bl(fs,N_filter,fc-4*1.2*rs,fc+4*1.2*rs,yr,snr)';
m(:,9) = mr';

[mr,yr] = qam16(N_code,fc,fs,rs);
[~,yr] = fir_filter(fs,N_filter,fc-4*rs,fc+4*rs,yr);
y(10,:) = awgn_bl(fs,N_filter,fc-4*1.2*rs,fc+4*1.2*rs,yr,snr)';
m(:,10) = mr';

[mr,yr] = qam64(N_code,fc,fs,rs);
[~,yr] = fir_filter(fs,N_filter,fc-4*rs,fc+4*rs,yr);
y(11,:) = awgn_bl(fs,N_filter,fc-4*1.2*rs,fc+4*1.2*rs,yr,snr)';
m(:,11) = mr';

[mr,yr] = qam128(N_code,fc,fs,rs);
[~,yr] = fir_filter(fs,N_filter,fc-2.25*rs,fc+2.25*rs,yr);
y(12,:) = awgn_bl(fs,N_filter,fc-4*1.2*rs,fc+4*1.2*rs,yr,snr)';
m(:,12) = mr';

[mr,yr] = qam256(N_code,fc,fs,rs);
[~,yr] = fir_filter(fs,N_filter,fc-2*rs,fc+2*rs,yr);
y(13,:) = awgn_bl(fs,N_filter,fc-4*1.2*rs,fc+4*1.2*rs,yr,snr)';
m(:,13) = mr';

[mr,yr] = msk(N_code,fc,fs,rs);
[~,yr] = fir_filter(fs,N_filter,fc-2.25*rs,fc+2.25*rs,yr);
y(14,:) = awgn_bl(fs,N_filter,fc-4*1.2*rs,fc+4*1.2*rs,yr,snr)';
m(:,14) = mr';

[mr,yr] = gmsk(N_code,fc,fs,rs);
[~,yr] = fir_filter(fs,N_filter,fc-2.25*rs,fc+2.25*rs,yr);
y(15,:) = awgn_bl(fs,N_filter,fc-4*1.2*rs,fc+4*1.2*rs,yr,snr)';
m(:,15) = mr';
%%
save(strcat('../samples/vis_',num2str(snr)),'y','m','snr','-v7.3')
toc;