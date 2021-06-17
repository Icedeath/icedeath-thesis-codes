acc_aver = [0.9139,0.9129,0.9129,0.9129 0.8952 0.7929];
n = [7,6,5,4,3,2];

plot(n,acc_aver,'rd-','linewidth',0.75)
xlabel('\fontname{宋体}特征输出层神经元数')
ylabel('\fontname{宋体}识别准确率')

grid on
box on