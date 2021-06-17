acc_0_20 = [0.76,0.809,0.858,0.899,0.901,0.929,0.9505,0.976,0.985,0.993,0.9925];
acc_0_10 = [0.768,0.814,0.863,0.902,0.907,0.931,0.950,0.975,0.983,0.989,0.99];
acc_5_15 = [0.425,0.782,0.853,0.901,0.910,0.930,0.95087,0.978,0.985,0.992,0.9917];

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

l1 = legend('{\it SNR\rm_{tr}\in [0,20]} dB','{\it SNR\rm_{tr}\in [0,10]} dB','{\it SNR\rm_{tr}\in [5,15]} dB',...
    'Fontname','Times New Roman','Fontsize',10.5);

