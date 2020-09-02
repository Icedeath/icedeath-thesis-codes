function [a,phi_NL,f]=int_inf(y_f,fc,fs)
y_h=hilbert(y_f);

a=abs(y_h);   %瞬时幅度

phi = atan2(real(y_h),-imag(y_h));



c_k(1)=0;%修正相位序列
for i=2:length(phi)
    if phi(i)-phi(i-1)>pi
        c_k(i)=c_k(i-1)-2*pi;
    elseif phi(i-1)-phi(i)>pi
        c_k(i)=c_k(i-1)+2*pi;
    else c_k(i)=c_k(i-1);
    end
end

phi_uw=phi+c_k;

phi_NL=phi_uw-2*pi*((1:length(phi))-1)*fc/fs;%去掉线性分量的瞬时相位
phi_NL=mod(phi_NL,2*pi);
f(1)=fs*(phi_NL(2)-phi_NL(1))/(2*pi);
f(2:length(phi_NL))=fs*diff(phi_NL)/(2*pi);
for i=1:length(f)
    if i==1 && abs(f(i))/fs>0.9
        f(i)=f(i+10);
    elseif abs(f(i))/fs>0.9  %相位差=2pi处修正为无变化
        f(i)=f(i-1);
    end
end
for i=1:length(f)
    if f(i)>5  %5为频率上下限
        f(i)=5;
    elseif f(i)<-5
        f(i)=-5;
    end
end
