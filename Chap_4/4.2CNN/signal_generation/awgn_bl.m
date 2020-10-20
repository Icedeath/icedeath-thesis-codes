%%%%%%%%%%%%%%%%%%%%%%%%%Ϊ�ź���Ӵ��޸�˹����%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function y_n = awgn_bl(fs,N_filter,fc1,fc2,y,snr) %���������������źŴ����1.2����ע�����Ƶ��
n = randn(1,length(y));
[~,n_b] = fir_filter(fs,N_filter,fc1,fc2,n);
rsn = sqrt(sig_e(y)/sig_e(n_b))*10^(-snr/20);
n_b = rsn*n_b;
y_n = y + n_b;