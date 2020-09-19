%%%%%%%%%%%%%%%%%%%%%%%%%为信号添加带限高斯噪声%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function y_n = awgn_bl(fs,N_filter,fc1,fc2,y,snr) %文中噪声带宽是信号带宽的1.2倍，注意调整频率
n = randn(1,length(y));
[~,n_b] = fir_filter(fs,N_filter,fc1,fc2,n);
rsn = sqrt(sig_e(y)/sig_e(n_b))*10^(-snr/20);
n_b = rsn*n_b;
y_n = y + n_b;