function [E1,E2,E3,E4,E5]=wt_fe(y)

%5尺度小波分解
[c,l]=wavedec(y,5,'db3');
cd1=detcoef(c,l,1);  
cd2=detcoef(c,l,2);
cd3=detcoef(c,l,3);
cd4=detcoef(c,l,4);
cd5=detcoef(c,l,5);

%细节能量值特征
E1=sum(cd1.^2);
E2=sum(cd2.^2);
E3=sum(cd3.^2);
E4=sum(cd4.^2);
E5=sum(cd5.^2);