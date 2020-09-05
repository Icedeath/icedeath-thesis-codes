clear all
clc
addpath(genpath('./'))
%% ����������
fc = 70;              %�ز�Ƶ��
fs = 400;             %����Ƶ�� 
rs = 2;               %��������
N_code = 10;          %��������
N_filter = 2000;       %�˲�������
snr = 0;              %�����

%% ���ܺ���
%%%%%%%%%%%%%%%%%%%%%%%%%%%�����źţ��˲�����������%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[m,y] = ask2(N_code,fc,fs,rs);   %�޸ĵ��Ʒ�ʽ��Ӧ�ĺ��������������Ԫ�Ͷ�Ӧ�ĵ��Ʋ���

[h,y_f] = fir_filter(fs,N_filter,fc-2*rs,fc+2*rs,y);   %����˲����������˲�

[n_b,y_n] = awgn_bl(fs,N_filter,fc-2*1.2*rs,fc+2*1.2*rs,y_f,snr);  %������

% beta = sig_e(y_f)/sig_e(y) %�˲�����������

%% ��ͼ��
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%��Ԫ���У�ʱ���Σ�Ƶ��%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%�˲�����Ƶ����+�˲�����(��2��)%%%%%%%%%%%%%%%%%%%%%%
% figure()
% subplot(2,1,1)
% [h_f,w] = freqz(h,1);
% w = w*fs/2/pi;           %��һ��Ƶ��ת��Ϊʵ��Ƶ��
% h_f = 20*log10(abs(h_f));  %ת��ΪdB
% plot(w,h_f)
% grid on
% set(gca,'FontSize',10.5,'Fontname', 'Times New Roman');
% title('\fontname{����}�����˲�����Ƶ����\fontname{Times New Roman}(\itB_l=\rm8\itR_s\rm)')
% xlabel('\fontname{����}Ƶ��/\fontname{Times New Roman}MHz')
% ylabel('\fontname{����}������Ӧ\fontname{Times New Roman}(dB)')
% % xlim([0,fs/2])
% % ylim([-80,2])
% subplot(2,1,2)
% n = [1:fs/rs*N_code]/fs;
% plot(n,y_f);
% xlim([0,n(1,end)])
% set(gca,'FontSize',10.5,'Fontname', 'Times New Roman');
% title('\fontname{����}���޺�ʱ����')
% xlabel('\fontname{����}ʱ��\fontname{Times New Roman}/ms')
% ylabel('\fontname{����}��ֵ')

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%����ǰ�������Ա�(��2��)%%%%%%%%%%%%%%%%%%%%%%%%%%%
% figure()
% subplot(2,1,1)
% n = [1:fs/rs*N_code]/fs;
% plot(n,y_f);
% xlim([0,n(1,end)])
% set(gca,'FontSize',10.5,'Fontname', 'Times New Roman');
% title('\fontname{����}����\fontname{Times New Roman}16-QAM\fontname{����}�ź�ʱ����')
% xlabel('\fontname{����}ʱ��\fontname{Times New Roman}/ms')
% ylabel('\fontname{����}��ֵ')
% subplot(2,1,2)
% spec(y_f,fs,rs,N_code); 
% title('\fontname{����}����\fontname{Times New Roman}16-QAM\fontname{����}�ź�Ƶ��')
% 
% figure()
% subplot(2,1,1)
% n = [1:fs/rs*N_code]/fs;
% plot(n,y_n);
% xlim([0,n(1,end)])
% set(gca,'FontSize',10.5,'Fontname', 'Times New Roman');
% title('\fontname{����}��������\fontname{Times New Roman}16-QAM\fontname{����}�ź�ʱ����')
% xlabel('\fontname{����}ʱ��\fontname{Times New Roman}/ms')
% ylabel('\fontname{����}��ֵ')
% subplot(2,1,2)
% spec(y_n,fs,rs,N_code); 
% title('\fontname{����}��������\fontname{Times New Roman}16-QAM\fontname{����}�ź�Ƶ��')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%˲ʱ���ȣ���λ�Լ�Ƶ��%%%%%%%%%%%%%%%%%%%%%%%%%%%
% [a,phi_NL,f]=int_inf(y_f,fc,fs);
% figure()
% subplot(4,1,1)
% n = [1:fs/rs*N_code]/fs;
% plot(n,y_f);
% xlim([0,n(1,end)])
% set(gca,'FontSize',10.5,'Fontname', 'Times New Roman');
% ylabel('\fontname{����}ʱ����')
% xlabel('\fontname{����}ʱ��\fontname{Times New Roman}/ms')
% subplot(4,1,2)
% plot(n,a);
% xlim([0,n(1,end)])
% set(gca,'FontSize',10.5,'Fontname', 'Times New Roman');
% ylabel('\fontname{����}˲ʱ����')
% xlabel('\fontname{����}ʱ��\fontname{Times New Roman}/ms')
% grid on
% subplot(4,1,3)
% plot(n,phi_NL);
% ylabel('\fontname{����}˲ʱ��λ')
% xlabel('\fontname{����}ʱ��\fontname{Times New Roman}/ms')
% xlim([0,n(1,end)])
% grid on
% subplot(4,1,4)
% plot(n,f);
% ylabel('\fontname{����}˲ʱƵ��')
% xlabel('\fontname{����}ʱ��\fontname{Times New Roman}/ms')
% xlim([0,n(1,end)])
% %ylim([-6,6])
% grid on

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%����������%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%