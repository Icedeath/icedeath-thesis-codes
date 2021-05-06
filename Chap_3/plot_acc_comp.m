clear all

load acc_fs_40  %特征提取
acc_fs = ace_m(:,4:end);
load acc_sae_56 %SAE 0-20 样本不够
acc_sae_88 = test_acc;
load acc_sae_40%SAE 10 样本足够
acc_sae_160 = test_acc;
load acc_sae_176%SAE 0-20 样本足够
acc_sae_176 = test_acc;
load acc_cnn_200 %CNN 0-20 样本不够
acc_cnn_200 = acc_aver;
load acc_cnn_300_10%CNN 10 样本足够
acc_cnn_300_10 = acc_aver;
load acc_cnn_300%CNN 0-20 样本足够
acc_cnn_300 = acc_aver;



n = -4:2:20;
f1 = plot(n,acc_fs);
hold on
grid on
box on
set(gca,'FontSize',10.5,'Fontname', 'Times New Roman');
f2 = plot(n,acc_sae_88);
f3 = plot(n,acc_sae_160);
f4 = plot(n,acc_sae_176);
f5 = plot(n,acc_cnn_200);
f6 = plot(n,acc_cnn_300_10);
f7 = plot(n,acc_cnn_300);



lw = 1;

set(f1,'color','m','linewidth',lw, 'marker','o');
set(f2,'color','b','linewidth',lw, 'marker','+');
set(f3,'color','b','linewidth',lw, 'marker','>');
set(f4,'color','b','linewidth',lw, 'marker','o');
set(f5,'color','r','linewidth',lw, 'marker','+');
set(f6,'color','r','linewidth',lw, 'marker','>');
set(f7,'color','r','linewidth',lw, 'marker','o');

xlabel('\fontname{宋体}信噪比\fontname{Times New Roman} (dB)','fontsize',10.5)
ylabel('\fontname{宋体}识别准确率','fontsize',10.5)

l1 = legend('FS-AMR, \itSNR\rm_{tr}=8 dB, \itN\rm_s=24','MLP, \itSNR\rm_{tr}\in[0 20] dB \itN\rm_s=56',...
    'MLP, \itSNR\rm_{tr}=8 dB, \itN\rm_s=40', 'MLP, \itSNR\rm_{tr}\in[0 20] dB, \itN\rm_s=176',...
    'CNN, \itSNR\rm_{tr}\in[0 20] dB \itN\rm_s=200','CNN, \itSNR\rm_{tr}=10 dB, \itN\rm_s=300',...
    'CNN, \itSNR\rm_{tr}\in[0 20] dB, \itN\rm_s=1000','Fontsize',10.5,'FontName','Times New Roman');

