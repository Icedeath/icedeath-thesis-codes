function [m,y]=qam64(N_code,fc,fs,rs)
M=64;
m = randi([0 M-1],N_code,1); %消息信号
N_s=fs/rs;
syms = qammod(m,M,'UnitAveragePower',true); %基带QAM调制,'PlotConstellation',true
gt=ones(1,N_s);
tx_qam =syms*gt;
yf = reshape(tx_qam.',N_code*N_s,1);
pfo = comm.PhaseFrequencyOffset('SampleRate', fs,'FrequencyOffset',fc);%加载波
ytemp = pfo(yf); 
y = real(ytemp.');

scatterplot(syms)
xlabel('同相分量');
ylabel('正交分量');
title('64QAM信号星座图')
grid on
