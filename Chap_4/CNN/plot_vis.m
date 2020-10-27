i=7;
m_t=m(i,:)';
y_t=y(i,:);
figure()
grid on
subplot(4,1,1)
m_t=[m_t;m_t(end,1)];
n = [0:N_code]+0.5;
stairs(n,m_t,'LineWidth',1)
xlabel('码元序号')
title('基带码元波形')
xlim([0.5,N_code+0.5])
subplot(4,1,2)
n = [1:fs/rs*N_code]/fs;
plot(n,y_t);
title('时域波形')
xlabel('时间/ms')
ylabel('幅值')
subplot(4,1,3)
plot(out09(i,:,60))
subplot(4,1,4)
plot(out42(i,:))
xlim([1,256])