clear all

acc_fe =  [0.6467 0.7233 0.7732 0.8165 0.8767 0.9033 0.93 0.9367 0.9233 0.9312 0.9367];
acc_cnn = [0.762 0.804 0.858 0.894 0.913 0.932 0.952 0.976 0.984 0.992 0.995];
acc_ZR =  [0.782 0.814 0.863 0.905 0.915 0.937 0.955 0.972 0.982 0.986 0.990];



n = 0:2:20;
f1 = plot(n,acc_fe);
hold on
grid on
box on
set(gca,'FontSize',10.5,'Fontname', 'Times New Roman');
f2 = plot(n,acc_cnn);
f3 = plot(n,acc_ZR);
lw = 1;

set(f1,'color','m','linewidth',lw, 'marker','o');
set(f2,'color','b','linewidth',lw, 'marker','+');
set(f3,'color','k','linewidth',lw, 'marker','d');

xlabel('\fontname{宋体}信噪比\fontname{Times New Roman} (dB)','fontsize',10.5)
ylabel('\fontname{宋体}识别准确率','fontsize',10.5)

l1 = legend('\fontname{宋体}基于特征提取的方法\fontname{Times New Roman}({\it SNR\rm_{te}=\it SNR\rm_{tr}} )',...
    '\fontname{宋体}本小节提出的方法\fontname{Times New Roman}({\it SNR\rm_{tr}\in[0 20] dB})',...
    '\fontname{Times New Roman}LSTM-Attention\fontname{宋体}混合模型\fontname{Times New Roman}({\it SNR\rm_{tr}\in[0 20] dB})','Fontsize',10.5);

