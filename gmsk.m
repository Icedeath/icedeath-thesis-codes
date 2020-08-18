function y=gmsk(N_code,fc,fs,fd)
M=2;
xsym = randi([0 M-1],N_code,1); %��Ϣ�ź�
N_sample=fs/fd;
mod = comm.GMSKModulator('PulseLength',4, ...
                         'BandwidthTimeProduct', 0.35, ...
                         'SamplesPerSymbol',N_sample);
meanM = mean(0:M-1);
syms = mod(2*(xsym-meanM));
pfo = comm.PhaseFrequencyOffset('SampleRate', fs,'FrequencyOffset',fc);%���ز�
ytemp = pfo(syms);
y = real(ytemp.');