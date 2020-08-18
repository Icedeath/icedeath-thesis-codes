% 升余弦成型滤波QAM64
function y=qam64(N_code,fc,fs,fd)
M=64;
xsym = randi([0 M-1],N_code,1); %消息信号
N_sample=fs/fd;
syms = qammod(xsym,M,'UnitAveragePower',true); %基带QAM调制,'PlotConstellation',true
filterCoeffs = rcosdesign(0.35, 4, N_sample);%脉冲成形
yf = filter(filterCoeffs, 1, upsample(syms,N_sample));
pfo = comm.PhaseFrequencyOffset('SampleRate', fs,'FrequencyOffset',fc);%加载波
ytemp = pfo(yf); 
y = real(ytemp.');
    

