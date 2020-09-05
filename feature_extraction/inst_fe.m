%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%��ȡ�źŵ�˲ʱ����%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [r_max,E,m_A,sigma_aa,sigma_ap,sigma_dp,sigma_af,P_max]=inst_fe(y,fc,fs,rs)
[a,phi_NL,f]=int_inf(y,fc,fs);


%��gamma_max�����Ĺ�һ��˲ʱ���ȹ������ܶȵ����ֵ
m_a=mean(a);%��˲ʱ���ȵ�ƽ��ֵ
a_n=a/m_a;
a_cn=a_n-1;%���һ������˲ʱ����
r_max=max((abs(fft(a_cn))).^2)/length(a);

%��E���Ȱ���ı�׼��
E=sqrt(sum((a-m_a).^2)/(length(a)-1));

%��m_A
m_A=var(a)/m_a^2;

%��sigma_aa��һ������˲ʱ���Ⱦ���ֵ�ı�׼ƫ��
sigma_aa=sqrt(mean(a_cn.^2)-(mean(abs(a_cn)))^2);

%��sigma_ap˲ʱ��λ�����ķ����Է����ľ���ֵ�ı�׼ƫ��
feiruoduan_phi_NL=phi_NL(find(a_n>1));%���΢�����μ�����an>aopt=1(��ѹ�һ����������ֵ)��Ӧ��˲ʱ��λֵ
feiruoduan_phi_NL_phase1=feiruoduan_phi_NL-mean(feiruoduan_phi_NL);%�����Ļ�
sigma_ap=sqrt(mean(feiruoduan_phi_NL_phase1.^2)-(mean(abs(feiruoduan_phi_NL_phase1)))^2);

%��sigma_dp˲ʱ��λֱ��ֵ�����ķ����Է����ı�׼ƫ��
sigma_dp=sqrt(mean(feiruoduan_phi_NL_phase1.^2)-(mean(feiruoduan_phi_NL_phase1))^2);

%��sigma_af��һ������˲ʱƵ�ʵľ���ֵ�ı�׼ƫ��
m_f=mean(f);%��˲ʱƵ�ʵ�ƽ��ֵ
feiruoduan_f_frequency=f(find(a_n>1));
feiruoduan_f_frequency1=feiruoduan_f_frequency-m_f;%�����Ļ�
f_N=feiruoduan_f_frequency1/rs;
sigma_af=sqrt(mean(f_N.^2)-(mean(abs(f_N)))^2);

%��Pmax��һ�������׵����ֵ
P=abs(fft(y));
P_max=max(P/sum(P));
