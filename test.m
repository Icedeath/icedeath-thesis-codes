clear all
clc
addpath(genpath('./'))
%% ����������
fc = 70;              %�ز�Ƶ��
fs = 400;             %����Ƶ�� 
rs = 2;               %��������
N_code = 15;          %��������
N_filter = 200;       %�˲�������
snr = 10;              %�����


[m,y] = ask2(N_code,fc,fs,rs);   %�޸ĵ��Ʒ�ʽ��Ӧ�ĺ��������������Ԫ�Ͷ�Ӧ�ĵ��Ʋ���
flag = 'scale';
win = hamming(N_filter+1);

h2  = fir1(N_filter, [fc-4*rs fc+4*rs]/(fs/2), 'bandpass', win, flag);

h2n  = fir1(N_filter, [fc-1.2*4*rs fc+1.2*4*rs]/(fs/2), 'bandpass', win, flag);

[h,y_f] = fir_filter(fs,N_filter,fc-4*rs,fc+4*rs,y);   %����˲����������˲�

[n_b,y_n1] = awgn_bl(fs,N_filter,fc-4*1.2*rs,fc+4*1.2*rs,y_f,snr);  %������

y_n = process(h2,h2n,y,N_filter,snr);

subplot(2,1,1)
plot(y_n1)
subplot(2,1,2)
plot(y_n)