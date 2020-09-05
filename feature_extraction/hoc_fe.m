function [d_1,d_2,d_3,d_4,d_5,d_6,d_7]=hoc_fe(y,fc,fs)
[a,phi_NL,~]=int_inf(y,fc,fs);
data=a.*exp(1j*phi_NL);
% data=data./norm(data);
M20=mean(data.^2);
M21=mean(data.*conj(data));
M40=mean(data.^4);
M41=mean(data.^3.*conj(data));
M42=mean((data.^2).*(conj(data).^2));
M60=mean(data.^6);
M63=mean(data.^3.*(conj(data).^3));

C20=M20;
C21=M21;
C40=M40-3*M20^2;
C41=M41-3*M21*M20;
C42=M42-abs(M20)^2-2*M21^2;
C60=M60-15*M40*M20+30*M20^3;
C63=M63-9*C42*C21-6*C21^3;

d_1=abs(C40)/abs(C42);
d_2=abs(C41)/abs(C42);    
d_3=abs(C42)/abs(C21)^2;
d_4=abs(C60)/abs(C21)^3;
d_5=abs(C63)/abs(C21)^3;
d_6=abs(C60)^2/abs(C42)^3;
d_7=abs(C63)^2/abs(C42)^3;