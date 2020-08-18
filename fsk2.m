%不连续相位的FSK2，无成型滤波
function y=fsk2(N_code,fc,fs,fd,freqsep)
M=2;
xsym = randi([0 M-1],N_code,1); %消息信号
N_sample=fs/fd;
syms = fskmod(xsym,M,freqsep,N_sample,fs,'discont'); %基带调制
pfo = comm.PhaseFrequencyOffset('SampleRate', fs,'FrequencyOffset',fc);%加载波
ytemp = pfo(syms);
y = real(ytemp.');

%%
%%
% 连续相位的FSK可以用fskmod(xsym,M,freqsep,N_sample,fs);
% 也可以用：
% mod = comm.CPFSKModulator('ModulationOrder', M, ...
%                           'ModulationIndex', freqsep/fd, ... 
%                           'SamplesPerSymbol', N_sample);
% 调制指数对应freqsep计算,mod.ModulationIndex=freqsep/fd;
% meanM = mean(0:M-1);
% syms = mod(2*(xsym-meanM));
% 或者：
% mod1 = comm.CPMModulator('ModulationOrder', M, ...
%                          'ModulationIndex', freqsep/fd, ... 
%                          'SamplesPerSymbol', N_sample);
% meanM = mean(0:M-1);
% syms = mod(2*(xsym-meanM));
%%
