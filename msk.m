% MSK���޳����˲�
function y=msk(N_code,fs,fd,fc)
M=2;
N_samples=fs/fd;    
xsym = randi([0 M-1],N_code,1); %��Ϣ�ź�
syms = mskmod(xsym,N_samples,[],0);%MSK����������
pfo = comm.PhaseFrequencyOffset('SampleRate', fs,'FrequencyOffset',fc);%���ز�
ytemp = pfo(syms);
y = real(ytemp.');

%%
%%
% ���¼����ȼۣ�����MSK
% MSK=������λ��2FSK+�����ز�Ƶ��֮��ļ��Ϊ1/2��Ԫ���ʣ�
% MSK���Կ����ǵ���ָ��Ϊ0.5��һ��CPFSK�ź�.
% M=2;
% fc=6;
% fs=1000;
% fd=2;
% freqsep=fd/2; % �ز�Ƶ��֮��ļ��Ϊ1/2��Ԫ����
% xsym = [0,1,1,1,0,1,0,1].';%randi([0 M-1],N_code,1); %��Ϣ�ź�
% N_sample=fs/fd;
% mod = comm.CPFSKModulator('ModulationOrder', M, ...
%                           'ModulationIndex', 0.5, ...
%                           'SamplesPerSymbol', N_sample);
% meanM = mean(0:M-1);
% syms = mod(2*(xsym-meanM)); % ����ֵ�ķ�Χ��mskmod��һ������[-1,1]
% pfo = comm.PhaseFrequencyOffset('SampleRate', fs,'FrequencyOffset',fc);%���ز�
% ytemp = pfo(syms);
% y = real(ytemp.');
% plot(y);
% hold on;
% mod1 = comm.CPMModulator('ModulationOrder', M, ...
%                         'ModulationIndex', 0.5, ...
%                         'SamplesPerSymbol', N_sample);
% syms1 = mod1(2*(xsym-meanM));
% ytemp1 = pfo(syms1);
% y1 = real(ytemp1.');
% plot(y1);
% hold on;
% syms2 = mskmod(xsym,N_sample,[],0);%MSK����������
% ytemp2 = pfo(syms2);
% y2 = real(ytemp2.');
% plot(y2);
% hold on;
% syms3 = fskmod(xsym,M,freqsep,N_sample,fs); %��������
% ytemp3 = pfo(syms3);
% y3 = real(ytemp3.');
% plot(y3);
%%
