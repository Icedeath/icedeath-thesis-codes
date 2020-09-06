clear all
clc 
close all

addpath(genpath('../'))
%% ����������
fc = 70;              %�ز�Ƶ��
fs = 400;             %����Ƶ�� 
rs = 2;               %��������
N_code = 100000;           %��������
N_filter = 200;      %�˲�������
snr = 20;         %����ȷ�Χ        
N_samples = 10;     %ÿ��SNR����������
num_fe = 25;          %�������� 
disp('Filter Designing')
flag = 'scale';
win = hamming(N_filter+1);
h1  = fir1(N_filter, [fc-2*rs fc+2*rs]/(fs/2), 'bandpass', win, flag);
h1n  = fir1(N_filter, [fc-1.2*2*rs fc+1.2*2*rs]/(fs/2), 'bandpass', win, flag);

[~,y] = ask2(N_code,fc,fs,rs);
y_n = process(h1,h1n,y,N_filter,snr);

[r_max,E,m_A,sigma_aa,sigma_ap,sigma_dp,sigma_af,P_max]=inst_fe(y_n,fc,fs,rs);
[d_1,d_2,d_3,d_4,d_5,d_6,d_7]=hoc_fe(y_n,fc,fs);
a=[r_max,E,m_A,sigma_aa,sigma_ap,sigma_dp,sigma_af,P_max,d_1,d_2,d_3,d_4,d_5,d_6,d_7];
% 
% [r_max,E,m_A,sigma_aa,sigma_ap,sigma_dp,sigma_af,P_max,d_1,d_2,d_3,d_4,d_5,d_6,d_7]=featuressgj_extraction(y_n,fc,fs,rs);
% b=[r_max,E,m_A,sigma_aa,sigma_ap,sigma_dp,sigma_af,P_max,d_1,d_2,d_3,d_4,d_5,d_6,d_7];
r = zeros(1,11);
r1 = zeros(1,N_samples);
for snr = 0:2:20
    for i=1:N_samples
        if mod(i,200)==0    
            i
        end
    [~,y] = ask2(N_code,fc,fs,rs);
    y_n = process(h1,h1n,y,N_filter,snr);
    [r_max,~]=inst_fe(y_n,fc,fs,rs);
    r1(i)=r_max;
    end
    snr
    r(snr/2+1)=mean(r1);
end
plot(r)
