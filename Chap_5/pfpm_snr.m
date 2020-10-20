clear all
close all
load acc_3_3.mat
n = 0:2:20;
acc=acc';

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
ylim([0.2,1])
xlabel('\fontname{宋体}混合信噪比\fontname{Times New Roman}\it{\gamma} \rm(dB)','FontSize',10.5)
ylabel('\fontname{Times New Roman}\it{P_{cc}}','FontSize',10.5)

h2 = legend('\fontname{Times New Roman}2ASK', '\fontname{Times New Roman}2FSK', '\fontname{Times New Roman}4FSK', ...
    '\fontname{Times New Roman}BPSK', '\fontname{Times New Roman}QPSK', '\fontname{Times New Roman}16QAM',...
    '\fontname{Times New Roman}64QAM', '\fontname{Times New Roman}MSK');
set(h2,'fontsize',10.5,'Orientation','horizontal','NumColumns',2)
% acc1=acc;
% pf1=pf;
% pm1=pm;
% acc_aver1=acc_aver;
% load acc_3_1_3.mat
% n = 0:2:20;
% acc=sort(acc,1)';
% pf=fliplr(sort(pf));
% pm=fliplr(sort(pm));


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
% h13 = plot(n, pf(1,:), 'bs-');
% set(gca,'FontSize',10.5,'Fontname', 'Times New Roman');
% set(h13,{'LineWidth'},{0.8});
% h14=plot(n, pm(1,:), 'md-');
% set(gca,'FontSize',10.5,'Fontname', 'Times New Roman');
% set(h14,{'LineWidth'},{0.8});
ylim([0,0.65])
ylabel('\fontname{Times New Roman}\it{p_{f}} \rm\fontname{宋体}与 \fontname{Times New Roman}\it{p_m}')
yyaxis right
h11=plot(n, acc_aver(1,:), 'r*-');
set(gca,'FontSize',10.5,'Fontname', 'Times New Roman');
set(h11,{'LineWidth'},{0.8});
% h15=plot(n, acc_aver(1,:), 'r<-');
% set(gca,'FontSize',10.5,'Fontname', 'Times New Roman');
% set(h15,{'LineWidth'},{0.8});
xlim([0,20])
ylim([0.45,0.9])
h1=legend('\fontname{Times New Roman}\it{ p_{f}}', '\fontname{Times New Roman}\it{ p_m}',' \fontname{Times New Roman}\it{P_{cc}}','fontsize',10.5);
% h1=legend('\fontname{Times New Roman}\it{ p_{f} \rm(\it{N\rm_{max}}\rm=2)}','\fontname{Times New Roman}\it{ p_{m} \rm(\it{N\rm_{max}}\rm=2)}',...
%     '\fontname{Times New Roman}\it{ p_{f} \rm(\it{N\rm_{max}}=\rm3)}','\fontname{Times New Roman}\it{ p_{m} \rm(\it{N\rm_{max}}\rm=3)}');
set(h1,'fontsize',10.5,'Orientation','horizontal','NumColumns',1)
ylabel(' \fontname{Times New Roman}\it{P_{cc}}','FontSize',10.5)
xlabel('\fontname{宋体}混合信噪比\fontname{Times New Roman}\it{\gamma} \rm(dB)','FontSize',10.5)

% l1=axes('position',get(gca,'position'),'visible','off');
% h2=legend(l1,[h11,h15],'\fontname{Times New Roman}\it{ P_{cc} \rm(\it{N\rm_{max}}\rm=2)}',...
%     '\fontname{Times New Roman}\it{ P_{cc} \rm(\it{N\rm_{max}}\rm=3)}');
% set(h2,'fontsize',10.5)