%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%画图：25特征与筛选后特征
clear all

n=0:2:20;
figure()
grid on
box on
hold on
load acc_5_20
h1 = plot(n,ace_m,'bs-');
set(gca,'FontSize',10.5,'Fontname', 'Times New Roman');
set(h1,'LineWidth',0.8)
xlabel('\fontname{宋体}测试\fontname{Times New Roman}SNR','FontSize',10.5)
ylabel('\fontname{宋体}识别正确率','FontSize',10.5)

load acc_5_16
h2 = plot(n,ace_m,'r*-');
set(gca,'FontSize',10.5,'Fontname', 'Times New Roman');
set(h2,'LineWidth',0.8)
xlabel('\fontname{宋体}测试\fontname{Times New Roman}SNR','FontSize',10.5)
ylabel('\fontname{宋体}识别正确率','FontSize',10.5)

load acc_5_12
h3 = plot(n,ace_m,'kd-');
set(gca,'FontSize',10.5,'Fontname', 'Times New Roman');
set(h3,'LineWidth',0.8)
xlabel('\fontname{宋体}测试\fontname{Times New Roman}SNR','FontSize',10.5)
ylabel('\fontname{宋体}识别正确率','FontSize',10.5)

load acc_5_8
h4 = plot(n,ace_m,'m>-');
set(gca,'FontSize',10.5,'Fontname', 'Times New Roman');
set(h4,'LineWidth',0.8)
xlabel('\fontname{宋体}测试\fontname{Times New Roman}SNR','FontSize',10.5)
ylabel('\fontname{宋体}识别正确率','FontSize',10.5)

load acc_5_4
h5 = plot(n,ace_m,'b*-');
set(gca,'FontSize',10.5,'Fontname', 'Times New Roman');
set(h5,'LineWidth',0.8)
xlabel('\fontname{宋体}测试\fontname{Times New Roman}SNR','FontSize',10.5)
ylabel('\fontname{宋体}识别正确率','FontSize',10.5)

load acc_5_0
h6 = plot(n,ace_m,'r<-');
set(gca,'FontSize',10.5,'Fontname', 'Times New Roman');
set(h6,'LineWidth',0.8)
xlabel('\fontname{宋体}测试\fontname{Times New Roman}SNR (dB)','FontSize',10.5)
ylabel('\fontname{宋体}识别正确率','FontSize',10.5)
%ylim([0.98,1])

h6=legend('\fontname{Times New Roman}\it{SNR\rm_{te} = 20 dB}', '\fontname{Times New Roman}\it{SNR\rm_{te} = 16 dB}', ...
    '\fontname{Times New Roman}\it{SNR\rm_{te} = 12 dB}', '\fontname{Times New Roman}\it{SNR\rm_{te} = 8 dB}',...
    '\fontname{Times New Roman}\it{SNR\rm_{te} = 4 dB}', '\fontname{Times New Roman}\it{SNR\rm_{te} = 0 dB}');
set(h6,'FontSize',10.5)