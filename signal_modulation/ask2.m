function [m,y]=ask2(N_code,fc,fs,rs)
M = 2;     %2ASK����
m = randi([0 M-1],N_code,1); %��������
N_s = fs/rs;       %�������Ų�����
xsym = zeros(1,N_s*N_code);     

for i = 1:N_code
    xsym(1,(i-1)*N_s+1:(i-1)*N_s+N_s) = m(i);    %����NRZ��Ԫ����
end

xsym = xsym*0.6+0.2;        %��Ӧ���е��Ʋ�����0~7��Ӧ���Ʒ���Ϊ0.125~1

y = modulate(xsym,fc,fs,'am');  %�ز�����