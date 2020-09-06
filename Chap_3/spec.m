%%%%%%%%%%%%%%%%%%%信号的双边幅度频谱%%%%%%%%%%%%%%%%%%%%%%%
function spec(y,fs,rs,N_code)
    n = fs/rs*N_code;
    fshift = (-n/2:n/2-1)*(fs/n);
    y_f=fft(y)*2/n;
    yshift = fftshift(y_f);
    plot(fshift,abs(yshift));
    set(gca,'FontSize',10.5,'Fontname', 'Times New Roman');
    xlabel('\fontname{宋体}频率/\fontname{Times New Roman}MHz')
    ylabel('\fontname{宋体}幅度')
    grid on
end