% �����ҳ����˲�QAM64
function y=qam64(N_code,fc,fs,fd)
M=64;
xsym = randi([0 M-1],N_code,1); %��Ϣ�ź�
N_sample=fs/fd;
syms = qammod(xsym,M,'UnitAveragePower',true); %����QAM����,'PlotConstellation',true
filterCoeffs = rcosdesign(0.35, 4, N_sample);%�������
yf = filter(filterCoeffs, 1, upsample(syms,N_sample));
pfo = comm.PhaseFrequencyOffset('SampleRate', fs,'FrequencyOffset',fc);%���ز�
ytemp = pfo(yf); 
y = real(ytemp.');
    

