E1 = 0.81;
E2 = 1.21;

snr=0:20;

r = 10.^-(snr/10);

xi_2_max = 10*log10(E2./(E1+(E1+E2)*r));
xi_2_min = 10*log10(E1./(E2+(E1+E2)*r));

xi_3_max = 10*log10(E2./(2*E1+(2*E1+E2)*r));
xi_3_min = 10*log10(E1./(2*E2+(E1+2*E2)*r));

xi_4_max = 10*log10(E2./(3*E1+(3*E1+E2)*r));
xi_4_min = 10*log10(E1./(3*E2+(E1+3*E2)*r));

figure()
hold on
grid on
h1=plot(snr, xi_2_min, 'bo-');
h2=plot(snr, xi_2_max, 'mo-');
h3=plot(snr, xi_3_min, 'b<-');
h4=plot(snr, xi_3_max, 'm<-');
h5=plot(snr, xi_4_min, 'bd-');
h6=plot(snr, xi_4_max, 'md-');
set(gca,'FontSize',10.5,'Fontname', 'Times New Roman');
xlabel('\fontname{宋体}混合信噪比\fontname{Times New Roman}\it{\gamma} \rm(dB)')
ylabel('\fontname{宋体}单个信号信干噪比\fontname{Times New Roman}\it{\xi} \rm(dB)')
h=legend([h1,h3,h5,h2,h4,h6],'$\xi_{min}$($N_{max}$=2)','$\xi_{min}$($N_{max}$=3)',...
    '$\xi_{min}$($N_{max}$=4)','$\xi_{max}$($N_{max}$=2)',...
    '$\xi_{max}$($N_{max}$=3)','$\xi_{max}$($N_{max}$=4)');
set(h,'Interpreter','latex','fontsize',10.5,'Orientation','horizontal','NumColumns',3)