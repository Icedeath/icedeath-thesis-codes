% �����ҳ����˲�QAM16
function y=qam16(N_code,fc,fs,fd)
M=16;
xsym = randi([0 M-1],N_code,1); %��Ϣ�ź�
N_sample=fs/fd;
syms = qammod(xsym,M,'UnitAveragePower',true); %����QAM����,'PlotConstellation',true
filterCoeffs = rcosdesign(0.35, 4, N_sample);%�������
yf = filter(filterCoeffs, 1, upsample(syms,N_sample));
pfo = comm.PhaseFrequencyOffset('SampleRate', fs,'FrequencyOffset',fc);%���ز�
ytemp = pfo(yf); 
y = real(ytemp.');





% fc=6;
% fs=1000;
% fd=2;
% Ac=1;
% xsym = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15];


% figure(2)
% plot(y);
% title("16QAM�źŲ���");
% xlabel("ʱ��t");ylabel("�ز����");
% scatterplot(y_1);
% title("16QAM�ź�����ͼ");
% xlabel("ͬ�����");ylabel("��������");