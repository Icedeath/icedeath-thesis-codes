function [m,y]=ask8(N_code,fc,fs,rs)
M = 8;     %4ASK����
xsym = randi([0 M-1],N_code,1); %��������
N_s = fs/rs;       %�������Ų�����
m = zeros(1,N_s*N_code);     

for i = 1:N_code
    m(1,(i-1)*N_s+1:(i-1)*N_s+N_s) = xsym(i);    %����NRZ��Ԫ����
end

m = (m+1)/8;        %��Ӧ���е��Ʋ�����0~7��Ӧ���Ʒ���Ϊ0.125~1

y = modulate(m,fc,fs,'am');  %�ز�����