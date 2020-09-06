function [r_max,E,m_A,sigma_aa,sigma_ap,sigma_dp,sigma_af,P_max,d_1,d_2,d_3,d_4,d_5,d_6,d_7]=featuressgj_extraction(yr,fc,fs,fd)

%%%%%%%˲ʱ����%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%���ź����е�ϣ�����ر任
hyr=hilbert(yr);

%��˲ʱ����
a_amplitude=abs(hyr);

%��˲ʱ��λ
phi_phase=angle(hyr);
c_k(1)=0;%������λ����
for i=2:length(phi_phase)
    if phi_phase(i)-phi_phase(i-1)>pi
        c_k(i)=c_k(i-1)-2*pi;
    elseif phi_phase(i-1)-phi_phase(i)>pi
        c_k(i)=c_k(i-1)+2*pi;
    else c_k(i)=c_k(i-1);
    end
end
c_k;
phi_uw_phase=phi_phase+c_k;%ȥ�����λ
phi_NL_phase=phi_uw_phase-2*pi*((1:length(phi_phase))-1)*fc/fs;%ȥ��λ���Է�����������˲ʱ��λ
phi_NL_phase1=mod(phi_NL_phase,2*pi);
for i=1:length(phi_NL_phase)
    if phi_NL_phase1(i)>1.9*pi
        phi_NL_phase2(i)=phi_NL_phase1(i)-2*pi;
    else phi_NL_phase2(i)=phi_NL_phase1(i);
    end
end

%��˲ʱƵ��
f_frequency(1)=fs*(phi_NL_phase(2)-phi_NL_phase(1))/(2*pi);
f_frequency(2:length(phi_NL_phase))=fs*diff(phi_NL_phase)/(2*pi);
% f_frequency=fs/(2*pi)*diff(phi_NL_phase);
% for i=1:(length(phi_phase)-1)
%     f_frequency(i)=fs/(2*pi)*(phi_NL_phase(i)-phi_NL_phase(i-1));%��ַ���˲ʱƵ��
% end


%��gamma_max�����Ĺ�һ��˲ʱ���ȹ������ܶȵ����ֵ
m_a=mean(a_amplitude);%��˲ʱ���ȵ�ƽ��ֵ
a_n=a_amplitude/m_a;
a_cn=a_n-1;%���һ������˲ʱ����
r_max=max((abs(fft(a_cn))).^2)/length(a_amplitude);

%��E���Ȱ���ı�׼��
E=sqrt(sum((a_amplitude-m_a).^2)/(length(a_amplitude)-1));

%��m_A
m_A=var(a_amplitude)/m_a^2;

%��sigma_aa��һ������˲ʱ���Ⱦ���ֵ�ı�׼ƫ��
sigma_aa=sqrt(mean(a_cn.^2)-(mean(abs(a_cn)))^2);

%��sigma_ap˲ʱ��λ�����ķ����Է����ľ���ֵ�ı�׼ƫ��
feiruoduan_phi_NL_phase=phi_NL_phase2(find(a_n>1));%���΢�����μ�����an>aopt=1(��ѹ�һ����������ֵ)��Ӧ��˲ʱ��λֵ
feiruoduan_phi_NL_phase1=feiruoduan_phi_NL_phase-mean(phi_NL_phase2);%�����Ļ�
sigma_ap=sqrt(mean(feiruoduan_phi_NL_phase1.^2)-(mean(abs(feiruoduan_phi_NL_phase1)))^2);

%��sigma_dp˲ʱ��λֱ��ֵ�����ķ����Է����ı�׼ƫ��
sigma_dp=sqrt(mean(feiruoduan_phi_NL_phase1.^2)-(mean(feiruoduan_phi_NL_phase1))^2);

%��sigma_af��һ������˲ʱƵ�ʵľ���ֵ�ı�׼ƫ��
m_f=mean(f_frequency);%��˲ʱƵ�ʵ�ƽ��ֵ
feiruoduan_f_frequency=f_frequency(find(a_n>1));
feiruoduan_f_frequency1=feiruoduan_f_frequency-m_f;%�����Ļ�
f_N=feiruoduan_f_frequency1/fd;
sigma_af=sqrt(mean(f_N.^2)-(mean(abs(f_N)))^2);

%��Pmax��һ�������׵����ֵ
P=abs(fft(yr));
P_max=max(P/sum(P));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%�߽��ۻ�������%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
data=a_amplitude.*exp(1j*phi_NL_phase);
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
% d_8=abs(C60)^2;
% d_9=abs(C63)^2;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%