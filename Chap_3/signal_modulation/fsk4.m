function [m,y]=fsk4(N_code,fc,fs,rs)
M=4;
freqsep = 4/3*rs;%保证最大频差为4*Rs
m = randi([0 M-1],N_code,1); 
N_sample=fs/rs;
syms = fskmod(m,M,freqsep,N_sample,fs,'discont'); %基带调制
pfo = comm.PhaseFrequencyOffset('SampleRate', fs,'FrequencyOffset',fc);%加载波
ytemp = pfo(syms);
y = real(ytemp.');