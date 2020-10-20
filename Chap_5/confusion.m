clear all
load cm_201


for i=1:8
    a=sum(cm(i,:));
    cm(i,9) = cm(i,9)/a;
end
for i=1:8
    a=sum(cm(:,i));
    cm(:,i) = cm(:,i)/a;
end


imagesc(cm);

colorbar();

xticklabels({'2ASK','2FSK','4FSK','BPSK','QPSK','16QAM','64QAM','MSK','N/A'})
yticklabels({'2ASK','2FSK','4FSK','BPSK','QPSK','16QAM','64QAM','MSK','N/A'})
set(gca,'FontName','Times New Roman','FontSize',10.5)
ylabel('\fontname{宋体}识别结果','FontSize', 10.5)
xlabel('\fontname{宋体}实际类别', 'FontSize', 10.5)

for i=1:9
    for j=1:9
        if i==j && cm(j,i)>=0.01
            text(i,j,num2str(cm(j,i),'%.2f'),'HorizontalAlignment',...
            'center','FontName', 'Times New Roman', 'FontSize', 10.5, 'color','black')
        elseif cm(j,i)>=0.01
            text(i,j,num2str(cm(j,i),'%.2f'),'HorizontalAlignment',...
            'center','FontName', 'Times New Roman', 'FontSize', 10.5, 'color','white')
        end
    end
end