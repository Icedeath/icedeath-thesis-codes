%%%%%%%%%%%%%%%%%%%%%%方差计算%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all
clc
load ./dataset/fe_plot2
for i=1:25
    eval(['var_f',num2str(i),'=zeros(8,11);'])
end

for i=1:8
        for k=1:25
            eval(['var_f',num2str(k),'(i,:)=transpose(fe',num2str(i),'(:,k));'])
        end    
end

var = zeros(1,25);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%瞬时特征不计算2ASK%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i=1:8
eval(['var(i)=varf(var_f',num2str(i),'(2:8,:));'])
end

for i=9:25
eval(['var(i)=varf(var_f',num2str(i),');'])
end

var


function varff = varf(var_f)
varff = zeros(1,8);
for i=1:size(var_f,1)
    varff(i)=var(var_f(i,:)/mean(var_f,'all')-1);
end
varff = mean(varff);
end