%%%%%%%%%%%%%%%���ӻ�%%%%%%%%%%%%%%%%%%%%%%%
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

i=7;%%���1~15
n_f=105;%����˱��
c = 21;%����

m_t=m(i,:)';
y_t=y(i,:);
figure()
grid on
subplot(3,1,1)
m_t=[m_t;m_t(end,1)];
n = [0:N_code]+0.5;
stairs(n,m_t,'LineWidth',1)
set(gca,'FontSize',10.5,'Fontname', 'Times New Roman');
xlabel('\fontname{����}��Ԫ���','FontSize',10.5)
title('\fontname{����}������Ԫ����','FontSize',10.5)
xlim([0.5,N_code+0.5])
subplot(3,1,2)
n = [1:fs/rs*N_code]/fs;
plot(n,y_t);
title('\fontname{����}ʱ����')
xlabel('\fontname{����}ʱ��\fontname{Times New Roman}/ms')
ylabel('\fontname{����}��ֵ')
subplot(3,1,3)
if c<10
    a=strcat('plot(out',num2str(0),num2str(c),'(i,:,n_f))');
    eval(a)
else
    a=strcat('plot(out',num2str(c),'(i,:,n_f))');
    eval(a)
end
ylabel('\fontname{����}����ֵ')