function [m,y]=qam16(N_code,fc,fs,rs)
M=16;
m = randi([0 M-1],N_code,1); %��Ϣ�ź�
% m=[0:15]';
% N_code = 16;
N_s=fs/rs;
syms = qammod(m,M,'UnitAveragePower',true); %����QAM����,'PlotConstellation',true
gt=ones(1,N_s);
tx_qam =syms*gt;
yf = reshape(tx_qam.',N_code*N_s,1);
pfo = comm.PhaseFrequencyOffset('SampleRate', fs,'FrequencyOffset',fc);%���ز�
ytemp = pfo(yf); 
y = real(ytemp.');
% 
% scatterplot(syms)
% set(gca,'FontSize',10.5,'Fontname', 'Times New Roman');
% xlabel('\fontname{����}ͬ�����');
% ylabel('\fontname{����}��������');
% title('\fontname{Times New Roman}16QAM\fontname{����}�ź�����ͼ')
% grid on
