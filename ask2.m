% 升余弦成型滤波ASK2
function y=ask2(N_code,fc,fs,fd)
M=2;
xsym = randi([0 M-1],N_code,1); %消息信号
N_sample=fs/fd;
syms = xsym.*sqrt(2);
filterCoeffs = rcosdesign(0.35, 4, N_sample);%脉冲成形
yf = filter(filterCoeffs, 1, upsample(syms,N_sample));
pfo = comm.PhaseFrequencyOffset('SampleRate', fs,'FrequencyOffset',fc);%加载波
ytemp = pfo(yf); 
y = real(ytemp.');