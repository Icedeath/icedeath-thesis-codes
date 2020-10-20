function [m,y]=gmsk(N_code,fc,fs,fd)
M=2;
m = randi([0 M-1],N_code,1); %消息信号
N_sample=fs/fd;
mod = comm.GMSKModulator('PulseLength',4, ...
                         'BandwidthTimeProduct', 0.35, ...
                         'SamplesPerSymbol',N_sample);
meanM = mean(0:M-1);
syms = mod(2*(m-meanM));
pfo = comm.PhaseFrequencyOffset('SampleRate', fs,'FrequencyOffset',fc);%加载波
ytemp = pfo(syms);
y = real(ytemp.');