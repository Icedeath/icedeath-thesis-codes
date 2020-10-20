clear all
load acc_2_2_comp

acc_AMPT = [0.5,0.625,0.728,0.82,0.88,0.92];
X = [0,3,6,9,12,15];

n= 0:15;

acc_A=interp1(X,acc_AMPT,n,'Spline');
figure()
hold on 
grid on
h1=plot(n, acc_A, 'bd-');
set(h1,{'LineWidth'},{0.8});
h2=plot(n, acc_aver, 'mo-');
set(h2,{'LineWidth'},{0.8});
set(gca,'FontSize',10.5,'Fontname', 'Times New Roman');
h1=legend('\fontname{宋体}基于\fontname{Times New Roman}A\itM\rmPT\fontname{宋体}的方法','\fontname{宋体}本章提出的方法');
xlabel('\fontname{宋体}混合信噪比\fontname{Times New Roman}\it{\gamma} \rm(dB)')
ylabel('\fontname{Times New Roman}\it{P_{cc}}')
set(h1,'fontsize',10.5,'Orientation','horizontal','NumColumns',1)

