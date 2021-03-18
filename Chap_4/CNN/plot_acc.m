acc_0_20 = [0.8133	0.875	0.9079	0.9284	0.9543	0.9836	0.9932	0.9986	0.9993	0.9995	0.9999];
acc_0_10 = [0.8235	0.882	0.9121	0.936	0.9602	0.9847	0.9916	0.9968	0.9975	0.9967	0.9969];
acc_5_15 = [0.499	0.852	0.9098	0.9414	0.9625	0.9904	0.9981	0.9989	0.9994	0.9983	0.9917];

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

l1 = legend('{SNR_{\ittr}\rm\in [0,20]} dB','{SNR_{\ittr}\rm\in [0,10]} dB','{SNR_{\ittr}\rm\in [5,15]} dB',...
    'Fontname','Times New Roman','Fontsize',10.5);

