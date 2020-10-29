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




for i=1:(snr_max-snr_min)/2+1
    fe1(i,:) = mean(mode1((i-1)*N_samples+1:(i-1)*N_samples+N_samples,:),1);
    fe2(i,:) = mean(mode2((i-1)*N_samples+1:(i-1)*N_samples+N_samples,:),1);
    fe3(i,:) = mean(mode3((i-1)*N_samples+1:(i-1)*N_samples+N_samples,:),1);
    fe4(i,:) = mean(mode4((i-1)*N_samples+1:(i-1)*N_samples+N_samples,:),1);
    fe5(i,:) = mean(mode5((i-1)*N_samples+1:(i-1)*N_samples+N_samples,:),1);
    fe6(i,:) = mean(mode6((i-1)*N_samples+1:(i-1)*N_samples+N_samples,:),1);
    fe7(i,:) = mean(mode7((i-1)*N_samples+1:(i-1)*N_samples+N_samples,:),1);
    fe8(i,:) = mean(mode8((i-1)*N_samples+1:(i-1)*N_samples+N_samples,:),1);
end



n=0:2:20;
for j=1:25
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
l = legend('2-ASK','2-FSK','4-FSK','8-FSK','2-PSK','4-PSK','8-PSK','16-QAM');
xlabel('\fontname{宋体}信噪比\fontname{Times New Roman}/dB')
ylabel('\fontname{宋体}信噪比\fontname{Times New Roman}/dB')
end