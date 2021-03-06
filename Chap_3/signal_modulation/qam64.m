function [m,y]=qam64(N_code,fc,fs,rs)
M=64;
m = randi([0 M-1],N_code,1); %消息信号
% m=[0:63]';
% N_code = 64;
N_s=fs/rs;
syms = qammod(m,M,'UnitAveragePower',true); %基带QAM调制,'PlotConstellation',true
gt=ones(1,N_s);
tx_qam =syms*gt;
yf = reshape(tx_qam.',N_code*N_s,1);
pfo = comm.PhaseFrequencyOffset('SampleRate', fs,'FrequencyOffset',fc);%加载波
ytemp = pfo(yf); 
y = real(ytemp.');


% scatterplot(syms)
% set(gca,'FontSize',10.5,'Fontname', 'Times New Roman');
% xlabel('\fontname{宋体}同相分量');
% ylabel('\fontname{宋体}正交分量');
% title('\fontname{Times New Roman}64QAM\fontname{宋体}信号星座图')
% grid on
