clear all

acc_fe = [0.7867 0.8233 0.8732 0.9165 0.9267 0.9233 0.93 0.9367 0.9433 0.9412 0.9467];
acc_cnn = [0.8133 0.875 0.9079 0.9284 0.9543 0.9836 0.9932 0.9986 0.9993 0.9995 0.9999];



n = 0:2:20;
f1 = plot(n,acc_fe);
hold on
grid on
box on
set(gca,'FontSize',10.5,'Fontname', 'Times New Roman');
f2 = plot(n,acc_cnn);

lw = 1;

set(f1,'color','m','linewidth',lw, 'marker','o');
set(f2,'color','b','linewidth',lw, 'marker','+');

xlabel('\fontname{����}�����\fontname{Times New Roman} (dB)','fontsize',10.5)
ylabel('\fontname{����}ʶ��׼ȷ��','fontsize',10.5)

l1 = legend('\fontname{����}����������ȡ�ķ���\fontname{Times New Roman}({\it SNR\rm_{te}=\it SNR\rm_{tr}} )',...
    '\fontname{����}��С������ķ���\fontname{Times New Roman}({\it SNR\rm_{tr}\in[0 20] dB})','Fontsize',10.5);

