clc
clear all

train_x1=[];
train_y1=[];
for snr = 0:2:20
   file = strcat('data_fe_',num2str(snr), '.mat');
   load(file);
   train_x1 = [train_x1;train_x];
   train_y1 = [train_y1;train_y];
    
% x = [mode1;mode2;mode3;mode4;mode5;mode6;mode7;mode8];
% mode1y = zeros(22000,1);
% mode2y = ones(22000,1);
% mode3y = ones(22000,1)*2;
% mode4y = ones(22000,1)*3;
% mode5y = ones(22000,1)*4;
% mode6y = ones(22000,1)*5;
% mode7y = ones(22000,1)*6;
% mode8y = ones(22000,1)*7;
% y =[mode1y;mode2y;mode3y;mode4y;mode5y;mode6y;mode7y;mode8y];
%  
% train_x=(train_x-mean(train_x(:)))/std(test_x(:));
% test_x=(test_x-mean(test_x(:)))/std(test_x(:));

%file_name = strcat('data',num2str(begin_snr),'_',num2str(end_snr));
% tic
% disp(strcat('start saving', 32,file_name,'_norm.mat, please wait....'))
% toc
end
train_x = train_x1;
train_y = train_y1;
tic

save('data_train.mat', 'train_x', 'train_y', '-v7.3')

toc
