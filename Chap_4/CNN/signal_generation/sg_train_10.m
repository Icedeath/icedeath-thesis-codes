%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%CNN�ź���ɣ�ѵ������?%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
close all;
clear all;
clc;

warning off
%% ����������
fc = 70;              %�ز�Ƶ��
fs = 200;             %����Ƶ�� 
rs = 2;               %�������?
N_code = 200;           %�������?
N_filter = 200;       %�˲�������
length = 14000;  %Final length of signals
N_samples_m = 3000;    %Number of overlapped samples
num_classes = 10;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
snr_min = 0;
snr_max = 20;

min_targets = 1;
max_targets = 1;

max_shift = fs*N_code/rs - length;

fprintf('Generating training samples...\n');
Rsym = rs;                % Input symbol rate
Rbit = Rsym;
% Rbit = Rsym * log2(M);      % Input bit rate
Nos = fs/rs;                    % Oversampling factor
ts = (1/Rbit) / Nos/3;        % Input sample period
chan = stdchan(ts, 0, 'cost207RAx6');

x_train = zeros(length,N_samples_m);
y_train = zeros(num_classes,N_samples_m);

tic;

idx_tar = randi([min_targets, max_targets], 1, N_samples_m);
for i=1:N_samples_m
    if mod(i, 2000) == 0
        fprintf('Current SNR = %d dB',snr);
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
                yr=real(filter(chan,yr));
                [~,yr] = fir_filter(fs,N_filter,fc-2*rs,fc+2*rs,yr);
                y(j,:) = yr(1, shift(j):shift(j)+length-1);
                y_train(class_i(j),i)=1;
                fcb(j,:) = [fc-1.2*2*rs,fc+1.2*2*rs];
            case 2
                [~,yr] = ask4(N_code,fc,fs,rs);
                yr=real(filter(chan,yr));
                [~,yr] = fir_filter(fs,N_filter,fc-2*rs,fc+2*rs,yr);
                y(j,:) = yr(1, shift(j):shift(j)+length-1);
                y_train(class_i(j),i)=1;
                fcb(j,:) = [fc-1.2*2*rs,fc+1.2*2*rs];
            case 3
                [~,yr] = ask8(N_code,fc,fs,rs);
                yr=real(filter(chan,yr));
                [~,yr] = fir_filter(fs,N_filter,fc-2*rs,fc+2*rs,yr);
                y(j,:) = yr(1, shift(j):shift(j)+length-1);
                y_train(class_i(j),i)=1;
                fcb(j,:) = [fc-1.2*2*rs,fc+1.2*2*rs];
            case 4
                [~,yr] = fsk2(N_code,fc,fs,rs);
                yr=real(filter(chan,yr));
                [~,yr] = fir_filter(fs,N_filter,fc-4*rs,fc+4*rs,yr);
                y(j,:) = yr(1, shift(j):shift(j)+length-1);
                y_train(class_i(j),i)=1;
                fcb(j,:) = [fc-1.2*4*rs,fc+1.2*4*rs];
            case 5
                [~,yr] = fsk4(N_code,fc,fs,rs);
                yr=real(filter(chan,yr));
                [~,yr] = fir_filter(fs,N_filter,fc-4*rs,fc+4*rs,yr);
                y(j,:) = yr(1, shift(j):shift(j)+length-1);
                y_train(class_i(j),i)=1;
                fcb(j,:) = [fc-1.2*4*rs,fc+1.2*4*rs];
            case 6
                [~,yr] = fsk8(N_code,fc,fs,rs);
                yr=real(filter(chan,yr));
                [~,yr] = fir_filter(fs,N_filter,fc-4*rs,fc+4*rs,yr);
                y(j,:) = yr(1, shift(j):shift(j)+length-1);
                y_train(class_i(j),i)=1;
                fcb(j,:) = [fc-1.2*4*rs,fc+1.2*4*rs];
            case 7
                [~,yr] = psk2(N_code,fc,fs,rs);
                yr=real(filter(chan,yr));
                [~,yr] = fir_filter(fs,N_filter,fc-4*rs,fc+4*rs,yr);
                y(j,:) = yr(1, shift(j):shift(j)+length-1);
                y_train(class_i(j),i)=1;
                fcb(j,:) = [fc-1.2*4*rs,fc+1.2*4*rs];
            case 8
                [~,yr] = psk4(N_code,fc,fs,rs);
                yr=real(filter(chan,yr));
                [~,yr] = fir_filter(fs,N_filter,fc-4*rs,fc+4*rs,yr);
                y(j,:) = yr(1, shift(j):shift(j)+length-1);
                y_train(class_i(j),i)=1;
                fcb(j,:) = [fc-1.2*4*rs,fc+1.2*4*rs];
             case 9
                [~,yr] = psk8(N_code,fc,fs,rs);
                yr=real(filter(chan,yr));
                [~,yr] = fir_filter(fs,N_filter,fc-4*rs,fc+4*rs,yr);
                y(j,:) = yr(1, shift(j):shift(j)+length-1);
                y_train(class_i(j),i)=1;
                fcb(j,:) = [fc-1.2*4*rs,fc+1.2*4*rs];
            case 10
                [~,yr] = qam16(N_code,fc,fs,rs);
                yr=real(filter(chan,yr));
                [~,yr] = fir_filter(fs,N_filter,fc-4*rs,fc+4*rs,yr);
                y(j,:) = yr(1, shift(j):shift(j)+length-1);
                y_train(class_i(j),i)=1;
                fcb(j,:) = [fc-1.2*4*rs,fc+1.2*4*rs];
%             case 11
%                 [~,yr] = qam64(N_code,fc,fs,rs);
%                 [~,yr] = fir_filter(fs,N_filter,fc-4*rs,fc+4*rs,yr);
%                 y(j,:) = yr(1, shift(j):shift(j)+length-1);
%                 y_train(class_i(j),i)=1;
%                 fcb(j,:) = [fc-1.2*4*rs,fc+1.2*4*rs];
%             case 12
%                 [~,yr] = qam128(N_code,fc,fs,rs);
%                 [~,yr] = fir_filter(fs,N_filter,fc-4*rs,fc+4*rs,yr);
%                 y(j,:) = yr(1, shift(j):shift(j)+length-1);
%                 y_train(class_i(j),i)=1;
%                 fcb(j,:) = [fc-1.2*4*rs,fc+1.2*4*rs];
%             case 13
%                 [~,yr] = qam256(N_code,fc,fs,rs);
%                 [~,yr] = fir_filter(fs,N_filter,fc-4*rs,fc+4*rs,yr);
%                 y(j,:) = yr(1, shift(j):shift(j)+length-1);
%                 y_train(class_i(j),i)=1;
%                 fcb(j,:) = [fc-1.2*4*rs,fc+1.2*4*rs];
%             case 14
%                 [~,yr] = msk(N_code,fc,fs,rs);
%                 [~,yr] = fir_filter(fs,N_filter,fc-2.25*rs,fc+2.25*rs,yr);
%                 y(j,:) = yr(1, shift(j):shift(j)+length-1);
%                 y_train(class_i(j),i)=1;
%                 fcb(j,:) = [fc-1.2*2.25*rs,fc+1.2*2.25*rs];
%             case 15
%                 [~,yr] = gmsk(N_code,fc,fs,rs);
%                 [~,yr] = fir_filter(fs,N_filter,fc-2.25*rs,fc+2.25*rs,yr);
%                 y(j,:) = yr(1, shift(j):shift(j)+length-1);
%                 y_train(class_i(j),i)=1;
%                 fcb(j,:) = [fc-1.2*2.25*rs,fc+1.2*2.25*rs];
        end
    end

    snr = randi([snr_min, snr_max],1);
    bl1 = min(min(fcb));
    bl2 = max(max(fcb));
    
    x_train(:,i) = awgn_bl(fs,N_filter,bl1,bl2,y,snr)';
end

snr = [snr_min, snr_max];

fprintf('Saving...\n');
save('../samples/data_10','x_train','y_train','snr','length','-v7.3')
toc;
