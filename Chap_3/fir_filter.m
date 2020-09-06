%%%%%%%%%%%%%%%%%%%%%使用Hamming窗设计FIR滤波器并完成滤波%%%%%%%%%%%%%%%%%%%%%%
function [h,y_f] = fir_filter(fs,N_filter,fc1,fc2,y)
flag = 'scale';  % Sampling Flag

win = hamming(N_filter+1);

b  = fir1(N_filter, [fc1 fc2]/(fs/2), 'bandpass', win, flag);
h = dfilt.dffir(b).Numerator;

y_f = conv(h,y);           %卷积操作滤波
y_f = y_f(1,N_filter/2:end-N_filter/2-1);    %FIR群延时为N_filter/2
% fvtool(h)
% xlabel('频率/MHz')
% ylabel('幅度/dB')
% title('滤波器频率响应特性')
% grid on