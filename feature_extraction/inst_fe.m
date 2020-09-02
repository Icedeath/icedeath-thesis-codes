%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%提取信号的瞬时特征%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [r_max,E,m_A,sigma_aa,sigma_ap,sigma_dp,sigma_af,P_max]=inst_fe(yr,fc,fs,fd)
%求信号序列的希尔伯特变换
hyr=hilbert(yr);

%求瞬时幅度
a_amplitude=abs(hyr);

%求瞬时相位
phi_phase=angle(hyr);
c_k(1)=0;%修正相位序列
for i=2:length(phi_phase)
    if phi_phase(i)-phi_phase(i-1)>pi
        c_k(i)=c_k(i-1)-2*pi;
    elseif phi_phase(i-1)-phi_phase(i)>pi
        c_k(i)=c_k(i-1)+2*pi;
    else c_k(i)=c_k(i-1);
    end
end
c_k;
phi_uw_phase=phi_phase+c_k;%去卷叠相位
phi_NL_phase=phi_uw_phase-2*pi*((1:length(phi_phase))-1)*fc/fs;%去相位线性分量后真正的瞬时相位
phi_NL_phase1=mod(phi_NL_phase,2*pi);
for i=1:length(phi_NL_phase)
    if phi_NL_phase1(i)>1.9*pi
        phi_NL_phase2(i)=phi_NL_phase1(i)-2*pi;
    else phi_NL_phase2(i)=phi_NL_phase1(i);
    end
end

%求瞬时频率
f_frequency(1)=fs*(phi_NL_phase(2)-phi_NL_phase(1))/(2*pi);
f_frequency(2:length(phi_NL_phase))=fs*diff(phi_NL_phase)/(2*pi);
% f_frequency=fs/(2*pi)*diff(phi_NL_phase);
% for i=1:(length(phi_phase)-1)
%     f_frequency(i)=fs/(2*pi)*(phi_NL_phase(i)-phi_NL_phase(i-1));%差分法求瞬时频率
% end


%求gamma_max零中心归一化瞬时幅度功率谱密度的最大值
m_a=mean(a_amplitude);%求瞬时幅度的平均值
a_n=a_amplitude/m_a;
a_cn=a_n-1;%求归一化中心瞬时幅度
r_max=max((abs(fft(a_cn))).^2)/length(a_amplitude);

%求E幅度包络的标准差
E=sqrt(sum((a_amplitude-m_a).^2)/(length(a_amplitude)-1));

%求m_A
m_A=var(a_amplitude)/m_a^2;

%求sigma_aa归一化中心瞬时幅度绝对值的标准偏差
sigma_aa=sqrt(mean(a_cn.^2)-(mean(abs(a_cn)))^2);

%求sigma_ap瞬时相位的中心非线性分量的绝对值的标准偏差
feiruoduan_phi_NL_phase=phi_NL_phase2(find(a_n>1));%求非微弱区段即满足an>aopt=1(最佳归一化幅度门限值)对应的瞬时相位值
feiruoduan_phi_NL_phase1=feiruoduan_phi_NL_phase-mean(phi_NL_phase2);%零中心化
sigma_ap=sqrt(mean(feiruoduan_phi_NL_phase1.^2)-(mean(abs(feiruoduan_phi_NL_phase1)))^2);

%求sigma_dp瞬时相位直接值的中心非线性分量的标准偏差
sigma_dp=sqrt(mean(feiruoduan_phi_NL_phase1.^2)-(mean(feiruoduan_phi_NL_phase1))^2);

%求sigma_af归一化中心瞬时频率的绝对值的标准偏差
m_f=mean(f_frequency);%求瞬时频率的平均值
feiruoduan_f_frequency=f_frequency(find(a_n>1));
feiruoduan_f_frequency1=feiruoduan_f_frequency-m_f;%零中心化
f_N=feiruoduan_f_frequency1/fd;
sigma_af=sqrt(mean(f_N.^2)-(mean(abs(f_N)))^2);

%求Pmax归一化功率谱的最大值
P=abs(fft(yr));
P_max=max(P/sum(P));
