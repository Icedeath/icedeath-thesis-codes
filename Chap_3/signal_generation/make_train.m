clear all
clc
load ../dataset/fe_15

n_tr=5;
n_te=1000;

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
train_y=[try1(1:n_tr,:);try2(1:n_tr,:);try3(1:n_tr,:);try4(1:n_tr,:);try5(1:n_tr,:)...
    ;try6(1:n_tr,:);try7(1:n_tr,:);try8(1:n_tr,:)];
test_y=[try1(N_samples-n_te+1:N_samples,:);try2(N_samples-n_te+1:N_samples,:);try3(N_samples-n_te+1:N_samples,:);try4(N_samples-n_te+1:N_samples,:);try5(N_samples-n_te+1:N_samples,:)...
    ;try6(N_samples-n_te+1:N_samples,:);try7(N_samples-n_te+1:N_samples,:);try8(N_samples-n_te+1:N_samples,:)];
for snr = snr_min:2:snr_max
    trx1 = mode1((snr-snr_min)*N_samples+1:(snr-snr_min)*N_samples+N_samples,:);
    trx2 = mode4((snr-snr_min)*N_samples+1:(snr-snr_min)*N_samples+N_samples,:);
    trx3 = mode5((snr-snr_min)*N_samples+1:(snr-snr_min)*N_samples+N_samples,:);
    trx4 = mode6((snr-snr_min)*N_samples+1:(snr-snr_min)*N_samples+N_samples,:);
    trx5 = mode7((snr-snr_min)*N_samples+1:(snr-snr_min)*N_samples+N_samples,:);
    trx6 = mode8((snr-snr_min)*N_samples+1:(snr-snr_min)*N_samples+N_samples,:);
    trx7 = mode9((snr-snr_min)*N_samples+1:(snr-snr_min)*N_samples+N_samples,:);
    trx8 = mode10((snr-snr_min)*N_samples+1:(snr-snr_min)*N_samples+N_samples,:);
    train_x=[trx1(1:n_tr,:);trx2(1:n_tr,:);trx3(1:n_tr,:);trx4(1:n_tr,:);trx5(1:n_tr,:)...
    ;trx6(1:n_tr,:);trx7(1:n_tr,:);trx8(1:n_tr,:)];
    test_x=[trx1(N_samples-n_te+1:N_samples,:);trx2(N_samples-n_te+1:N_samples,:);trx3(N_samples-n_te+1:N_samples,:);trx4(N_samples-n_te+1:N_samples,:);trx5(N_samples-n_te+1:N_samples,:)...
    ;trx6(N_samples-n_te+1:N_samples,:);trx7(N_samples-n_te+1:N_samples,:);trx8(N_samples-n_te+1:N_samples,:)];
    a=strcat('Saving data_fe_',num2str(snr),'.mat...');
    disp(a)
    
    for i = 1:25
        m = mean(train_x(:,i));
        train_x(:,i)=train_x(:,i)/m-1;
        test_x(:,i)=test_x(:,i)/m-1;
    end
    save(strcat('../dataset/data_fe_',num2str(snr)),'train_x','train_y','test_x','test_y', 'N_samples','snr_max','snr_min','N_code')
end