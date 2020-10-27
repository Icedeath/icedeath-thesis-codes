%%%%%%%%%%%%%%%可视化%%%%%%%%%%%%%%%%%%%%%%%
clear all
N_code = 80;
fs = 200;
rs = 2;
fc =70;
load vis_20_cnn
for i=1:43
    if i<10
        a=strcat('out',num2str(0),num2str(i),'=vis_out.out',num2str(i),';');
    else
        a=strcat('out',num2str(i),'=vis_out.out',num2str(i),';');
    end
    eval(a)
end
clear a
clear i

i=10;%%类别，1~15
n_f=60;%卷积核编号
c = 9;%层数

m_t=m(i,:)';
y_t=y(i,:);
figure()
grid on
subplot(3,1,1)
m_t=[m_t;m_t(end,1)];
n = [0:N_code]+0.5;
stairs(n,m_t,'LineWidth',1)
xlabel('码元序号')
title('基带码元波形')
xlim([0.5,N_code+0.5])
subplot(3,1,2)
n = [1:fs/rs*N_code]/fs;
plot(n,y_t);
title('时域波形')
xlabel('时间/ms')
ylabel('幅值')
subplot(3,1,3)
if c<10
    a=strcat('plot(out',num2str(0),num2str(c),'(i,:,n_f))');
    eval(a)
else
    a=strcat('plot(out',num2str(c),'(i,:,n_f))');
    eval(a)
end