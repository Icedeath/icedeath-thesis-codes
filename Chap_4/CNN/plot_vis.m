i=7;
m_t=m(i,:)';
y_t=y(i,:);
figure()
grid on
subplot(4,1,1)
m_t=[m_t;m_t(end,1)];
n = [0:N_code]+0.5;
stairs(n,m_t,'LineWidth',1)
xlabel('��Ԫ���')
title('������Ԫ����')
xlim([0.5,N_code+0.5])
subplot(4,1,2)
n = [1:fs/rs*N_code]/fs;
plot(n,y_t);
title('ʱ����')
xlabel('ʱ��/ms')
ylabel('��ֵ')
subplot(4,1,3)
plot(out09(i,:,60))
subplot(4,1,4)
plot(out42(i,:))
xlim([1,256])