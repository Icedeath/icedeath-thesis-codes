clear all

load fe_0
y = y + 1;
for i = 1:15
    eval(['fe',num2str(i),'=fe(y==',num2str(i),',:);']);
    
end
