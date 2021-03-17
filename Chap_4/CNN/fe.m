
fe_1 = zeros(11,15);
fe_2 = fe_1;
fe_3 = fe_1;
fe_4 = fe_1;
fe_5 = fe_1;

for j = 0:2:20
    file_name = strcat('fe_',num2str(j));
load(file_name)
y = y + 1;
for i = 1:15
    eval(['fe',num2str(i),'=fe(y==',num2str(i),',:);']);
    eval(['fe',num2str(i),'_m=mean(fe',num2str(i),',1);']);
    for k = 1:5
       eval(['fe_',num2str(k),'(j/2+1, i) = fe',num2str(i),'_m(k);' ])
    end
end
end

lw = 1;
n = 0:2:20;
for k = 1:5
figure()
set(gca,'FontSize',10.5,'Fontname', 'Times New Roman');
hold on
grid on
box on
for i = 1:15
    eval(['h',num2str(i),'=plot(n,fe_',num2str(k),'(:,i));'])
end
set(h1,'color','m','linewidth',lw, 'marker','o');
set(h2,'color','m','linewidth',lw, 'marker','+');
set(h3,'color','m','linewidth',lw, 'marker','>');
set(h4,'color','k','linewidth',lw, 'marker','o');
set(h5,'color','k','linewidth',lw, 'marker','+');
set(h6,'color','k','linewidth',lw, 'marker','>');
set(h7,'color','r','linewidth',lw, 'marker','o');
set(h8,'color','r','linewidth',lw, 'marker','+');
set(h9,'color','r','linewidth',lw, 'marker','>');
set(h10,'color','b','linewidth',lw, 'marker','o');
set(h11,'color','b','linewidth',lw, 'marker','+');
set(h12,'color','b','linewidth',lw, 'marker','>');
set(h13,'color','b','linewidth',lw, 'marker','*');
set(h14,'color',[0.4660 0.6740 0.1880],'linewidth',lw, 'marker','o');
set(h15,'color',[0.4660 0.6740 0.1880],'linewidth',lw, 'marker','+');
xlabel('\fontname{宋体}信噪比\fontname{Times New Roman} (dB)','fontsize',10.5)
ylabel('\fontname{宋体}特征值','fontsize',10.5)
l = legend('2-ASK','4-ASK','8-ASK','2-FSK','4-FSK','8-FSK','2-PSK','4-PSK','8-PSK','16-QAM','64-QAM','128-QAM',...
    '256-QAM','MSK','GMSK','Location','EastOutside','Fontname','Times New Roman','Fontsize',10.5);
end