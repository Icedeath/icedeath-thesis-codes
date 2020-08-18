%不连续相位的FSK4，无成型滤波
function y=fsk4(N_code,fc,fs,fd,freqsep)
M=4;
xsym = randi([0 M-1],N_code,1); %消息信号
N_sample=fs/fd;
syms = fskmod(xsym,M,freqsep,N_sample,fs,'discont'); %基带调制
pfo = comm.PhaseFrequencyOffset('SampleRate', fs,'FrequencyOffset',fc);%加载波
ytemp = pfo(syms);
y = real(ytemp.');