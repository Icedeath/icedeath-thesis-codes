%%%%%%%%%%%%%%%%%%%%%%%%%%%特征提取%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all
clc 
close all

addpath(genpath('../'))
%% 参数设置区
fc = 70;              %载波频率
fs = 400;             %采样频率 
rs = 2;               %符号速率
N_code = 1500;           %符号数量
N_filter = 200;      %滤波器阶数
snr_min = 0;         %信噪比范围
snr_max = 20;         
N_samples = 5000;     %每个SNR下样本数量
num_fe = 25;          %特征数量 

disp('Initializing...')
mode1 = zeros(N_samples*(snr_max-snr_min+1),num_fe);
mode2 = zeros(N_samples*(snr_max-snr_min+1),num_fe);
mode3 = zeros(N_samples*(snr_max-snr_min+1),num_fe);
mode4 = zeros(N_samples*(snr_max-snr_min+1),num_fe);
mode5 = zeros(N_samples*(snr_max-snr_min+1),num_fe);
mode6 = zeros(N_samples*(snr_max-snr_min+1),num_fe);
mode7 = zeros(N_samples*(snr_max-snr_min+1),num_fe);
mode8 = zeros(N_samples*(snr_max-snr_min+1),num_fe);
mode9 = zeros(N_samples*(snr_max-snr_min+1),num_fe);
mode10 = zeros(N_samples*(snr_max-snr_min+1),num_fe);
mode11 = zeros(N_samples*(snr_max-snr_min+1),num_fe);
mode12 = zeros(N_samples*(snr_max-snr_min+1),num_fe);
mode13 = zeros(N_samples*(snr_max-snr_min+1),num_fe);
mode14 = zeros(N_samples*(snr_max-snr_min+1),num_fe);
mode15 = zeros(N_samples*(snr_max-snr_min+1),num_fe);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%滤波器设计%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
disp('Filter Designing')
flag = 'scale';
win = hamming(N_filter+1);
h1  = fir1(N_filter, [fc-2*rs fc+2*rs]/(fs/2), 'bandpass', win, flag);
h1n  = fir1(N_filter, [fc-1.2*2*rs fc+1.2*2*rs]/(fs/2), 'bandpass', win, flag);

h2  = fir1(N_filter, [fc-4*rs fc+4*rs]/(fs/2), 'bandpass', win, flag);
h2n  = fir1(N_filter, [fc-1.2*4*rs fc+1.2*4*rs]/(fs/2), 'bandpass', win, flag);

h3  = fir1(N_filter, [fc-2.25*rs fc+2.25*rs]/(fs/2), 'bandpass', win, flag);
h3n  = fir1(N_filter, [fc-1.2*2.25*rs fc+1.2*2.25*rs]/(fs/2), 'bandpass', win, flag);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
disp('Feature Exaction started...')
tic;
for snr = snr_min:snr_max
    for i=1:N_samples
        if mod(i,200)==0
            disp(['Current SNR=',num2str(snr),'dB'])
            disp(['N_sample=',num2str(i)])
        end
        [~,y] = ask2(N_code,fc,fs,rs);
        y_n = process(h1,h1n,y,N_filter,snr);
        [r_max,E,m_A,sigma_aa,sigma_ap,sigma_dp,sigma_af,P_max]=inst_fe(y_n,fc,fs,rs);
        [d_1,d_2,d_3,d_4,d_5,d_6,d_7]=hoc_fe(y_n,fc,fs);
        [E1,E2,E3,E4,E5]=wt_fe(y_n);
        [R1,R2,R3,Beta,P]=csd_fe(y_n,fs,fc);
        mode1((snr-snr_min)*N_samples+i,:)=[r_max,E,m_A,sigma_aa,sigma_ap,sigma_dp,sigma_af,...
            P_max,d_1,d_2,d_3,d_4,d_5,d_6,d_7,E1,E2,E3,E4,E5,R1,R2,R3,Beta,P];
        
        [~,y] = ask4(N_code,fc,fs,rs);
        y_n = process(h1,h1n,y,N_filter,snr);
        [r_max,E,m_A,sigma_aa,sigma_ap,sigma_dp,sigma_af,P_max]=inst_fe(y_n,fc,fs,rs);
        [d_1,d_2,d_3,d_4,d_5,d_6,d_7]=hoc_fe(y_n,fc,fs);
        [E1,E2,E3,E4,E5]=wt_fe(y_n);
        [R1,R2,R3,Beta,P]=csd_fe(y_n,fs,fc);
        mode2((snr-snr_min)*N_samples+i,:)=[r_max,E,m_A,sigma_aa,sigma_ap,sigma_dp,sigma_af,...
            P_max,d_1,d_2,d_3,d_4,d_5,d_6,d_7,E1,E2,E3,E4,E5,R1,R2,R3,Beta,P];
        
        [~,y] = ask8(N_code,fc,fs,rs);
        y_n = process(h1,h1n,y,N_filter,snr);
        [r_max,E,m_A,sigma_aa,sigma_ap,sigma_dp,sigma_af,P_max]=inst_fe(y_n,fc,fs,rs);
        [d_1,d_2,d_3,d_4,d_5,d_6,d_7]=hoc_fe(y_n,fc,fs);
        [E1,E2,E3,E4,E5]=wt_fe(y_n);
        [R1,R2,R3,Beta,P]=csd_fe(y_n,fs,fc);
        mode3((snr-snr_min)*N_samples+i,:)=[r_max,E,m_A,sigma_aa,sigma_ap,sigma_dp,sigma_af,...
            P_max,d_1,d_2,d_3,d_4,d_5,d_6,d_7,E1,E2,E3,E4,E5,R1,R2,R3,Beta,P];
        
        [~,y] = fsk2(N_code,fc,fs,rs);
        y_n = process(h2,h2n,y,N_filter,snr);
        [r_max,E,m_A,sigma_aa,sigma_ap,sigma_dp,sigma_af,P_max]=inst_fe(y_n,fc,fs,rs);
        [d_1,d_2,d_3,d_4,d_5,d_6,d_7]=hoc_fe(y_n,fc,fs);
        [E1,E2,E3,E4,E5]=wt_fe(y_n);
        [R1,R2,R3,Beta,P]=csd_fe(y_n,fs,fc);
        mode4((snr-snr_min)*N_samples+i,:)=[r_max,E,m_A,sigma_aa,sigma_ap,sigma_dp,sigma_af,...
            P_max,d_1,d_2,d_3,d_4,d_5,d_6,d_7,E1,E2,E3,E4,E5,R1,R2,R3,Beta,P];  
        
        [~,y] = fsk4(N_code,fc,fs,rs);
        y_n = process(h2,h2n,y,N_filter,snr);
        [r_max,E,m_A,sigma_aa,sigma_ap,sigma_dp,sigma_af,P_max]=inst_fe(y_n,fc,fs,rs);
        [d_1,d_2,d_3,d_4,d_5,d_6,d_7]=hoc_fe(y_n,fc,fs);
        [E1,E2,E3,E4,E5]=wt_fe(y_n);
        [R1,R2,R3,Beta,P]=csd_fe(y_n,fs,fc);
        mode5((snr-snr_min)*N_samples+i,:)=[r_max,E,m_A,sigma_aa,sigma_ap,sigma_dp,sigma_af,...
            P_max,d_1,d_2,d_3,d_4,d_5,d_6,d_7,E1,E2,E3,E4,E5,R1,R2,R3,Beta,P];
        
        [~,y] = fsk8(N_code,fc,fs,rs);
        y_n = process(h2,h2n,y,N_filter,snr);
        [r_max,E,m_A,sigma_aa,sigma_ap,sigma_dp,sigma_af,P_max]=inst_fe(y_n,fc,fs,rs);
        [d_1,d_2,d_3,d_4,d_5,d_6,d_7]=hoc_fe(y_n,fc,fs);
        [E1,E2,E3,E4,E5]=wt_fe(y_n);
        [R1,R2,R3,Beta,P]=csd_fe(y_n,fs,fc);
        mode6((snr-snr_min)*N_samples+i,:)=[r_max,E,m_A,sigma_aa,sigma_ap,sigma_dp,sigma_af,...
            P_max,d_1,d_2,d_3,d_4,d_5,d_6,d_7,E1,E2,E3,E4,E5,R1,R2,R3,Beta,P];
        
        [~,y] = psk2(N_code,fc,fs,rs);
        y_n = process(h2,h2n,y,N_filter,snr);
        [r_max,E,m_A,sigma_aa,sigma_ap,sigma_dp,sigma_af,P_max]=inst_fe(y_n,fc,fs,rs);
        [d_1,d_2,d_3,d_4,d_5,d_6,d_7]=hoc_fe(y_n,fc,fs);
        [E1,E2,E3,E4,E5]=wt_fe(y_n);
        [R1,R2,R3,Beta,P]=csd_fe(y_n,fs,fc);
        mode7((snr-snr_min)*N_samples+i,:)=[r_max,E,m_A,sigma_aa,sigma_ap,sigma_dp,sigma_af,...
            P_max,d_1,d_2,d_3,d_4,d_5,d_6,d_7,E1,E2,E3,E4,E5,R1,R2,R3,Beta,P];
        
        [~,y] = psk4(N_code,fc,fs,rs);
        y_n = process(h2,h2n,y,N_filter,snr);
        [r_max,E,m_A,sigma_aa,sigma_ap,sigma_dp,sigma_af,P_max]=inst_fe(y_n,fc,fs,rs);
        [d_1,d_2,d_3,d_4,d_5,d_6,d_7]=hoc_fe(y_n,fc,fs);
        [E1,E2,E3,E4,E5]=wt_fe(y_n);
        [R1,R2,R3,Beta,P]=csd_fe(y_n,fs,fc);
        mode8((snr-snr_min)*N_samples+i,:)=[r_max,E,m_A,sigma_aa,sigma_ap,sigma_dp,sigma_af,...
            P_max,d_1,d_2,d_3,d_4,d_5,d_6,d_7,E1,E2,E3,E4,E5,R1,R2,R3,Beta,P];
        
        [~,y] = psk8(N_code,fc,fs,rs);
        y_n = process(h2,h2n,y,N_filter,snr);
        [r_max,E,m_A,sigma_aa,sigma_ap,sigma_dp,sigma_af,P_max]=inst_fe(y_n,fc,fs,rs);
        [d_1,d_2,d_3,d_4,d_5,d_6,d_7]=hoc_fe(y_n,fc,fs);
        [E1,E2,E3,E4,E5]=wt_fe(y_n);
        [R1,R2,R3,Beta,P]=csd_fe(y_n,fs,fc);
        mode9((snr-snr_min)*N_samples+i,:)=[r_max,E,m_A,sigma_aa,sigma_ap,sigma_dp,sigma_af,...
            P_max,d_1,d_2,d_3,d_4,d_5,d_6,d_7,E1,E2,E3,E4,E5,R1,R2,R3,Beta,P];
        
        [~,y] = qam16(N_code,fc,fs,rs);
        y_n = process(h2,h2n,y,N_filter,snr);
        [r_max,E,m_A,sigma_aa,sigma_ap,sigma_dp,sigma_af,P_max]=inst_fe(y_n,fc,fs,rs);
        [d_1,d_2,d_3,d_4,d_5,d_6,d_7]=hoc_fe(y_n,fc,fs);
        [E1,E2,E3,E4,E5]=wt_fe(y_n);
        [R1,R2,R3,Beta,P]=csd_fe(y_n,fs,fc);
        mode10((snr-snr_min)*N_samples+i,:)=[r_max,E,m_A,sigma_aa,sigma_ap,sigma_dp,sigma_af,...
            P_max,d_1,d_2,d_3,d_4,d_5,d_6,d_7,E1,E2,E3,E4,E5,R1,R2,R3,Beta,P];
        
        [~,y] = qam64(N_code,fc,fs,rs);
        y_n = process(h2,h2n,y,N_filter,snr);
        [r_max,E,m_A,sigma_aa,sigma_ap,sigma_dp,sigma_af,P_max]=inst_fe(y_n,fc,fs,rs);
        [d_1,d_2,d_3,d_4,d_5,d_6,d_7]=hoc_fe(y_n,fc,fs);
        [E1,E2,E3,E4,E5]=wt_fe(y_n);
        [R1,R2,R3,Beta,P]=csd_fe(y_n,fs,fc);
        mode11((snr-snr_min)*N_samples+i,:)=[r_max,E,m_A,sigma_aa,sigma_ap,sigma_dp,sigma_af,...
            P_max,d_1,d_2,d_3,d_4,d_5,d_6,d_7,E1,E2,E3,E4,E5,R1,R2,R3,Beta,P];
        
        [~,y] = qam128(N_code,fc,fs,rs);
        y_n = process(h2,h2n,y,N_filter,snr);
        [r_max,E,m_A,sigma_aa,sigma_ap,sigma_dp,sigma_af,P_max]=inst_fe(y_n,fc,fs,rs);
        [d_1,d_2,d_3,d_4,d_5,d_6,d_7]=hoc_fe(y_n,fc,fs);
        [E1,E2,E3,E4,E5]=wt_fe(y_n);
        [R1,R2,R3,Beta,P]=csd_fe(y_n,fs,fc);
        mode12((snr-snr_min)*N_samples+i,:)=[r_max,E,m_A,sigma_aa,sigma_ap,sigma_dp,sigma_af,...
            P_max,d_1,d_2,d_3,d_4,d_5,d_6,d_7,E1,E2,E3,E4,E5,R1,R2,R3,Beta,P];
        
        [~,y] = qam256(N_code,fc,fs,rs);
        y_n = process(h2,h2n,y,N_filter,snr);
        [r_max,E,m_A,sigma_aa,sigma_ap,sigma_dp,sigma_af,P_max]=inst_fe(y_n,fc,fs,rs);
        [d_1,d_2,d_3,d_4,d_5,d_6,d_7]=hoc_fe(y_n,fc,fs);
        [E1,E2,E3,E4,E5]=wt_fe(y_n);
        [R1,R2,R3,Beta,P]=csd_fe(y_n,fs,fc);
        mode13((snr-snr_min)*N_samples+i,:)=[r_max,E,m_A,sigma_aa,sigma_ap,sigma_dp,sigma_af,...
            P_max,d_1,d_2,d_3,d_4,d_5,d_6,d_7,E1,E2,E3,E4,E5,R1,R2,R3,Beta,P];
        
        [~,y] = msk(N_code,fc,fs,rs);
        y_n = process(h3,h3n,y,N_filter,snr);
        [r_max,E,m_A,sigma_aa,sigma_ap,sigma_dp,sigma_af,P_max]=inst_fe(y_n,fc,fs,rs);
        [d_1,d_2,d_3,d_4,d_5,d_6,d_7]=hoc_fe(y_n,fc,fs);
        [E1,E2,E3,E4,E5]=wt_fe(y_n);
        [R1,R2,R3,Beta,P]=csd_fe(y_n,fs,fc);
        mode14((snr-snr_min)*N_samples+i,:)=[r_max,E,m_A,sigma_aa,sigma_ap,sigma_dp,sigma_af,...
            P_max,d_1,d_2,d_3,d_4,d_5,d_6,d_7,E1,E2,E3,E4,E5,R1,R2,R3,Beta,P];
        
        [~,y] = gmsk(N_code,fc,fs,rs);
        y_n = process(h3,h3n,y,N_filter,snr);
        [r_max,E,m_A,sigma_aa,sigma_ap,sigma_dp,sigma_af,P_max]=inst_fe(y_n,fc,fs,rs);
        [d_1,d_2,d_3,d_4,d_5,d_6,d_7]=hoc_fe(y_n,fc,fs);
        [E1,E2,E3,E4,E5]=wt_fe(y_n);
        [R1,R2,R3,Beta,P]=csd_fe(y_n,fs,fc);
        mode15((snr-snr_min)*N_samples+i,:)=[r_max,E,m_A,sigma_aa,sigma_ap,sigma_dp,sigma_af,...
            P_max,d_1,d_2,d_3,d_4,d_5,d_6,d_7,E1,E2,E3,E4,E5,R1,R2,R3,Beta,P];
        


    end
end
toc;
save ../dataset/data_fe_15 mode1 mode2 mode3 mode4 mode5 mode6 mode7 mode8 mode9 mode10 ...
    mode11 mode12 mode13 mode14 mode15 snr_min snr_max N_code N_samples
    