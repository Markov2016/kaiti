clear all;close all;clc;
N = 32;
P = 14;
M = 5;
T=2^N;
fs=2^32;
delta=2^25;
fo=fs/T*delta;

point=256;
phase = zeros(1,point+1);
k=1;
out=zeros(1,point);out_q=zeros(1,point);out_q_d=zeros(1,point);
noise = wgn(1,point,12);
while(k <= point)
    a=quantizatoin(noise(k)/1,N-P);
    phase_q = quantizatoin(phase(k),P);
    phase_q_d = quantizatoin(phase(k)+a,P)-quantizatoin(a,P);
    out_q(k) = quantizatoin(sin(2*pi*phase_q),M);
    out_q_d(k) = quantizatoin(sin(2*pi*phase_q_d),M);
    out(k) = quantizatoin(sin(2*pi*phase(k)),M);
    phase(k+1) = phase(k) + delta/T;
    k=k+1;
end
phase = phase(1:point);
figure();
plot(phase,out,'r');hold on;
plot(phase,out_q,'g');hold on;
plot(phase,out_q-out,'b');
title('Quantization Compare')
xlabel('Phase (2*pi)')
ylabel('y(t)')
legend('Sin','Sin wiith Quantization','Quantization Error')

figure();
plot(phase,out,'r');hold on;
plot(phase,out_q_d,'g');hold on;
plot(phase,out_q_d-out,'b');
title('Quantization Compare')
xlabel('Phase (2*pi)')
ylabel('y(t)')
legend('Sin','Sin wiith Quantization && dither','Quantization Error')

figure();
fftdis(fs,out,1);hold on;
fftdis(fs,out_q,2);
title('Single-Sided Power Spectrum (dB)')
xlabel('Frequency (Hz)')
ylabel('S(f)')
legend('Sin','Sin wiith Quantization')

figure();
fftdis(fs,out,1);hold on;
fftdis(fs,out_q_d,2);
title('Single-Sided Power Spectrum (dB)')
xlabel('Frequency (Hz)')
ylabel('S(f)')
legend('Sin','Sin wiith Quantization && dither')

