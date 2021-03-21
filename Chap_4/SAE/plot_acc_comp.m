acc_0_20 = [0.986 0.9945 0.996 0.997 0.997 0.998 0.99875 0.9989 0.9978 0.998 0.9978];
acc_0_10 = [0.706 0.739 0.747 0.749 0.749 0.7495 0.747 0.744 0.741 0.737 0.736];
acc_5_15 = [0.99 0.995 0.997 1 1 1 1 0.999 0.999 1 0.9995];

n = 0:2:20;
f1 = plot(n,acc_0_20);
hold on
grid on
box on
set(gca,'FontSize',10.5,'Fontname', 'Times New Roman');
f2 = plot(n,acc_0_10);
f3 = plot(n,acc_5_15);
lw = 1;

set(f1,'color','m','linewidth',lw, 'marker','o');
set(f2,'color','b','linewidth',lw, 'marker','+');
set(f3,'color','k','linewidth',lw, 'marker','>');
xlabel('\fontname{宋体}信噪比\fontname{Times New Roman} (dB)','fontsize',10.5)
ylabel('\fontname{宋体}识别准确率','fontsize',10.5)

l1 = legend('RS-AMR, \itSNR\rm_{tr}=10 dB, \itN\rm_s=20','SAE-AMR, \itSNR\rm_{tr}\in[0 20] dB \itN\rm_s=400',...
    'SAE-AMR, \itSNR\rm_{tr}\in[0 20] dB, \itN\rm_s=2200','Fontsize',10.5,'FontName','Times New Roman');

