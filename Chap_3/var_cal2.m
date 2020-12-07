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

vars = zeros(1,25);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%瞬时特征不计算2ASK%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i=1:8
eval(['vars(i)=mean(var(transpose(var_f',num2str(i),'(2:8,:))));'])
end

for i=9:25
eval(['vars(i)=mean(var(transpose(var_f',num2str(i),')));'])
end

vars

