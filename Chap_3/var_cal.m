%%%%%%%%%%%%%%%%%%%%%%∑Ω≤Óº∆À„%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all
clc
load ./dataset/fe_plot
for i=1:25
    eval(['var_f',num2str(i),'=zeros(8,11);'])
end

for i=1:8
        for k=1:25
            eval(['var_f',num2str(k),'(i,:)=transpose(fe',num2str(i),'(:,k));'])
        end    
end

var = zeros(1,25);
for i=1:25
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