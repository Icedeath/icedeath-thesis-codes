i=4;
m_t=m(i,:)';
y_t=y(i,:);
figure()
grid on
h1=subplot(5,1,1);
set(h1,'units','normalized','position',[0.1 0.82 0.85 0.13]);
m_t=[m_t;m_t(end,1)];
n = [0:N_code]+0.5;
stairs(n,m_t,'LineWidth',1)
set(gca,'FontSize',10.5,'Fontname', 'Times New Roman');
title('\fontname{宋体}基带码元波形','FontSize',10.5)
xlim([0.5,N_code+0.5])
xlim([19.5 39.5])
xticks({})

h2=subplot(5,1,2);
set(h2,'units','normalized','position',[0.1 0.62 0.85 0.15]);
n = [1:fs/rs*N_code]/fs;
plot(n,y_t);
set(gca,'FontSize',10.5,'Fontname', 'Times New Roman');
title('\fontname{宋体}接收信号\fontname{Times New Roman}(4-ASK, 20 dB)','FontSize',10.5)
xlim([9.5,19.5])
xticks({})
h3=subplot(5,1,3);
set(h3,'units','normalized','position',[0.1 0.42 0.85 0.15]);
plot(out09(i,:,50))
set(gca,'FontSize',10.5,'Fontname', 'Times New Roman');
title('\fontname{宋体}第\fontname{Times New Roman}9\fontname{宋体}层，\fontname{宋体}卷积核\fontname{Times New Roman}50','FontSize',10.5)
xlim([475,975])
xticks({})

h4=subplot(5,1,4);
set(h4,'units','normalized','position',[0.1 0.24 0.85 0.15]);
plot(out21(i,:,15))
set(gca,'FontSize',10.5,'Fontname', 'Times New Roman');
title('\fontname{宋体}第\fontname{Times New Roman}21\fontname{宋体}层，\fontname{宋体}卷积核\fontname{Times New Roman}15','FontSize',10.5)
xlim([237.5,487.5])
xticks({})

h5=subplot(5,1,5);
set(h5,'units','normalized','position',[0.1 0.02 0.85 0.15]);
plot(out31(i,:,10))
set(gca,'FontSize',10.5,'Fontname', 'Times New Roman');
title('\fontname{宋体}第\fontname{Times New Roman}31\fontname{宋体}层，\fontname{宋体}卷积核\fontname{Times New Roman}10','FontSize',10.5)
xlim([108.75,240.75])
xticks({})