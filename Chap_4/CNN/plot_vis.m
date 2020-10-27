i=12;

m_t=m(:,i);
y_t=y(i,:);
figure()
subplot(2,1,1)
m_t=[m_t;m_t(end,1)];
n = [0:N_code]+0.5;
stairs(n,m_t,'LineWidth',1)
xlabel('码元序号')
title('基带码元波形')
xlim([0.5,N_code+0.5])
subplot(2,1,2)
n = [1:fs/rs*N_code]/fs;
plot(n,y_t);
title('时域波形')
xlabel('时间/ms')
ylabel('幅值')