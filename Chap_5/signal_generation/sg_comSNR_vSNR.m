%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%�����ź����ɣ�SNR��Χ����save��%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
close all;
clear all;
clc;

warning off
%% ����������
fc = 70;              %�ز�Ƶ��
fs = 200;             %����Ƶ�� 
rs = 2;               %��������
N_code = 100;           %��������
N_filter = 200;       %�˲�������
length = 8000;  %Final length of signals
N_samples_m = 20000;    %Number of overlapped samples
num_classes = 8;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Ac_max = 1.1;
Ac_min = 0.9;

fc_max = 72;
fc_min = 68;

max_targets = 2;
min_targets = 2;

max_shift = fs*N_code/rs - length;

fprintf('Generating overlapped samples...\nMax_target = %d\n', max_targets);

for snr1 = 0:2:20
snr_min = snr1;
snr_max = snr1;
    
x_train = zeros(length,N_samples_m);
y_train = zeros(num_classes,N_samples_m);



idx_tar = randi([min_targets, max_targets], 1, N_samples_m);
for i=1:N_samples_m
    if mod(i, 1000) == 0
        fprintf('Current SNR = %d dB',snr);
        fprintf('   itr=%d\n',i);
    end
    class_i = randperm(num_classes);
    class_i = class_i(1:idx_tar(i));

    fcc = unifrnd (fc_min, fc_max,size(class_i,2),1);
    Acc = unifrnd (Ac_min, Ac_max,size(class_i,2),1);
    shift = randi (max_shift-1,size(class_i,2),1);                y_train(class_i(j),i)=1;
                fcb(j,:) = [fcc(j)-1.2*2.25*rs,fcc(j)+1.2*2.25*rs];
        end
    end
    fcb = zeros(idx_tar(i),2);
    y = zeros(idx_tar(i), length);
    for j =1:size(class_i,2)
        switch class_i(j)
            case 1
                [~,yr] = ask2(N_code,fcc(j),fs,rs);
                [~,yr] = fir_filter(fs,N_filter,fcc(j)-2*rs,fcc(j)+2*rs,yr);
                y(j,:) = yr(1, shift(j):shift(j)+length-1)/sig_e(yr(1, shift(j):shift(j)+length-1))*Acc(j);
                y_train(class_i(j),i)=1;
                fcb(j,:) = [fcc(j)-1.2*2*rs,fcc(j)+1.2*2*rs];
            case 2
                [~,yr] = fsk2(N_code,fcc(j),fs,rs);
                [~,yr] = fir_filter(fs,N_filter,fcc(j)-4*rs,fcc(j)+4*rs,yr);
                y(j,:) = yr(1, shift(j):shift(j)+length-1)/sig_e(yr(1, shift(j):shift(j)+length-1))*Acc(j);
                y_train(class_i(j),i)=1;
                fcb(j,:) = [fcc(j)-1.2*4*rs,fcc(j)+1.2*4*rs];
            case 3
                [~,yr] = fsk4(N_code,fcc(j),fs,rs);
                [~,yr] = fir_filter(fs,N_filter,fcc(j)-4*rs,fcc(j)+4*rs,yr);
                y(j,:) = yr(1, shift(j):shift(j)+length-1)/sig_e(yr(1, shift(j):shift(j)+length-1))*Acc(j);
                y_train(class_i(j),i)=1;
                fcb(j,:) = [fcc(j)-1.2*4*rs,fcc(j)+1.2*4*rs];
            case 4
                [~,yr] = psk2(N_code,fcc(j),fs,rs);
                [~,yr] = fir_filter(fs,N_filter,fcc(j)-4*rs,fcc(j)+4*rs,yr);
                y(j,:) = yr(1, shift(j):shift(j)+length-1)/sig_e(yr(1, shift(j):shift(j)+length-1))*Acc(j);
                y_train(class_i(j),i)=1;
                fcb(j,:) = [fcc(j)-1.2*4*rs,fcc(j)+1.2*4*rs];
            case 5
                [~,yr] = psk4(N_code,fcc(j),fs,rs);
                [~,yr] = fir_filter(fs,N_filter,fcc(j)-4*rs,fcc(j)+4*rs,yr);
                y(j,:) = yr(1, shift(j):shift(j)+length-1)/sig_e(yr(1, shift(j):shift(j)+length-1))*Acc(j);
                y_train(class_i(j),i)=1;
                fcb(j,:) = [fcc(j)-1.2*4*rs,fcc(j)+1.2*4*rs];
            case 6
                [~,yr] = qam16(N_code,fcc(j),fs,rs);
                [~,yr] = fir_filter(fs,N_filter,fcc(j)-4*rs,fcc(j)+4*rs,yr);
                y(j,:) = yr(1, shift(j):shift(j)+length-1)/sig_e(yr(1, shift(j):shift(j)+length-1))*Acc(j);
                y_train(class_i(j),i)=1;
                fcb(j,:) = [fcc(j)-1.2*4*rs,fcc(j)+1.2*4*rs];
            case 7
                [~,yr] = qam64(N_code,fcc(j),fs,rs);
                [~,yr] = fir_filter(fs,N_filter,fcc(j)-4*rs,fcc(j)+4*rs,yr);
                y(j,:) = yr(1, shift(j):shift(j)+length-1)/sig_e(yr(1, shift(j):shift(j)+length-1))*Acc(j);
                y_train(class_i(j),i)=1;
                fcb(j,:) = [fcc(j)-1.2*4*rs,fcc(j)+1.2*4*rs];
            case 8
                [~,yr] = msk(N_code,fcc(j),fs,rs);
                [~,yr] = fir_filter(fs,N_filter,fcc(j)-2.25*rs,fcc(j)+2.25*rs,yr);
                y(j,:) = yr(1, shift(j):shift(j)+length-1)/sig_e(yr(1, shift(j):shift(j)+length-1))*Acc(j);

    y_r = sum(y, 1)/sqrt(sig_e(sum(y, 1)));
    snr = randi([snr_min, snr_max],1);
    bl1 = min(min(fcb));
    bl2 = max(max(fcb));
    
    x_train(:,i) = awgn_bl(fs,N_filter,bl1,bl2,y_r,snr)';

end

Ac = [Ac_min, Ac_max];
snr = [snr_min, snr_max];
fc = [fc_min, fc_max];
fprintf('Saving...\n');
save(strcat('../samples/te_2/te_',num2str(snr1)),'x_train','y_train','Ac', 'fc','snr','length','-v7.3')
end