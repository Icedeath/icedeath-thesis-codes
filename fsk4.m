%��������λ��FSK4���޳����˲�
function y=fsk4(N_code,fc,fs,fd,freqsep)
M=4;
xsym = randi([0 M-1],N_code,1); %��Ϣ�ź�
N_sample=fs/fd;
syms = fskmod(xsym,M,freqsep,N_sample,fs,'discont'); %��������
pfo = comm.PhaseFrequencyOffset('SampleRate', fs,'FrequencyOffset',fc);%���ز�
ytemp = pfo(syms);
y = real(ytemp.');