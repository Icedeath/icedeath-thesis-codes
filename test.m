fc=6;
fs=1000;
freqsep=1;
fd=2;
Ac=1;
xsym = [0,1,1,0].';
M=2;
N_sample=fs/fd;
syms = pskmod(xsym,M); %基带调制,'PlotConstellation',true
% filterCoeffs = rcosdesign(0.35, 4, N_sample);%脉冲成形
t = 1/fs:1/fs:N_sample/fs; %符号持续时间向量
gt=ones(1,length(t));
tx_qam =syms*gt;
yf= reshape(tx_qam.',length(xsym)*length(t),1);
pfo = comm.PhaseFrequencyOffset('SampleRate', fs,'FrequencyOffset',fc);%加载波
ytemp = pfo(yf);
y = real(ytemp.');
figure (1)
plot(y);
