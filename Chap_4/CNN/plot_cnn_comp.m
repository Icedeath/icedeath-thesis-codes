clear all

acc_fe = [0.6793 0.6988 0.7161 0.7205 0.7309 0.735 0.74 0.749 0.7467 0.7562 0.7618];
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

