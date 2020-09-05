%%%%%%%%%%%%%%%%%%%%%%%%%%%特征方差统计%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all
clc 
close all

addpath(genpath('./'))
%% 参数设置区
fc = 70;              %载波频率
fs = 400;             %采样频率 
rs = 2;               %符号速率
N_code = 1000;           %符号数量
N_filter = 200;      %滤波器阶数
snr_min = 0;         %信噪比范围
snr_max = 20;         
N_samples = 200;     %每个SNR下样本数量
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
fe1=[];
fe2=[];
fe3=[];
fe4=[];
fe5=[];
fe6=[];
fe7=[];
fe8=[];

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
        mode1((snr-snr_min)*N_samples+i,:)=[r_max,E,m_A,sigma_aa,sigma_ap,sigma_dp,sigma_af,...
            P_max,d_1,d_2,d_3,d_4,d_5,d_6,d_7,E1,E2,E3,E4,E5,R1,R2,R3,Beta,P];
        
        [~,y] = fsk2(N_code,fc,fs,rs);
        y_n = process(h2,h2n,y,N_filter,snr);
        [r_max,E,m_A,sigma_aa,sigma_ap,sigma_dp,sigma_af,P_max]=inst_fe(y_n,fc,fs,rs);
        [d_1,d_2,d_3,d_4,d_5,d_6,d_7]=hoc_fe(y_n,fc,fs);
        [E1,E2,E3,E4,E5]=wt_fe(y_n);
        [R1,R2,R3,Beta,P]=csd_fe(y_n,fs,fc);
        mode2((snr-snr_min)*N_samples+i,:)=[r_max,E,m_A,sigma_aa,sigma_ap,sigma_dp,sigma_af,...
            P_max,d_1,d_2,d_3,d_4,d_5,d_6,d_7,E1,E2,E3,E4,E5,R1,R2,R3,Beta,P];  
        
        [~,y] = fsk4(N_code,fc,fs,rs);
        y_n = process(h2,h2n,y,N_filter,snr);
        [r_max,E,m_A,sigma_aa,sigma_ap,sigma_dp,sigma_af,P_max]=inst_fe(y_n,fc,fs,rs);
        [d_1,d_2,d_3,d_4,d_5,d_6,d_7]=hoc_fe(y_n,fc,fs);
        [E1,E2,E3,E4,E5]=wt_fe(y_n);
        [R1,R2,R3,Beta,P]=csd_fe(y_n,fs,fc);
        mode3((snr-snr_min)*N_samples+i,:)=[r_max,E,m_A,sigma_aa,sigma_ap,sigma_dp,sigma_af,...
            P_max,d_1,d_2,d_3,d_4,d_5,d_6,d_7,E1,E2,E3,E4,E5,R1,R2,R3,Beta,P];
        
        [~,y] = fsk8(N_code,fc,fs,rs);
        y_n = process(h2,h2n,y,N_filter,snr);
        [r_max,E,m_A,sigma_aa,sigma_ap,sigma_dp,sigma_af,P_max]=inst_fe(y_n,fc,fs,rs);
        [d_1,d_2,d_3,d_4,d_5,d_6,d_7]=hoc_fe(y_n,fc,fs);
        [E1,E2,E3,E4,E5]=wt_fe(y_n);
        [R1,R2,R3,Beta,P]=csd_fe(y_n,fs,fc);
        mode4((snr-snr_min)*N_samples+i,:)=[r_max,E,m_A,sigma_aa,sigma_ap,sigma_dp,sigma_af,...
            P_max,d_1,d_2,d_3,d_4,d_5,d_6,d_7,E1,E2,E3,E4,E5,R1,R2,R3,Beta,P];
        
        [~,y] = psk2(N_code,fc,fs,rs);
        y_n = process(h2,h2n,y,N_filter,snr);
        [r_max,E,m_A,sigma_aa,sigma_ap,sigma_dp,sigma_af,P_max]=inst_fe(y_n,fc,fs,rs);
        [d_1,d_2,d_3,d_4,d_5,d_6,d_7]=hoc_fe(y_n,fc,fs);
        [E1,E2,E3,E4,E5]=wt_fe(y_n);
        [R1,R2,R3,Beta,P]=csd_fe(y_n,fs,fc);
        mode5((snr-snr_min)*N_samples+i,:)=[r_max,E,m_A,sigma_aa,sigma_ap,sigma_dp,sigma_af,...
            P_max,d_1,d_2,d_3,d_4,d_5,d_6,d_7,E1,E2,E3,E4,E5,R1,R2,R3,Beta,P];
        
        [~,y] = psk4(N_code,fc,fs,rs);
        y_n = process(h2,h2n,y,N_filter,snr);
        [r_max,E,m_A,sigma_aa,sigma_ap,sigma_dp,sigma_af,P_max]=inst_fe(y_n,fc,fs,rs);
        [d_1,d_2,d_3,d_4,d_5,d_6,d_7]=hoc_fe(y_n,fc,fs);
        [E1,E2,E3,E4,E5]=wt_fe(y_n);
        [R1,R2,R3,Beta,P]=csd_fe(y_n,fs,fc);
        mode6((snr-snr_min)*N_samples+i,:)=[r_max,E,m_A,sigma_aa,sigma_ap,sigma_dp,sigma_af,...
            P_max,d_1,d_2,d_3,d_4,d_5,d_6,d_7,E1,E2,E3,E4,E5,R1,R2,R3,Beta,P];
        
        [~,y] = psk8(N_code,fc,fs,rs);
        y_n = process(h2,h2n,y,N_filter,snr);
        [r_max,E,m_A,sigma_aa,sigma_ap,sigma_dp,sigma_af,P_max]=inst_fe(y_n,fc,fs,rs);
        [d_1,d_2,d_3,d_4,d_5,d_6,d_7]=hoc_fe(y_n,fc,fs);
        [E1,E2,E3,E4,E5]=wt_fe(y_n);
        [R1,R2,R3,Beta,P]=csd_fe(y_n,fs,fc);
        mode7((snr-snr_min)*N_samples+i,:)=[r_max,E,m_A,sigma_aa,sigma_ap,sigma_dp,sigma_af,...
            P_max,d_1,d_2,d_3,d_4,d_5,d_6,d_7,E1,E2,E3,E4,E5,R1,R2,R3,Beta,P];
        
        [~,y] = qam16(N_code,fc,fs,rs);
        y_n = process(h2,h2n,y,N_filter,snr);
        [r_max,E,m_A,sigma_aa,sigma_ap,sigma_dp,sigma_af,P_max]=inst_fe(y_n,fc,fs,rs);
        [d_1,d_2,d_3,d_4,d_5,d_6,d_7]=hoc_fe(y_n,fc,fs);
        [E1,E2,E3,E4,E5]=wt_fe(y_n);
        [R1,R2,R3,Beta,P]=csd_fe(y_n,fs,fc);
        mode8((snr-snr_min)*N_samples+i,:)=[r_max,E,m_A,sigma_aa,sigma_ap,sigma_dp,sigma_af,...
            P_max,d_1,d_2,d_3,d_4,d_5,d_6,d_7,E1,E2,E3,E4,E5,R1,R2,R3,Beta,P];
    end
end

save data_fe mode1 mode2 mode3 mode4 mode5 mode6 mode7 mode8
% fe1 = zeros(1,num_fe);
% fe2 = zeros(1,num_fe);
% fe3 = zeros(1,num_fe);
% fe4 = zeros(1,num_fe);
% fe5 = zeros(1,num_fe);
% fe6 = zeros(1,num_fe);
% fe7 = zeros(1,num_fe);
% fe8 = zeros(1,num_fe);
% for j = 1:num_fe
%     mean_fe1 = mean(mode1(:,j));
%     mode1(:,j) = mode1(:,j)/mean_fe1-1;
%     fe1(:,j)=var(mode1(:,j))/size(mode1,1);
%     
%     mean_fe2 = mean(mode2(:,j));
%     mode2(:,j) = mode2(:,j)/mean_fe1-1;
%     fe2(:,j)=var(mode2(:,j))/size(mode2,1);
% 
%     mean_fe3 = mean(mode3(:,j));
%     mode3(:,j) = mode3(:,j)/mean_fe3-1;
%     fe3(:,j)=var(mode3(:,j))/size(mode3,1);
% 
%     mean_fe4 = mean(mode4(:,j));
%     mode4(:,j) = mode4(:,j)/mean_fe4-1;
%     fe4(:,j)=var(mode4(:,j))/size(mode4,1);
%     
%     mean_fe5 = mean(mode5(:,j));
%     mode5(:,j) = mode5(:,j)/mean_fe5-1;
%     fe5(:,j)=var(mode5(:,j))/size(mode5,1);
%     
%     mean_fe6 = mean(mode6(:,j));
%     mode6(:,j) = mode6(:,j)/mean_fe6-1;
%     fe6(:,j)=var(mode6(:,j))/size(mode6,1);
%     
%     mean_fe7 = mean(mode7(:,j));
%     mode7(:,j) = mode7(:,j)/mean_fe7-1;
%     fe7(:,j)=var(mode7(:,j))/size(mode7,1);
%     
%     mean_fe8 = mean(mode8(:,j));
%     mode8(:,j) = mode8(:,j)/mean_fe8-1;
%     fe8(:,j)=var(mode8(:,j))/size(mode8,1);
% end
% 
% fe = (fe1 + fe2 + fe3 + fe4 + fe5 + fe6 + fe7 + fe8)/8;
    