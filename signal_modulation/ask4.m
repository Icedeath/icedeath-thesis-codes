function [m,y]=ask4(N_code,fc,fs,rs)
M = 4;     %4ASK����
xsym = randi([0 M-1],N_code,1); %��������
N_s = fs/rs;       %�������Ų�����
m = zeros(1,N_s*N_code);     
for i = 1:N_code
    m(1,(i-1)*N_s+1:(i-1)*N_s+N_s) = xsym(i);    %����NRZ��Ԫ����
end

m = (m+1)/4;        %��Ӧ���е��Ʋ�����0,1,2,3��Ӧ���Ʒ���Ϊ0.25,0.5,0.75,1

y = modulate(m,fc,fs,'am');  %�ز�����