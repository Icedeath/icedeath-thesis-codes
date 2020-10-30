%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%画图：25特征与筛选后特征
clear all

n=0:2:20;
figure()
grid on
box on
hold on
load acc_4_20
h1 = plot(n,ace_m,'bs-');
set(gca,'FontSize',10.5,'Fontname', 'Times New Roman');
set(h1,'LineWidth',0.8)
xlabel('\fontname{宋体}测试\fontname{Times New Roman}SNR','FontSize',10.5)
ylabel('\fontname{宋体}识别正确率','FontSize',10.5)

load acc_4_16
h2 = plot(n,ace_m,'r*-');
set(gca,'FontSize',10.5,'Fontname', 'Times New Roman');
set(h2,'LineWidth',0.8)
xlabel('\fontname{宋体}测试\fontname{Times New Roman}SNR','FontSize',10.5)
ylabel('\fontname{宋体}识别正确率','FontSize',10.5)

load acc_4_12
h3 = plot(n,ace_m,'kd-');
set(gca,'FontSize',10.5,'Fontname', 'Times New Roman');
set(h3,'LineWidth',0.8)
xlabel('\fontname{宋体}测试\fontname{Times New Roman}SNR','FontSize',10.5)
ylabel('\fontname{宋体}识别正确率','FontSize',10.5)

load acc_4_8
h4 = plot(n,ace_m,'m>-');
set(gca,'FontSize',10.5,'Fontname', 'Times New Roman');
set(h4,'LineWidth',0.8)
xlabel('\fontname{宋体}测试\fontname{Times New Roman}SNR','FontSize',10.5)
ylabel('\fontname{宋体}识别正确率','FontSize',10.5)

load acc_4_4
h5 = plot(n,ace_m,'b*-');
set(gca,'FontSize',10.5,'Fontname', 'Times New Roman');
set(h5,'LineWidth',0.8)
xlabel('\fontname{宋体}测试\fontname{Times New Roman}SNR','FontSize',10.5)
ylabel('\fontname{宋体}识别正确率','FontSize',10.5)

ylim([0.98,1])

h6=legend('\fontname{Times New Roman}\it{SNR_{te}\rm = 20 dB}', '\fontname{Times New Roman}\it{SNR_{te}\rm = 16 dB}', ...
    '\fontname{Times New Roman}\it{SNR_{te}\rm = 12 dB}', '\fontname{Times New Roman}\it{SNR_{te}\rm = 8 dB}',...
    '\fontname{Times New Roman}\it{SNR_{te}\rm = 4 dB}');
set(h6,'FontSize',10.5)