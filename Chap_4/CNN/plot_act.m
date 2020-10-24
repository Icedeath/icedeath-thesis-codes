%%%%%%%%%%%%%%%%%%%%%%%¼¤»îº¯Êý%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
n=-6:0.1:6;
sig = 1./(1+exp(-n));
tanh = (exp(n)-exp(-n))./(exp(n)+exp(-n));
figure()
grid on
hold on
box on

plot(n,sig,'r-')
plot(n,tanh,'b--')
xlabel('\fontname{Times New Roman}\it x')
ylabel('\fontname{Times New Roman}\it f \rm(\itx\rm)')
ylim([-1.1,1.1])
legend('\fontname{Times New Roman}Sigmoid', '\fontname{Times New Roman}Tanh')


n1 = -3:0.1:0;

elu1 = 0.5*(exp(n1)-1);
elu = [elu1,0.1:0.1:3];

figure()
grid on
hold on
box on
plot(-3:0.1:3,elu)
xlabel('\fontname{Times New Roman}\it x')
ylabel('\fontname{Times New Roman}\it f \rm(\itx\rm)')
ylim([-3,3])