i=12;

m_t=m(:,i);
y_t=y(i,:);
figure()
subplot(2,1,1)
m_t=[m_t;m_t(end,1)];
n = [0:N_code]+0.5;
stairs(n,m_t,'LineWidth',1)
xlabel('��Ԫ���')
title('������Ԫ����')
xlim([0.5,N_code+0.5])
subplot(2,1,2)
n = [1:fs/rs*N_code]/fs;
plot(n,y_t);
title('ʱ����')
xlabel('ʱ��/ms')
ylabel('��ֵ')