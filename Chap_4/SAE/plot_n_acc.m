acc_aver = [0.9651,0.9641,0.9631,0.9621 0.942 0.5735];
n = [6,5,4,3,2,1];

plot(n,acc_aver,'rd-','linewidth',0.75)
xlabel('\fontname{宋体}特征输出层神经元数')
ylabel('\fontname{宋体}识别准确率')

grid on
box on