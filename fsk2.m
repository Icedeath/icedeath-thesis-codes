%��������λ��FSK2���޳����˲�
function y=fsk2(N_code,fc,fs,fd,freqsep)
M=2;
xsym = randi([0 M-1],N_code,1); %��Ϣ�ź�
N_sample=fs/fd;
syms = fskmod(xsym,M,freqsep,N_sample,fs,'discont'); %��������
pfo = comm.PhaseFrequencyOffset('SampleRate', fs,'FrequencyOffset',fc);%���ز�
ytemp = pfo(syms);
y = real(ytemp.');

%%
%%
% ������λ��FSK������fskmod(xsym,M,freqsep,N_sample,fs);
% Ҳ�����ã�
% mod = comm.CPFSKModulator('ModulationOrder', M, ...
%                           'ModulationIndex', freqsep/fd, ... 
%                           'SamplesPerSymbol', N_sample);
% ����ָ����Ӧfreqsep����,mod.ModulationIndex=freqsep/fd;
% meanM = mean(0:M-1);
% syms = mod(2*(xsym-meanM));
% ���ߣ�
% mod1 = comm.CPMModulator('ModulationOrder', M, ...
%                          'ModulationIndex', freqsep/fd, ... 
%                          'SamplesPerSymbol', N_sample);
% meanM = mean(0:M-1);
% syms = mod(2*(xsym-meanM));
%%
