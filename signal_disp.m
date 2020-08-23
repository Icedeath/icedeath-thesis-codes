clear all
clc
addpath signal_modulation
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%�����źŲ�������%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fc = 70;              %�ز�Ƶ��
fs = 400;             %����Ƶ�� 
rs = 2;               %��������
N_code = 200;         %��������
N_filter = 150;       %�˲�������
%%%%%%%%%%%%%%%%%%%%%%%%%%%�����źŲ����д����˲�%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[m,y] = qam16(N_code,fc,fs,rs);   %�޸ĵ��Ʒ�ʽ��Ӧ�ĺ��������������Ԫ�Ͷ�Ӧ�ĵ��Ʋ���

[h_ask,y_f] = fir_filter(fs,N_filter,fc-4*rs,fc+4*rs,y);   %����˲����������˲�

beta = sig_e(y_f)/sig_e(y);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%�������ͼ%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% figure()
% subplot(3,1,1)
% m=[m;m(end,1)];
% n = [0:N_code]+0.5;
% stairs(n,m,'LineWidth',2)
% xlabel('��Ԫ���')
% title('������Ԫ����')
% xlim([0.5,N_code+0.5])
% subplot(3,1,2)
% n = [1:fs/rs*N_code]/fs;
% plot(y);
% title('ʱ����')
% xlabel('ʱ��/ms')
% ylabel('��ֵ')
% subplot(3,1,3)
% spec(y,fs,rs,N_code);   %Ƶ��