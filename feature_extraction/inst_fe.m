%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%��ȡ�źŵ�˲ʱ����%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [r_max,E,m_A,sigma_aa,sigma_ap,sigma_dp,sigma_af,P_max]=inst_fe(yr,fc,fs,fd)
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
