clear all
%close all


load CNN_tsne_0
%tsne = MDS;
a=min(tsne(:));
b=max(tsne(:));
tsne=(tsne-a)/(b-a);
a=30;

col = [1,0,0;0,1,0;0,0,1;0,1,1;1,0,1;1,0.5,0;0,0,0;0 0.4470 0.7410;0.8500 0.3250 0.0980;0.5,0.5,0.5;...
    0.9290 0.6940 0.1250;0.4940 0.1840 0.5560;0.4660 0.6740 0.1880;0.3010 0.7450 0.9330;0.6350 0.0780 0.1840]';

%col(2,:)=col(2,:)*0.7+0.1;

c=zeros(3,size(tsne,1));
for i=1:size(tsne,1)
    c(:,i)=col(:,y(i));
end
d1=tsne(:,1);
d2=tsne(:,2);
figure()
hold on
col = col';
f='filled';
for i=1:15
    c1=d1(y==i);
    c2=d2(y==i);
    eval(['y',num2str(i),'=scatter(c1,c2,a,col(i,:),','f);'])
end
grid on
%legend('2ASK','4ASK','8ASK','2FSK','4FSK','8FSK','2PSK','4PSK','8PSK',...
    %'4QAM','16QAM','64QAM','OFDM','LFM','MSK')

    
% legend([y1,y2,y3,y4,y5],'2ASK','4ASK','8ASK','2FSK','4FSK','Orientation','horizontal');
% legend boxoff
% l1=axes('position',get(gca,'position'),'visible','off');
% legend(l1,[y6,y7,y8,y9,y10],'8FSK','2PSK','4PSK','8PSK','4QAM','Orientation','horizontal');
% legend boxoff
% l2=axes('position',get(gca,'position'),'visible','off');
% legend(l2,[y11,y12,y13,y14,y15],'16QAM','64QAM','OFDM','LFM','MSK','Orientation','horizontal');
% legend boxoff

% legend([y1,y2,y3,y4,y5,y6,y7,y8],'2ASK','4ASK','8ASK','2FSK','4FSK','8FSK','2PSK','4PSK','Orientation','horizontal');
% legend boxoff
% l1=axes('position',get(gca,'position'),'visible','off');
% legend(l1,[y9,y10,y11,y12,y13,y14,y15],'8PSK','4QAM','16QAM','64QAM','OFDM','LFM','MSK','Orientation','horizontal');
% legend boxoff

h = legend('2ASK','4ASK','8ASK','2FSK','4FSK','8FSK','2PSK','4PSK','8PSK',...
   '16QAM','64QAM','128QAM','256QAM','MSK','GMSK');
set(h,'fontsize',10.5,'Orientation','vertical','FontName','Times New Roman');

