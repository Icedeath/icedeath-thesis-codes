% 连续相位FSK2，无成型滤波 ，调制指数≠0.5（等于0.5用MSK函数）
function y=cpfsk2(N_code,fc,fs,fd,freqsep)
M=2;
xsym = randi([0 M-1],N_code,1); %消息信号
N_sample=fs/fd;
mod = comm.CPFSKModulator('ModulationOrder', M, ...
                          'ModulationIndex', freqsep/fd, ...
                          'SamplesPerSymbol', N_sample);
meanM = mean(0:M-1);
syms = mod(2*(xsym-meanM));
pfo = comm.PhaseFrequencyOffset('SampleRate', fs,'FrequencyOffset',fc);%加载波
ytemp = pfo(syms);
y = real(ytemp.');