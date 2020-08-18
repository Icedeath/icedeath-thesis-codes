% ������λFSK4���޳����˲�
function y=cpfsk4(N_code,fc,fs,fd,freqsep)
M=4;
xsym = randi([0 M-1],N_code,1); %��Ϣ�ź�
N_sample=fs/fd;
mod = comm.CPFSKModulator('ModulationOrder', M, ...
                          'ModulationIndex', freqsep/fd, ...
                          'SamplesPerSymbol', N_sample);
meanM = mean(0:M-1);
syms = mod(2*(xsym-meanM));
pfo = comm.PhaseFrequencyOffset('SampleRate', fs,'FrequencyOffset',fc);%���ز�
ytemp = pfo(syms);
y = real(ytemp.');