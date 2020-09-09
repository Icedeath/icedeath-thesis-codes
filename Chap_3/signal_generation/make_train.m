clear all
clc
load ../dataset/data_fe

tr1 = zeros(N_samples,25);
tr2 = zeros(N_samples,25);
tr3 = zeros(N_samples,25);
tr4 = zeros(N_samples,25);
tr5 = zeros(N_samples,25);
tr6 = zeros(N_samples,25);
tr7 = zeros(N_samples,25);
tr8 = zeros(N_samples,25);

try1 = zeros(N_samples,1);
try2 = ones(N_samples,1);
try3 = ones(N_samples,1)*2;
try4 = ones(N_samples,1)*3;
try5 = ones(N_samples,1)*4;
try6 = ones(N_samples,1)*5;
try7 = ones(N_samples,1)*6;
try8 = ones(N_samples,1)*7;
train_y=[try1(1:1500,:);try2(1:1500,:);try3(1:1500,:);try4(1:1500,:);try5(1:1500,:)...
    ;try6(1:1500,:);try7(1:1500,:);try8(1:1500,:)];
test_y=[try1(1501:2000,:);try2(1501:2000,:);try3(1501:2000,:);try4(1501:2000,:);try5(1501:2000,:)...
    ;try6(1501:2000,:);try7(1501:2000,:);try8(1501:2000,:)];
for snr = snr_min:2:snr_max
    trx1 = mode1((snr-snr_min)/2*N_samples+1:(snr-snr_min)/2*N_samples+N_samples,:);
    trx2 = mode2((snr-snr_min)/2*N_samples+1:(snr-snr_min)/2*N_samples+N_samples,:);
    trx3 = mode3((snr-snr_min)/2*N_samples+1:(snr-snr_min)/2*N_samples+N_samples,:);
    trx4 = mode4((snr-snr_min)/2*N_samples+1:(snr-snr_min)/2*N_samples+N_samples,:);
    trx5 = mode5((snr-snr_min)/2*N_samples+1:(snr-snr_min)/2*N_samples+N_samples,:);
    trx6 = mode6((snr-snr_min)/2*N_samples+1:(snr-snr_min)/2*N_samples+N_samples,:);
    trx7 = mode7((snr-snr_min)/2*N_samples+1:(snr-snr_min)/2*N_samples+N_samples,:);
    trx8 = mode8((snr-snr_min)/2*N_samples+1:(snr-snr_min)/2*N_samples+N_samples,:);
    train_x=[trx1(1:1500,:);trx2(1:1500,:);trx3(1:1500,:);trx4(1:1500,:);trx5(1:1500,:)...
    ;trx6(1:1500,:);trx7(1:1500,:);trx8(1:1500,:)];
    test_x=[trx1(1501:2000,:);trx2(1501:2000,:);trx3(1501:2000,:);trx4(1501:2000,:);trx5(1501:2000,:)...
    ;trx6(1501:2000,:);trx7(1501:2000,:);trx8(1501:2000,:)];
    a=strcat('Saving data_fe_',num2str(snr),'.mat...');
    disp(a)
    for i = 1:25
        train_x(:,i)=train_x(:,i)/mean(train_x(:,i))-1;
        test_x(:,i)=test_x(:,i)/mean(test_x(:,i))-1;
    end
    save(strcat('../dataset/data_fe_',num2str(snr)),'train_x','train_y','test_x','test_y', 'N_samples','snr_max','snr_min','N_code')
end