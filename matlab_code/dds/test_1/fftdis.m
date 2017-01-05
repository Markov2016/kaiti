function [ y ] = fftdis( fs,x,color )
L = length(x);
NFFT = 2^nextpow2(L); % Next power of 2 from length of y
y = fft(x,NFFT)/L;
y=abs(y(1:NFFT/2+1));
f = fs/2*linspace(0,1,NFFT/2+1);
y(y == 0) = max(y)*10^(-8);
% Plot single-sided amplitude spectrum.
switch color
    case 1
        plot(f,10*log10(2*y.^2),'r');
    case 2
        plot(f,10*log10(2*y.^2),'g');
    case 3
        plot(f,10*log10(2*y.^2),'b');
end
        
end