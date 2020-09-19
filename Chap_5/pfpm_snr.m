load pfpm_snr
pf1 = pf;
pm1 = pm;
acc1 = acc;
load pfpm_snr_lt
n = (0.15:0.01:0.85)';

figure()
hold on
grid on
yyaxis left
plot(n, pf1, 'bo-');
plot(n, pm1, 'm<-');
set(gca,'FontSize',10.5,'Fontname', 'Times New Roman');
ylabel('\fontname{Times New Roman}\it{p_{f}} \rm\fontname{宋体}与 \fontname{Times New Roman}\it{p_m}')
ylim([0,0.6])
yyaxis right
plot(n, mean(acc1,2), 'rs-');
set(gca,'FontSize',10.5,'Fontname', 'Times New Roman');
ylabel(' \fontname{Times New Roman}\it{P_{cc}}')
ylim([0.9,1])
legend('\fontname{Times New Roman}\it{p_{f}}', '\fontname{Times New Roman}\it{p_m}',' \fontname{Times New Roman}\it{P_{cc}}','fontsize',10.5)
xlim([0.15 0.85])
xlabel('\fontname{宋体}判决阈值\fontname{Times New Roman}\it{T}')
