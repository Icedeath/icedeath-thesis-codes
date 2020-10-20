% 高斯滤波的cpfsk2，调制指数≠0.5（等于0.5用GMSK函数）
function [m,y]=gcpfsk2(N_code,fc,fs,rs)
M=2;
m = randi([0 M-1],N_code,1); %消息信号
N_sample=fs/rs;
mod = comm.CPMModulator('ModulationOrder', M, ...
                        'PulseLength', 4, ...
                        'FrequencyPulse', 'Gaussian ', ...
                        'BandwidthTimeProduct', 0.35, ...
                        'ModulationIndex', 0.5, ...
                        'SamplesPerSymbol', N_sample);
meanM = mean(0:M-1);
syms = mod(2*(m-meanM));
pfo = comm.PhaseFrequencyOffset('SampleRate', fs,'FrequencyOffset',fc);%加载波
ytemp = pfo(syms);
y = real(ytemp.');