% MSK，无成型滤波
function y=msk(N_code,fs,fd,fc)
M=2;
N_samples=fs/fd;    
xsym = randi([0 M-1],N_code,1); %消息信号
syms = mskmod(xsym,N_samples,[],0);%MSK基带复包络
pfo = comm.PhaseFrequencyOffset('SampleRate', fs,'FrequencyOffset',fc);%加载波
ytemp = pfo(syms);
y = real(ytemp.');

%%
%%
% 以下几个等价，都是MSK
% MSK=连续相位的2FSK+两个载波频率之间的间隔为1/2码元速率，
% MSK可以看成是调制指数为0.5的一种CPFSK信号.
% M=2;
% fc=6;
% fs=1000;
% fd=2;
% freqsep=fd/2; % 载波频率之间的间隔为1/2码元速率
% xsym = [0,1,1,1,0,1,0,1].';%randi([0 M-1],N_code,1); %消息信号
% N_sample=fs/fd;
% mod = comm.CPFSKModulator('ModulationOrder', M, ...
%                           'ModulationIndex', 0.5, ...
%                           'SamplesPerSymbol', N_sample);
% meanM = mean(0:M-1);
% syms = mod(2*(xsym-meanM)); % 输入值的范围和mskmod不一样，在[-1,1]
% pfo = comm.PhaseFrequencyOffset('SampleRate', fs,'FrequencyOffset',fc);%加载波
% ytemp = pfo(syms);
% y = real(ytemp.');
% plot(y);
% hold on;
% mod1 = comm.CPMModulator('ModulationOrder', M, ...
%                         'ModulationIndex', 0.5, ...
%                         'SamplesPerSymbol', N_sample);
% syms1 = mod1(2*(xsym-meanM));
% ytemp1 = pfo(syms1);
% y1 = real(ytemp1.');
% plot(y1);
% hold on;
% syms2 = mskmod(xsym,N_sample,[],0);%MSK基带复包络
% ytemp2 = pfo(syms2);
% y2 = real(ytemp2.');
% plot(y2);
% hold on;
% syms3 = fskmod(xsym,M,freqsep,N_sample,fs); %基带调制
% ytemp3 = pfo(syms3);
% y3 = real(ytemp3.');
% plot(y3);
%%
