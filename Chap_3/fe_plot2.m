%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%画图%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all
clc
load dataset/data_fe
fe1 = zeros((snr_max-snr_min)/2+1,size(mode1,2));
fe2 = zeros((snr_max-snr_min)/2+1,size(mode1,2));
fe3 = zeros((snr_max-snr_min)/2+1,size(mode1,2));
fe4 = zeros((snr_max-snr_min)/2+1,size(mode1,2));
fe5 = zeros((snr_max-snr_min)/2+1,size(mode1,2));
fe6 = zeros((snr_max-snr_min)/2+1,size(mode1,2));
fe7 = zeros((snr_max-snr_min)/2+1,size(mode1,2));
fe8 = zeros((snr_max-snr_min)/2+1,size(mode1,2));

load dataset/data_fe_0
    fe1(1,:)=mean(train_x(1:1500,:),1);
    fe2(1,:)=mean(train_x(1501:3000,:),1);
    fe3(1,:)=mean(train_x(3001:4500,:),1);
    fe4(1,:)=mean(train_x(4501:6000,:),1);
    fe5(1,:)=mean(train_x(6001:7500,:),1);
    fe6(1,:)=mean(train_x(7501:9000,:),1);
    fe7(1,:)=mean(train_x(9001:10500,:),1);
    fe8(1,:)=mean(train_x(10501:12000,:),1);
    
load dataset/data_fe_2
    fe1(2,:)=mean(train_x(1:1500,:),1);
    fe2(2,:)=mean(train_x(1501:3000,:),1);
    fe3(2,:)=mean(train_x(3001:4500,:),1);
    fe4(2,:)=mean(train_x(4501:6000,:),1);
    fe5(2,:)=mean(train_x(6001:7500,:),1);
    fe6(2,:)=mean(train_x(7501:9000,:),1);
    fe7(2,:)=mean(train_x(9001:10500,:),1);
    fe8(2,:)=mean(train_x(10501:12000,:),1);
        
load dataset/data_fe_4
    fe1(3,:)=mean(train_x(1:1500,:),1);
    fe2(3,:)=mean(train_x(1501:3000,:),1);
    fe3(3,:)=mean(train_x(3001:4500,:),1);
    fe4(3,:)=mean(train_x(4501:6000,:),1);
    fe5(3,:)=mean(train_x(6001:7500,:),1);
    fe6(3,:)=mean(train_x(7501:9000,:),1);
    fe7(3,:)=mean(train_x(9001:10500,:),1);
    fe8(3,:)=mean(train_x(10501:12000,:),1);
        
load dataset/data_fe_6
    fe1(4,:)=mean(train_x(1:1500,:),1);
    fe2(4,:)=mean(train_x(1501:3000,:),1);
    fe3(4,:)=mean(train_x(3001:4500,:),1);
    fe4(4,:)=mean(train_x(4501:6000,:),1);
    fe5(4,:)=mean(train_x(6001:7500,:),1);
    fe6(4,:)=mean(train_x(7501:9000,:),1);
    fe7(4,:)=mean(train_x(9001:10500,:),1);
    fe8(4,:)=mean(train_x(10501:12000,:),1);
        
load dataset/data_fe_8
    fe1(5,:)=mean(train_x(1:1500,:),1);
    fe2(5,:)=mean(train_x(1501:3000,:),1);
    fe3(5,:)=mean(train_x(3001:4500,:),1);
    fe4(5,:)=mean(train_x(4501:6000,:),1);
    fe5(5,:)=mean(train_x(6001:7500,:),1);
    fe6(5,:)=mean(train_x(7501:9000,:),1);
    fe7(5,:)=mean(train_x(9001:10500,:),1);
    fe8(5,:)=mean(train_x(10501:12000,:),1);
        
load dataset/data_fe_10
    fe1(6,:)=mean(train_x(1:1500,:),1);
    fe2(6,:)=mean(train_x(1501:3000,:),1);
    fe3(6,:)=mean(train_x(3001:4500,:),1);
    fe4(6,:)=mean(train_x(4501:6000,:),1);
    fe5(6,:)=mean(train_x(6001:7500,:),1);
    fe6(6,:)=mean(train_x(7501:9000,:),1);
    fe7(6,:)=mean(train_x(9001:10500,:),1);
    fe8(6,:)=mean(train_x(10501:12000,:),1);
load dataset/data_fe_12
    fe1(7,:)=mean(train_x(1:1500,:),1);
    fe2(7,:)=mean(train_x(1501:3000,:),1);
    fe3(7,:)=mean(train_x(3001:4500,:),1);
    fe4(7,:)=mean(train_x(4501:6000,:),1);
    fe5(7,:)=mean(train_x(6001:7500,:),1);
    fe6(7,:)=mean(train_x(7501:9000,:),1);
    fe7(7,:)=mean(train_x(9001:10500,:),1);
    fe8(7,:)=mean(train_x(10501:12000,:),1);
        
load dataset/data_fe_14
    fe1(8,:)=mean(train_x(1:1500,:),1);
    fe2(8,:)=mean(train_x(1501:3000,:),1);
    fe3(8,:)=mean(train_x(3001:4500,:),1);
    fe4(8,:)=mean(train_x(4501:6000,:),1);
    fe5(8,:)=mean(train_x(6001:7500,:),1);
    fe6(8,:)=mean(train_x(7501:9000,:),1);
    fe7(8,:)=mean(train_x(9001:10500,:),1);
    fe8(8,:)=mean(train_x(10501:12000,:),1);
        
load dataset/data_fe_16
    fe1(9,:)=mean(train_x(1:1500,:),1);
    fe2(9,:)=mean(train_x(1501:3000,:),1);
    fe3(9,:)=mean(train_x(3001:4500,:),1);
    fe4(9,:)=mean(train_x(4501:6000,:),1);
    fe5(9,:)=mean(train_x(6001:7500,:),1);
    fe6(9,:)=mean(train_x(7501:9000,:),1);
    fe7(9,:)=mean(train_x(9001:10500,:),1);
    fe8(9,:)=mean(train_x(10501:12000,:),1);
        
load dataset/data_fe_18
    fe1(10,:)=mean(train_x(1:1500,:),1);
    fe2(10,:)=mean(train_x(1501:3000,:),1);
    fe3(10,:)=mean(train_x(3001:4500,:),1);
    fe4(10,:)=mean(train_x(4501:6000,:),1);
    fe5(10,:)=mean(train_x(6001:7500,:),1);
    fe6(10,:)=mean(train_x(7501:9000,:),1);
    fe7(10,:)=mean(train_x(9001:10500,:),1);
    fe8(10,:)=mean(train_x(10501:12000,:),1);
        
load dataset/data_fe_20
    fe1(11,:)=mean(train_x(1:1500,:),1);
    fe2(11,:)=mean(train_x(1501:3000,:),1);
    fe3(11,:)=mean(train_x(3001:4500,:),1);
    fe4(11,:)=mean(train_x(4501:6000,:),1);
    fe5(11,:)=mean(train_x(6001:7500,:),1);
    fe6(11,:)=mean(train_x(7501:9000,:),1);
    fe7(11,:)=mean(train_x(9001:10500,:),1);
    fe8(11,:)=mean(train_x(10501:12000,:),1);


n=0:2:20;
for j=[8,9]
%j=8;
figure()
plot(n,fe1(:,j),'bs-')
hold on
grid on
plot(n,fe2(:,j),'ms-')
plot(n,fe3(:,j),'m^-')
plot(n,fe4(:,j),'mo-')
plot(n,fe5(:,j),'ks-')
plot(n,fe6(:,j),'k^-')
plot(n,fe7(:,j),'ko-')
plot(n,fe8(:,j),'rs-')
set(gca,'FontSize',10.5,'Fontname', 'Times New Roman');
l = legend('2-ASK','2-FSK','4-FSK','8-FSK','2-PSK','4-PSK','8-PSK','16-QAM','Location','EastOutside');
xlabel('\fontname{宋体}信噪比\fontname{Times New Roman}(dB)')
ylabel('\fontname{宋体}特征值')
end