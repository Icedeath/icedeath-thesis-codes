function [m,y]=ask2(N_code,fc,fs,rs)
M = 2;     %2ASK����
xsym = randi([0 M-1],N_code,1); %��������
N_s = fs/rs;       %�������Ų�����
m = zeros(1,N_s*N_code);     
for i = 1:N_code
    m(1,(i-1)*N_s+1:(i-1)*N_s+N_s) = xsym(i);    %����NRZ��Ԫ����
end

m = m*0.6 + 0.2;        %��Ӧ���е��Ʋ�����0��1��Ӧ���Ʒ���Ϊ0.2��0.8

y = modulate(m,fc,fs,'am');  %�ز�����