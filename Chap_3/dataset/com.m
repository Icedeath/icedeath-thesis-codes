%%%%%%%%%%%%%%%%%%%%%组合一定范围内的特征数据%%%%%%%%%%%%%%%%%%
clc
clear all

begin_snr = -4;
end_snr =20;

train_x1 = [];
train_y1 = [];
test_x1 = [];
test_y1 = [];


for snr =begin_snr:4:end_snr
    fdata = strcat('data_fe_', num2str(snr));

    load(strcat(fdata,'.mat'))
    
    train_x1=[train_x1;train_x];
    train_y1=[train_y1;train_y];
    test_x1=[test_x1;test_x];
    test_y1=[test_y1;test_y];
end


train_x = train_x1;
clear train_x1
train_y = train_y1;
clear train_y1
test_x = test_x1;
clear test_x1
test_y = test_y1;
clear test_y1


%disp(strcat('Normalizing....'))
 
%train_x=(train_x-mean(train_x(:)))/std(test_x(:));
%test_x=(test_x-mean(test_x(:)))/std(test_x(:));



file_name = strcat('fe_',num2str(begin_snr),'_',num2str(end_snr));
tic
disp(strcat('start saving', 32,file_name,'.mat, please wait....'))

save(file_name,'train_x','train_y','test_x','test_y')