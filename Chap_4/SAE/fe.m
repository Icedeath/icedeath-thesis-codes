%%%%%%%%%%%画各个特征值变化曲线%%%%%%%%%%%%%%%%%%%%%%%%%
fe_1 = zeros(13,10);
fe_2 = fe_1;
fe_3 = fe_1;


for j = -6:2:20
    file_name = strcat('fe_',num2str(j));
load(file_name)
y = y + 1;
for i = 1:10
    eval(['fe',num2str(i),'=fe(y==',num2str(i),',:);']);
    eval(['fe',num2str(i),'_m=mean(fe',num2str(i),',1);']);
    for k = 1:3
       eval(['fe_',num2str(k),'(j/2+4, i) = fe',num2str(i),'_m(k);' ])
    end
end
end

lw = 1;
n = -6:2:20;
for k = 1:3
figure()
set(gca,'FontSize',10.5,'Fontname', 'Times New Roman');
hold on
grid on
box on
for i = 1:10
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

xlabel('\fontname{宋体}信噪比\fontname{Times New Roman} (dB)','fontsize',10.5)
ylabel('\fontname{宋体}特征值','fontsize',10.5)
l = legend('2-ASK','4-ASK','8-ASK','2-FSK','4-FSK','8-FSK','2-PSK','4-PSK','8-PSK','16-QAM',...
   'Location','EastOutside','Fontname','Times New Roman','Fontsize',10.5);
end