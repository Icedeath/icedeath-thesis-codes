load acc_2_1_2.mat
n = 0:2:20;
acc=sort(acc,1)';
pf=fliplr(sort(pf));
pm=fliplr(sort(pm));
%acc=acc';
figure()
box on
hold on 
grid on
h1 = plot(n, acc(1,:), 'bo-');
set(gca,'FontSize',10.5,'Fontname', 'Times New Roman');
set(h1,{'LineWidth'},{0.8});
h2=plot(n, acc(2,:), 'm<-');
set(gca,'FontSize',10.5,'Fontname', 'Times New Roman');
set(h2,{'LineWidth'},{0.8});
h3=plot(n, acc(3,:), 'm^-');
set(gca,'FontSize',10.5,'Fontname', 'Times New Roman');
set(h3,{'LineWidth'},{0.8});
h4=plot(n, acc(4,:), 'k*-');
set(gca,'FontSize',10.5,'Fontname', 'Times New Roman');
set(h4,{'LineWidth'},{0.8});
h5=plot(n, acc(5,:), 'ks-');
set(gca,'FontSize',10.5,'Fontname', 'Times New Roman');
set(h5,{'LineWidth'},{0.8});
h6=plot(n, acc(6,:), 'r+-');
set(gca,'FontSize',10.5,'Fontname', 'Times New Roman');
set(h6,{'LineWidth'},{0.8});
h7=plot(n, acc(7,:), 'rd-');
set(gca,'FontSize',10.5,'Fontname', 'Times New Roman');
set(h7,{'LineWidth'},{0.8});
h8=plot(n, acc(8,:), 'b>-');
set(gca,'FontSize',10.5,'Fontname', 'Times New Roman');
set(h8,{'LineWidth'},{0.8});
xlim([0,20])
%ylim([0.85,1])
xlabel('\fontname{宋体}混合信噪比\fontname{Times New Roman}\it{\gamma} \rm(dB)')
ylabel('{P_{cc}}')

legend('\fontname{Times New Roman}2ASK', '\fontname{Times New Roman}2FSK', '\fontname{Times New Roman}4FSK', ...
    '\fontname{Times New Roman}BPSK', '\fontname{Times New Roman}QPSK', '\fontname{Times New Roman}16QAM',...
    '\fontname{Times New Roman}64QAM', '\fontname{Times New Roman}MSK')


figure()
box on
hold on 
grid on
yyaxis left
h9 = plot(n, pf(1,:), 'bo-');
set(gca,'FontSize',10.5,'Fontname', 'Times New Roman');
set(h9,{'LineWidth'},{0.8});
h10=plot(n, pm(1,:), 'm<-');
set(gca,'FontSize',10.5,'Fontname', 'Times New Roman');
set(h10,{'LineWidth'},{0.8});
ylim([0,0.3])
ylabel('\fontname{Times New Roman}\it{p_{f}} \rm\fontname{宋体}与 \fontname{Times New Roman}\it{p_m}')
yyaxis right
h11=plot(n, acc_aver(1,:), 'k^-');
set(gca,'FontSize',10.5,'Fontname', 'Times New Roman');
set(h11,{'LineWidth'},{0.8});
xlim([0,20])
ylim([0.75,1])
legend('\fontname{Times New Roman}\it{ p_{f}}', '\fontname{Times New Roman}\it{ p_m}',' \fontname{Times New Roman}\it{P_{cc}}','fontsize',10.5)
ylabel(' \fontname{Times New Roman}\it{P_{cc}}')
xlabel('\fontname{宋体}混合信噪比\fontname{Times New Roman}\it{\gamma} \rm(dB)')