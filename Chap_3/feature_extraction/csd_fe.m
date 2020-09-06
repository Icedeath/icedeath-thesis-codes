function [R1,R2,R3,Beta,P]=csd_fe(y,fs,fc)
df=2.5;
dalpha=0.05;
%AUTOFAM ѭ���׼���%

% Definition of Parameters %
Np = pow2(nextpow2(fs/df));
L = Np/4;
P = pow2(nextpow2(fs/dalpha/L));
N = P*L;

% Input Channelization %
if length(y) < N
    y(N) = 0;
elseif length(y) > N
    y = y(1:N);
end

NN = (P-1)*L+Np;
xx = y;
xx(NN) = 0;
xx = xx(:);
X = zeros(Np,P);

for k=0:P-1
    X(:,k+1) = xx(k*L+1:k*L+Np); 
end

% Windowing %
a = hamming(Np);
XW = diag(a)*X; 
% XW = X; %I think this sentence should be kicked out.

% First FFT %
XF1 = fft(XW);
XF1 = fftshift(XF1);
XF1 = [XF1(:,P/2+1:P) XF1(:,1:P/2)];

% Downconversion %
E = zeros(Np,P);

for k = -Np/2:Np/2-1
    for m = 0:P-1
        E(k+Np/2+1,m+1) = exp(-i*2*pi*k*m*L/Np);
    end
end

XD = XF1.*E;
XD = conj(XD');

% Multiplication %
XM = zeros(P,Np^2);

for k = 1:Np
    for q = 1:Np
        XM(:,(k-1)*Np+q) = (XD(:,k).*conj(XD(:,q)));
    end
end

% Second FFT %
XF2 = fft(XM);
XF2 = fftshift(XF2);
XF2 = [XF2(:,Np^2/2+1:Np^2) XF2(:,1:Np^2/2)];
XF2 = XF2(P/4:3*P/4,:);
M = abs(XF2); %Absolute value and complex magnitude
alphao = (-1:1/N:1)*fs;
fo = (-.5:1/Np:.5)*fs;
Sx = zeros(Np+1,2*N+1);

for k1 = 1:P/2+1
    for k2 = 1:Np^2
        if rem(k2,Np) == 0
            q = Np/2-1; %increase 1
        else
            q = rem(k2,Np)-Np/2-1; %increase 1
        end
        k = ceil(k2/Np)-Np/2-1; %increase 1
        p = k1-P/4-1;
        alpha = (k-q)/Np+(p-1)/L/P;
        f = (k+q)/2/Np;
        if alpha < -1 || alpha > 1
            k2 = k2+1;
        elseif f < -.5 || f > .5
            k2 = k2+1;
        elseif rem(k+q,2)==0
            kk = 1+Np*(f+.5);
            ll = 1+N*(alpha+1);
            Sx(kk,ll) = M(k1,k2); 
        end
    end
end 
Sx = Sx./max(max(Sx)); % Normalizes the magnitudes of the values in output matrix (maximum = 1)

% %ѭ������άͼ
% figure(1);mesh(alphao,fo,Sx);ylabel('Frequency(Hz)');xlabel('Cycle frequency(Hz)');title('ѭ������άͼ');
% 
% %��=0����ѭ����
% Sx_a_0=Sx(:,N+1);
% figure(2);plot(fo,Sx_a_0);xlabel('Frequency(Hz)');
% 
% %f=0����ѭ����
% Sx_f_0=Sx(Np/2+1,:);
% figure(3);plot(alphao,Sx_f_0);xlabel('Cycle frequency(Hz)');
% 
% %f=fc����ѭ����
% Sx_f_fc=Sx(Np/2+1+round(fc/(fs/Np)),:);
% figure(4);plot(alphao,Sx_f_fc);xlabel('Cycle frequency(Hz)');




%Sx��(f=0)�����ѭ���׷��Ȱ��緽��R1
R1=1/var(Sx(Np/2+1,:));

%Sx��(f=fc)�����ѭ���׷��Ȱ��緽��R2
R2=1/var(Sx(Np/2+1+round(fc/(fs/Np)),:));

%Sx��(f=0)�����ѭ���׷��Ȱ����ֵR3
R3=1/mean(Sx(Np/2+1,:));

%������Sx��(f=0)��һ�������ֵ��:�ڦ����ϵ�����ص����ֵ����f���ϵ�����ص����ֵ�ı�ֵ
Beta=max(Sx(Np/2+1,:))/max(Sx(:,N+1));

%������Sx2fc(f)��f������ֵ���ƽ��������P
P=sum(Sx(:,N+1+round(2*fc/(fs/N))).^2);