%%%%%%%%%%%%%%%%%%%信号的双边幅度频谱%%%%%%%%%%%%%%%%%%%%%%%
function spec(y,fs,rs,N_code)
    n = fs/rs*N_code;
    fshift = (-n/2:n/2-1)*(fs/n);
    y_f=fft(y)*2/n;
    yshift = fftshift(y_f);
    plot(fshift,abs(yshift));
    xlabel('频率/MHz')
    ylabel('幅度')
    grid on
end