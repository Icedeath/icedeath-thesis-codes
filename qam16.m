% 升余弦成型滤波QAM16
function y=qam16(N_code,fc,fs,fd)
M=16;
xsym = randi([0 M-1],N_code,1); %消息信号
N_sample=fs/fd;
syms = qammod(xsym,M,'UnitAveragePower',true); %基带QAM调制,'PlotConstellation',true
filterCoeffs = rcosdesign(0.35, 4, N_sample);%脉冲成形
yf = filter(filterCoeffs, 1, upsample(syms,N_sample));
pfo = comm.PhaseFrequencyOffset('SampleRate', fs,'FrequencyOffset',fc);%加载波
ytemp = pfo(yf); 
y = real(ytemp.');





% fc=6;
% fs=1000;
% fd=2;
% Ac=1;
% xsym = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15];


% figure(2)
% plot(y);
% title("16QAM信号波形");
% xlabel("时间t");ylabel("载波振幅");
% scatterplot(y_1);
% title("16QAM信号星座图");
% xlabel("同相分量");ylabel("正交分量");