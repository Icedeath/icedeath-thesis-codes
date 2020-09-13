%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%����ź�����%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
close all;
clear all;
clc;

warning off
%% ����������
fc = 70;              %�ز�Ƶ��
fs = 400;             %����Ƶ�� 
rs = 2;               %��������
N_code = 40;           %��������
N_filter = 200;       %�˲�������
length = 4000;  %Final length of signals
N_samples_m = 1;    %Number of overlapped samples
num_classes = 8;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
disp('Feature Exaction started...')
Ac_max = 1.1;
Ac_min = 0.9;

fc_max = 1.1*fc;
fc_min = 0.9*fc;

snr_min = 0;
snr_max = 20;

max_targets = 3;
min_targets = 3;

max_shift = fs*N_code/rs - length;

fprintf('Generating overlapped samples...\nMax_target = %d\n', max_targets);


x_train = zeros(N_samples_m, length);
y_train = zeros(N_samples_m, num_classes);



idx_tar = randi([min_targets, max_targets], 1, N_samples_m);
for i=1:N_samples_m
    if mod(i, 2000) == 0
        fprintf('Current SNR = %d dB',snr);
        fprintf('   itr=%d\n',i);
    end
    idx = [1:8,4,5,6,7];
    class_id = randperm(num_classes+4);
    class_i = idx(class_id)
    if size(unique(class_i(1:idx_tar(i))),2)==idx_tar(i)
        class_i = unique(class_i(1:idx_tar(i)))
    elseif size(unique(class_i(1:idx_tar(i)+1)),2)==idx_tar(i)
        class_i = unique(class_i(1:idx_tar(i)+1))
    elseif size(unique(class_i(1:idx_tar(i)+2)),2)==idx_tar(i)
        class_i = unique(class_i(1:idx_tar(i)+2))
    end

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
        [~,x_train(i,:)] = awgn_bl(fs,N_filter,min(fcc)-2.25*1.2*rs,max(fcc)+2.25*1.2*rs,y_r,snr);
    elseif isequal(y_train(i),[1 0 0 0 0 0 0 0])==1
        [~,x_train(i,:)] = awgn_bl(fs,N_filter,min(fcc)-2*1.2*rs,max(fcc)+2*1.2*rs,y_r,snr);
    elseif isequal(y_train(i),[0 0 0 0 0 0 0 1])==1  
        [~,x_train(i,:)] = awgn_bl(fs,N_filter,min(fcc)-2.25*1.2*rs,max(fcc)+2.25*1.2*rs,y_r,snr);
    else
        [~,x_train(i,:)] = awgn_bl(fs,N_filter,min(fcc)-4*1.2*rs,max(fcc)+4*1.2*rs,y_r,snr);
    end
end

Ac = [Ac_min, Ac_max];
snr = [snr_min, snr_max];
fc = [fc_min, fc_max];
fprintf('Saving...\n');
x_train = x_train';
y_train = y_train';
save('../samples/tr_2','x_train','y_train','Ac', 'fc','snr','length','-v7.3')