%%%%%%%%%%%%%%%%%%%%%%%%%%%%%ʹ��Ԥ����ƺõ��˲��������˲��ͼ���%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function y_n = process(h,h_n,y,N_filter,snr)
y_f = conv(h,y);           %��������˲�
y_f = y_f(1,N_filter/2:end-N_filter/2-1); 
n = randn(1,length(y));

n_b = conv(h_n,n);           %��������˲�
n_b = n_b(1,N_filter/2:end-N_filter/2-1); 
rsn = sqrt(sig_e(y)/sig_e(n_b))*10^(-snr/20);
n_b = rsn*n_b;
y_n = y_f + n_b;