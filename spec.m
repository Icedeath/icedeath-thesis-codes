%%%%%%%%%%%%%%%%%%%�źŵ�˫�߷���Ƶ��%%%%%%%%%%%%%%%%%%%%%%%
function spec(y,fs,rs,N_code)
    n = fs/rs*N_code;
    fshift = (-n/2:n/2-1)*(fs/n);
    y_f=fft(y)*2/n;
    yshift = fftshift(y_f);
    plot(fshift,abs(yshift));
    xlabel('Ƶ��/MHz')
    ylabel('����')
    grid on
end