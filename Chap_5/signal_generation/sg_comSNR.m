%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%混叠信号生成%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
close all;
clear all;
clc;

warning off
%% 参数设置区
fc = 70;              %载波频率
fs = 400;             %采样频率 
rs = 2;               %符号速率
N_code = 40;           %符号数量
N_filter = 200;       %滤波器阶数
length = 7000;  %Final length of signals
N_samples_m = 10;    %Number of overlapped samples
num_classes = 8;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
disp('Feature Exaction started...')
Ac_max = 1.1;
Ac_min = 0.9;

fc_max = 68;
fc_min = 72;

snr_min = 0;
snr_max = 20;

max_targets = 2;
min_targets = 1;

max_shift = fs*N_code/rs - length;

fprintf('Generating overlapped samples...\nMax_target = %d\n', max_targets);

%for snr1 = 0:2:20
x_train = zeros(N_samples_m, length);
y_train = zeros(N_samples_m, num_classes);

%snr_max = snr1;
%snr_min = snr1;

idx_tar = randi([min_targets, max_targets], 1, N_samples_m);
for i=1:N_samples_m
    if mod(i, 2000) == 0
        fprintf('Current SNR = %d dB',snr);
        fprintf('   itr=%d\n',i);
    end
    class_i = randperm(num_classes);
    class_i = class_i(1:idx_tar(i));
    fcc = unifrnd (fc_min, fc_max,size(class_i,2),1);
    Acc = unifrnd (Ac_min, Ac_max,size(class_i,2),1);
    shift = randi (max_shift-1,size(class_i,2),1);
    y = zeros(idx_tar(i), length);
    for j =1:size(class_i,2)
        switch class_i(j)
            case 1
                [~,yr] = ask2(N_code,fcc(j),fs,rs);
                [~,yr] = fir_filter(fs,N_filter,fcc(j)-2*rs,fcc(j)+2*rs,yr);
                y(j,:) = yr(1, shift(j):shift(j)+length-1)/sig_e(yr(1, shift(j):shift(j)+length-1))*Acc(j);
                y_train(i, class_i(j))=1;
            case 2
                [~,yr] = fsk2(N_code,fcc(j),fs,rs);
                [~,yr] = fir_filter(fs,N_filter,fcc(j)-4*rs,fcc(j)+4*rs,yr);
                y(j,:) = yr(1, shift(j):shift(j)+length-1)/sig_e(yr(1, shift(j):shift(j)+length-1))*Acc(j);
                y_train(i, class_i(j))=1;
            case 3
                [~,yr] = fsk4(N_code,fcc(j),fs,rs);
                [~,yr] = fir_filter(fs,N_filter,fcc(j)-4*rs,fcc(j)+4*rs,yr);
                y(j,:) = yr(1, shift(j):shift(j)+length-1)/sig_e(yr(1, shift(j):shift(j)+length-1))*Acc(j);
                y_train(i, class_i(j))=1;
            case 4
                [~,yr] = psk2(N_code,fcc(j),fs,rs);
                [~,yr] = fir_filter(fs,N_filter,fcc(j)-4*rs,fcc(j)+4*rs,yr);
                y(j,:) = yr(1, shift(j):shift(j)+length-1)/sig_e(yr(1, shift(j):shift(j)+length-1))*Acc(j);
                y_train(i, class_i(j))=1;
            case 5
                [~,yr] = psk4(N_code,fcc(j),fs,rs);
                [~,yr] = fir_filter(fs,N_filter,fcc(j)-4*rs,fcc(j)+4*rs,yr);
                y(j,:) = yr(1, shift(j):shift(j)+length-1)/sig_e(yr(1, shift(j):shift(j)+length-1))*Acc(j);
                y_train(i, class_i(j))=1;
            case 6
                [~,yr] = qam16(N_code,fcc(j),fs,rs);
                [~,yr] = fir_filter(fs,N_filter,fcc(j)-4*rs,fcc(j)+4*rs,yr);
                y(j,:) = yr(1, shift(j):shift(j)+length-1)/sig_e(yr(1, shift(j):shift(j)+length-1))*Acc(j);
                y_train(i, class_i(j))=1;
            case 7
                [~,yr] = qam64(N_code,fcc(j),fs,rs);
                [~,yr] = fir_filter(fs,N_filter,fcc(j)-4*rs,fcc(j)+4*rs,yr);
                y(j,:) = yr(1, shift(j):shift(j)+length-1)/sig_e(yr(1, shift(j):shift(j)+length-1))*Acc(j);
                y_train(i, class_i(j))=1;
            case 8
                [~,yr] = msk(N_code,fcc(j),fs,rs);
                [~,yr] = fir_filter(fs,N_filter,fcc(j)-2.25*rs,fcc(j)+2.25*rs,yr);
                y(j,:) = yr(1, shift(j):shift(j)+length-1)/sig_e(yr(1, shift(j):shift(j)+length-1))*Acc(j);
                y_train(i, class_i(j))=1;
        end
    end
    y_r = sum(y, 1)/sqrt(sig_e(sum(y, 1)));
    snr = randi([snr_min, snr_max],1);
    if isequal(y_train(i),[1 0 0 0 0 0 0 1])==1
        x_train(i,:) = awgn_bl(fs,N_filter,min(fcc)-2.25*1.2*rs,max(fcc)+2.25*1.2*rs,y_r,snr);
    elseif isequal(y_train(i),[1 0 0 0 0 0 0 0])==1
        x_train(i,:) = awgn_bl(fs,N_filter,min(fcc)-2*1.2*rs,max(fcc)+2*1.2*rs,y_r,snr);
    elseif isequal(y_train(i),[0 0 0 0 0 0 0 1])==1  
        x_train(i,:) = awgn_bl(fs,N_filter,min(fcc)-2.25*1.2*rs,max(fcc)+2.25*1.2*rs,y_r,snr);
    else
        x_train(i,:) = awgn_bl(fs,N_filter,min(fcc)-4*1.2*rs,max(fcc)+4*1.2*rs,y_r,snr);
    end
end

Ac = [Ac_min, Ac_max];
snr = [snr_min, snr_max];
fc = [fc_min, fc_max];
fprintf('Saving...\n');
x_train = x_train';
y_train = y_train';
save('../samples/te_2_7000','x_train','y_train','Ac', 'fc','snr','length','-v7.3')
%end

% subplot(5,1,1)
% plot(y(1,:))
% subplot(5,1,2)
% plot(y(2,:))
% subplot(5,1,3)
% plot(y(3,:))
% subplot(5,1,4)
% plot(y_r)
% subplot(5,1,5)
% plot(x_train)