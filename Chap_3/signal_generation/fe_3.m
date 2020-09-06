%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%特征提取信号生成%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all
clc 
close all
%% 参数设置区
fc = 70;              %载波频率
fs = 400;             %采样频率 
rs = 2;               %符号速率
N_code = 2000;           %符号数量
N_filter = 200;       %滤波器阶数
Num_classes = 8;      %信号种类数量
snr_min = -5;         %信噪比范围
snr_max = 15;         
N_samples = 10;     %每个SNR下样本数量
num_fe = 25;          %特征数量 

disp('Initializing...')
mode1 = zeros(N_samples*(snr_max-snr_min+1),25);
mode2 = zeros(N_samples*(snr_max-snr_min+1),25);
mode3 = zeros(N_samples*(snr_max-snr_min+1),25);
mode4 = zeros(N_samples*(snr_max-snr_min+1),25);
mode5 = zeros(N_samples*(snr_max-snr_min+1),25);
mode6 = zeros(N_samples*(snr_max-snr_min+1),25);
mode7 = zeros(N_samples*(snr_max-snr_min+1),25);
mode8 = zeros(N_samples*(snr_max-snr_min+1),25);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%滤波器设计%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
disp('Filter Designing')
flag = 'scale';
win = hamming(N_filter+1);
h1  = fir1(N_filter, [fc-2*rs fc+2*rs]/(fs/2), 'bandpass', win, flag);
h1n  = fir1(N_filter, [fc-1.2*2*rs fc+1.2*2*rs]/(fs/2), 'bandpass', win, flag);

h2  = fir1(N_filter, [fc-4*rs fc+4*rs]/(fs/2), 'bandpass', win, flag);
h2n  = fir1(N_filter, [fc-1.2*4*rs fc+1.2*4*rs]/(fs/2), 'bandpass', win, flag);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
disp('Feature Exaction started...')
for snr = snr_min:snr_max
    for i=1:N_samples
        %if mod(i,200)==0
            disp(['Current SNR=',num2str(snr),'dB'])
            disp(['N_sample=',num2str(i)])
        %end
        [~,y] = ask2(N_code,fc,fs,rs);
        y_n = process(h1,h1n,y,N_filter,snr);
        [r_max,E,m_A,sigma_aa,sigma_ap,sigma_dp,sigma_af,P_max]=inst_fe(y_n,fc,fs,rs);
        [d_1,d_2,d_3,d_4,d_5,d_6,d_7]=hoc_fe(y_n,fc,fs);
        [E1,E2,E3,E4,E5]=wt_fe(y_n);
        [R1,R2,R3,Beta,P]=csd_fe(y_n,fs,fc);
        x_train((snr-snr_min)*N_samples+i,:)=[r_max,E,m_A,sigma_aa,sigma_ap,sigma_dp,sigma_af,...
            P_max,d_1,d_2,d_3,d_4,d_5,d_6,d_7,E1,E2,E3,E4,E5,R1,R2,R3,Beta,P];
        y_train((snr-snr_min)*N_samples+i,:)=1;
        
        [~,y] = fsk2(N_code,fc,fs,rs);
        y_n = process(h2,h2n,y,N_filter,snr);
        [r_max,E,m_A,sigma_aa,sigma_ap,sigma_dp,sigma_af,P_max]=inst_fe(y_n,fc,fs,rs);
        [d_1,d_2,d_3,d_4,d_5,d_6,d_7]=hoc_fe(y_n,fc,fs);
        [E1,E2,E3,E4,E5]=wt_fe(y_n);
        [R1,R2,R3,Beta,P]=csd_fe(y_n,fs,fc);
        x_train((snr-snr_min)*N_samples+i,:)=[r_max,E,m_A,sigma_aa,sigma_ap,sigma_dp,sigma_af,...
            P_max,d_1,d_2,d_3,d_4,d_5,d_6,d_7,E1,E2,E3,E4,E5,R1,R2,R3,Beta,P];
        y_train((snr-snr_min)*N_samples+i,:)=2;    
        
        [~,y] = fsk4(N_code,fc,fs,rs);
        y_n = process(h2,h2n,y,N_filter,snr);
        [r_max,E,m_A,sigma_aa,sigma_ap,sigma_dp,sigma_af,P_max]=inst_fe(y_n,fc,fs,rs);
        [d_1,d_2,d_3,d_4,d_5,d_6,d_7]=hoc_fe(y_n,fc,fs);
        [E1,E2,E3,E4,E5]=wt_fe(y_n);
        [R1,R2,R3,Beta,P]=csd_fe(y_n,fs,fc);
        x_train((snr-snr_min)*N_samples+i,:)=[r_max,E,m_A,sigma_aa,sigma_ap,sigma_dp,sigma_af,...
            P_max,d_1,d_2,d_3,d_4,d_5,d_6,d_7,E1,E2,E3,E4,E5,R1,R2,R3,Beta,P];
        y_train((snr-snr_min)*N_samples+i,:)=3;
        
        [~,y] = fsk8(N_code,fc,fs,rs);
        y_n = process(h2,h2n,y,N_filter,snr);
        [r_max,E,m_A,sigma_aa,sigma_ap,sigma_dp,sigma_af,P_max]=inst_fe(y_n,fc,fs,rs);
        [d_1,d_2,d_3,d_4,d_5,d_6,d_7]=hoc_fe(y_n,fc,fs);
        [E1,E2,E3,E4,E5]=wt_fe(y_n);
        [R1,R2,R3,Beta,P]=csd_fe(y_n,fs,fc);
        x_train((snr-snr_min)*N_samples+i,:)=[r_max,E,m_A,sigma_aa,sigma_ap,sigma_dp,sigma_af,...
            P_max,d_1,d_2,d_3,d_4,d_5,d_6,d_7,E1,E2,E3,E4,E5,R1,R2,R3,Beta,P];
        y_train((snr-snr_min)*N_samples+i,:)=4;
        
        [~,y] = psk2(N_code,fc,fs,rs);
        y_n = process(h2,h2n,y,N_filter,snr);
        [r_max,E,m_A,sigma_aa,sigma_ap,sigma_dp,sigma_af,P_max]=inst_fe(y_n,fc,fs,rs);
        [d_1,d_2,d_3,d_4,d_5,d_6,d_7]=hoc_fe(y_n,fc,fs);
        [E1,E2,E3,E4,E5]=wt_fe(y_n);
        [R1,R2,R3,Beta,P]=csd_fe(y_n,fs,fc);
        x_train((snr-snr_min)*N_samples+i,:)=[r_max,E,m_A,sigma_aa,sigma_ap,sigma_dp,sigma_af,...
            P_max,d_1,d_2,d_3,d_4,d_5,d_6,d_7,E1,E2,E3,E4,E5,R1,R2,R3,Beta,P];
        y_train((snr-snr_min)*N_samples+i,:)=5;
        
        [~,y] = psk4(N_code,fc,fs,rs);
        y_n = process(h2,h2n,y,N_filter,snr);
        [r_max,E,m_A,sigma_aa,sigma_ap,sigma_dp,sigma_af,P_max]=inst_fe(y_n,fc,fs,rs);
        [d_1,d_2,d_3,d_4,d_5,d_6,d_7]=hoc_fe(y_n,fc,fs);
        [E1,E2,E3,E4,E5]=wt_fe(y_n);
        [R1,R2,R3,Beta,P]=csd_fe(y_n,fs,fc);
        x_train((snr-snr_min)*N_samples+i,:)=[r_max,E,m_A,sigma_aa,sigma_ap,sigma_dp,sigma_af,...
            P_max,d_1,d_2,d_3,d_4,d_5,d_6,d_7,E1,E2,E3,E4,E5,R1,R2,R3,Beta,P];
        y_train((snr-snr_min)*N_samples+i,:)=6;
        
        [~,y] = psk8(N_code,fc,fs,rs);
        y_n = process(h2,h2n,y,N_filter,snr);
        [r_max,E,m_A,sigma_aa,sigma_ap,sigma_dp,sigma_af,P_max]=inst_fe(y_n,fc,fs,rs);
        [d_1,d_2,d_3,d_4,d_5,d_6,d_7]=hoc_fe(y_n,fc,fs);
        [E1,E2,E3,E4,E5]=wt_fe(y_n);
        [R1,R2,R3,Beta,P]=csd_fe(y_n,fs,fc);
        x_train((snr-snr_min)*N_samples+i,:)=[r_max,E,m_A,sigma_aa,sigma_ap,sigma_dp,sigma_af,...
            P_max,d_1,d_2,d_3,d_4,d_5,d_6,d_7,E1,E2,E3,E4,E5,R1,R2,R3,Beta,P];
        y_train((snr-snr_min)*N_samples+i,:)=7;
        
        [~,y] = qam16(N_code,fc,fs,rs);
        y_n = process(h2,h2n,y,N_filter,snr);
        [r_max,E,m_A,sigma_aa,sigma_ap,sigma_dp,sigma_af,P_max]=inst_fe(y_n,fc,fs,rs);
        [d_1,d_2,d_3,d_4,d_5,d_6,d_7]=hoc_fe(y_n,fc,fs);
        [E1,E2,E3,E4,E5]=wt_fe(y_n);
        [R1,R2,R3,Beta,P]=csd_fe(y_n,fs,fc);
        x_train((snr-snr_min)*N_samples+i,:)=[r_max,E,m_A,sigma_aa,sigma_ap,sigma_dp,sigma_af,...
            P_max,d_1,d_2,d_3,d_4,d_5,d_6,d_7,E1,E2,E3,E4,E5,R1,R2,R3,Beta,P];
        y_train((snr-snr_min)*N_samples+i,:)=8;
    end
end
