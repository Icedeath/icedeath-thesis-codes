clear all
%close all


load CNN_tsne_20
%tsne = MDS;
a=min(tsne(:));
b=max(tsne(:));
tsne=(tsne-a)/(b-a);
a=30;

col=rand(3,15);

col(2,:)=col(2,:)*0.7+0.1;

load col
c=zeros(3,size(tsne,1));
for i=1:size(tsne,1)
    c(:,i)=col(:,y(i));
end
d1=tsne(:,1);
d2=tsne(:,2);
figure()
hold on
col=col';
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

legend([y1,y2,y3,y4,y5,y6,y7,y8],'2ASK','4ASK','8ASK','2FSK','4FSK','8FSK','2PSK','4PSK','Orientation','horizontal');
legend boxoff
l1=axes('position',get(gca,'position'),'visible','off');
legend(l1,[y9,y10,y11,y12,y13,y14,y15],'8PSK','4QAM','16QAM','64QAM','OFDM','LFM','MSK','Orientation','horizontal');
legend boxoff

