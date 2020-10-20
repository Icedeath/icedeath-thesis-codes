%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%CNN信号生成（固定SNR循环）%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
close all;
clear all;
clc;

warning off
%% 参数设置区
fc = 70;              %载波频率
fs = 200;             %采样频率 
rs = 2;               %符号速率
N_code = 100;           %符号数量
N_filter = 200;       %滤波器阶数
length = 8000;  %Final length of signals
N_samples_m = 20000;    %Number of overlapped samples
num_classes = 8;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
snr_min = 0;
snr_max = 20;

min_targets = 1;
max_targets = 1;

max_shift = fs*N_code/rs - length;

fprintf('Generating training samples...\n');

for snr1 = 20:20:20
snr_min = snr1;
snr_max = snr1;

x_train = zeros(length,N_samples_m);
y_train = zeros(num_classes,N_samples_m);



idx_tar = randi([min_targets, max_targets], 1, N_samples_m);
for i=1:N_samples_m
    if mod(i, 2000) == 0
        fprintf('Current SNR = %d dB',snr1);
        fprintf('   itr=%d\n',i);
    end
    class_i = randperm(num_classes);
    class_i = class_i(1:idx_tar(i));
    fcb = zeros(idx_tar(i),2);
    shift = randi (max_shift-1,size(class_i,2),1);
    y = zeros(idx_tar(i), length);

    for j =1:size(class_i,2)
        switch class_i(j)
            case 1
                [~,yr] = ask2(N_code,fc,fs,rs);
                [~,yr] = fir_filter(fs,N_filter,fc-2*rs,fc+2*rs,yr);
                y(j,:) = yr(1, shift(j):shift(j)+length-1);
                y_train(class_i(j),i)=1;
                fcb(j,:) = [fc-1.2*2*rs,fc+1.2*2*rs];
            case 2
                [~,yr] = fsk2(N_code,fc,fs,rs);
                [~,yr] = fir_filter(fs,N_filter,fc-4*rs,fc+4*rs,yr);
                y(j,:) = yr(1, shift(j):shift(j)+length-1);
                y_train(class_i(j),i)=1;
                fcb(j,:) = [fc-1.2*4*rs,fc+1.2*4*rs];
            case 3
                [~,yr] = fsk4(N_code,fc,fs,rs);
                [~,yr] = fir_filter(fs,N_filter,fc-4*rs,fc+4*rs,yr);
                y(j,:) = yr(1, shift(j):shift(j)+length-1);
                y_train(class_i(j),i)=1;
                fcb(j,:) = [fc-1.2*4*rs,fc+1.2*4*rs];
            case 4
                [~,yr] = psk2(N_code,fc,fs,rs);
                [~,yr] = fir_filter(fs,N_filter,fc-4*rs,fc+4*rs,yr);
                y(j,:) = yr(1, shift(j):shift(j)+length-1);
                y_train(class_i(j),i)=1;
                fcb(j,:) = [fc-1.2*4*rs,fc+1.2*4*rs];
            case 5
                [~,yr] = psk4(N_code,fc,fs,rs);
                [~,yr] = fir_filter(fs,N_filter,fc-4*rs,fc+4*rs,yr);
                y(j,:) = yr(1, shift(j):shift(j)+length-1);
                y_train(class_i(j),i)=1;
                fcb(j,:) = [fc-1.2*4*rs,fc+1.2*4*rs];
            case 6
                [~,yr] = qam16(N_code,fc,fs,rs);
                [~,yr] = fir_filter(fs,N_filter,fc-4*rs,fc+4*rs,yr);
                y(j,:) = yr(1, shift(j):shift(j)+length-1);
                y_train(class_i(j),i)=1;
                fcb(j,:) = [fc-1.2*4*rs,fc+1.2*4*rs];
            case 7
                [~,yr] = qam64(N_code,fc,fs,rs);
                [~,yr] = fir_filter(fs,N_filter,fc-4*rs,fc+4*rs,yr);
                y(j,:) = yr(1, shift(j):shift(j)+length-1);
                y_train(class_i(j),i)=1;
                fcb(j,:) = [fc-1.2*4*rs,fc+1.2*4*rs];
            case 8
                [~,yr] = msk(N_code,fc,fs,rs);
                [~,yr] = fir_filter(fs,N_filter,fc-4*rs,fc+4*rs,yr);
                y(j,:) = yr(1, shift(j):shift(j)+length-1);
                y_train(class_i(j),i)=1;
                fcb(j,:) = [fc-1.2*2.25*rs,fc+1.2*2.25*rs];
        end
    end

    snr = randi([snr_min, snr_max],1);
    bl1 = min(min(fcb));
    bl2 = max(max(fcb));
    
    x_train(:,i) = awgn_bl(fs,N_filter,bl1,bl2,y,snr)';
    %x_train(:,i) = awgn(y,snr,'measured','db')';
end

snr = [snr_min, snr_max];

fprintf('Saving...\n');
save(strcat('../samples/te82a_',num2str(snr1)),'x_train','y_train','snr','length','-v7.3')
end