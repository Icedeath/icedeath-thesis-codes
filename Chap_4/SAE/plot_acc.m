%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%��ͼ��25������ɸѡ������
clear all

n=0:2:20;

grid on
box on
hold on
load acc_5_4
h1 = plot(n,ace_m,'bs-');
set(gca,'FontSize',10.5,'Fontname', 'Times New Roman');
set(h1,'LineWidth',0.8)



load acc_5_10
h2 = plot(n,ace_m,'r*-');
set(gca,'FontSize',10.5,'Fontname', 'Times New Roman');
set(h2,'LineWidth',0.8)


load acc_5_16
h3 = plot(n,ace_m,'kd-');
set(gca,'FontSize',10.5,'Fontname', 'Times New Roman');
set(h3,'LineWidth',0.8)
xlabel('\fontname{����}����\fontname{Times New Roman}SNR \fontname{Times New Roman}(dB)','FontSize',10.5)
ylabel('\fontname{����}ʶ����ȷ��','FontSize',10.5)

ylim([0.45,1])

h6=legend('\fontname{Times New Roman}\it{SNR\rm_{tr} = 4 dB}', '\fontname{Times New Roman}\it{SNR\rm_{tr} = 10 dB}', ...
    '\fontname{Times New Roman}\it{SNR\rm_{tr} = 16 dB}');
set(h6,'FontSize',10.5)