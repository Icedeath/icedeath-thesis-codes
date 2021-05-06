%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%画图：25特征与筛选后特征
clear all

n=-6:2:20;

grid on
box on
hold on
load acc_5_-4
h1 = plot(n,ace_m,'bs-');
set(gca,'FontSize',10.5,'Fontname', 'Times New Roman');
set(h1,'LineWidth',0.8)



load acc_5_6
h2 = plot(n,ace_m,'r*-');
set(gca,'FontSize',10.5,'Fontname', 'Times New Roman');
set(h2,'LineWidth',0.8)


load acc_5_16
h3 = plot(n,ace_m,'kd-');
set(gca,'FontSize',10.5,'Fontname', 'Times New Roman');
set(h3,'LineWidth',0.8)
xlabel('\fontname{宋体}测试\fontname{Times New Roman}SNR \fontname{Times New Roman}(dB)','FontSize',10.5)
ylabel('\fontname{宋体}识别正确率','FontSize',10.5)

%ylim([0.45,1])

h6=legend('\fontname{Times New Roman}\it{SNR\rm_{tr} = -4 dB}', '\fontname{Times New Roman}\it{SNR\rm_{tr} = 6 dB}', ...
    '\fontname{Times New Roman}\it{SNR\rm_{tr} = 16 dB}');
set(h6,'FontSize',10.5)