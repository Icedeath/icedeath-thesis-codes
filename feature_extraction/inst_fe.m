%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%提取信号的瞬时特征%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [r_max,E,m_A,sigma_aa,sigma_ap,sigma_dp,sigma_af,P_max]=inst_fe(y,fc,fs,rs)
[a,phi_NL,f]=int_inf(y,fc,fs);


%求gamma_max零中心归一化瞬时幅度功率谱密度的最大值
m_a=mean(a);%求瞬时幅度的平均值
a_n=a/m_a;
a_cn=a_n-1;%求归一化中心瞬时幅度
r_max=max((abs(fft(a_cn))).^2)/length(a);

%求E幅度包络的标准差
E=sqrt(sum((a-m_a).^2)/(length(a)-1));

%求m_A
m_A=var(a)/m_a^2;

%求sigma_aa归一化中心瞬时幅度绝对值的标准偏差
sigma_aa=sqrt(mean(a_cn.^2)-(mean(abs(a_cn)))^2);

%求sigma_ap瞬时相位的中心非线性分量的绝对值的标准偏差
feiruoduan_phi_NL=phi_NL(find(a_n>1));%求非微弱区段即满足an>aopt=1(最佳归一化幅度门限值)对应的瞬时相位值
feiruoduan_phi_NL_phase1=feiruoduan_phi_NL-mean(feiruoduan_phi_NL);%零中心化
sigma_ap=sqrt(mean(feiruoduan_phi_NL_phase1.^2)-(mean(abs(feiruoduan_phi_NL_phase1)))^2);

%求sigma_dp瞬时相位直接值的中心非线性分量的标准偏差
sigma_dp=sqrt(mean(feiruoduan_phi_NL_phase1.^2)-(mean(feiruoduan_phi_NL_phase1))^2);

%求sigma_af归一化中心瞬时频率的绝对值的标准偏差
m_f=mean(f);%求瞬时频率的平均值
feiruoduan_f_frequency=f(find(a_n>1));
feiruoduan_f_frequency1=feiruoduan_f_frequency-m_f;%零中心化
f_N=feiruoduan_f_frequency1/rs;
sigma_af=sqrt(mean(f_N.^2)-(mean(abs(f_N)))^2);

%求Pmax归一化功率谱的最大值
P=abs(fft(y));
P_max=max(P/sum(P));
