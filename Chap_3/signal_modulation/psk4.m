function [m,y]=psk4(N_code,fc,fs,rs)
M=4;
m = randi([0 M-1],N_code,1); %消息信号
% m=[0:3]';
% N_code = 4;
N_s=fs/rs;
syms = pskmod(m,M); %基带调制
gt=ones(1,N_s);
tx_qam =syms*gt;
yf = reshape(tx_qam.',N_code*N_s,1);
pfo = comm.PhaseFrequencyOffset('SampleRate', fs,'FrequencyOffset',fc);%加载波
ytemp = pfo(yf);
y = real(ytemp.');

