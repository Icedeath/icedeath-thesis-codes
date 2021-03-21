%%%%%%%%%%%%%%%%%%%%%组合一定范围内的特征数据%%%%%%%%%%%%%%%%%%
clc
clear all

begin_snr = 0;
end_snr = 20;

fe1 = [];
y1 = [];


for snr =begin_snr:2:end_snr
    fdata = strcat('fe_', num2str(snr));

    load(strcat(fdata,'.mat'))
    
    fe1=[fe1;fe];
    y1=[y1,y];
end


fe = fe1;
clear fe1
y = y1;
clear y1



%disp(strcat('Normalizing....'))
 
%fe=(fe-mean(fe(:)))/std(test_x(:));
%test_x=(test_x-mean(test_x(:)))/std(test_x(:));



file_name = strcat('fe_',num2str(begin_snr),'_',num2str(end_snr),'_2');
tic
disp(strcat('start saving', 32,file_name,'.mat, please wait....'))

save(file_name,'fe','y')