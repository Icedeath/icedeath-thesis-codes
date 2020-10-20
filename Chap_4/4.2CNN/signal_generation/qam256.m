function [m,y]=qam256(N_code,fc,fs,rs)
M=256;
m = randi([0 M-1],N_code,1); %��Ϣ�ź�
N_s=fs/rs;
syms = qammod(m,M,'UnitAveragePower',true); %����QAM����,'PlotConstellation',true
gt=ones(1,N_s);
tx_qam =syms*gt;
yf = reshape(tx_qam.',N_code*N_s,1);
pfo = comm.PhaseFrequencyOffset('SampleRate', fs,'FrequencyOffset',fc);%���ز�
ytemp = pfo(yf); 
y = real(ytemp.');

% scatterplot(syms)
% xlabel('ͬ�����');
% ylabel('��������');
% title('256QAM�ź�����ͼ')
% grid on
