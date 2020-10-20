%%%%%%%%%%%%%%%%%%%%%ʹ��Hamming�����FIR�˲���������˲�%%%%%%%%%%%%%%%%%%%%%%
function [h,y_f] = fir_filter(fs,N_filter,fc1,fc2,y)
flag = 'scale';  % Sampling Flag

win = hamming(N_filter+1);

b  = fir1(N_filter, [fc1 fc2]/(fs/2), 'bandpass', win, flag);
h = dfilt.dffir(b).Numerator;

y_f = conv(h,y);           %��������˲�
y_f = y_f(1,N_filter/2:end-N_filter/2-1);    %FIRȺ��ʱΪN_filter/2
% fvtool(h)
% xlabel('Ƶ��/MHz')
% ylabel('����/dB')
% title('�˲���Ƶ����Ӧ����')
% grid on