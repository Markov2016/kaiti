close all;
clear all;clc;
addpath('./test_1/','./LUT/','./tool/');
%% 仿真输入：频率、初始相移
fs = 10^10; % system clock frequacy
ft = round(2^23*(1-0.5*rand())); % output sinwave frequance
offset = 0;   % initial phase offset
point = 4096; % simulation points
%% 寄存器长度
global N;N = 16; %adder bits
global K;K = 16; %trunc bits
global M;M = 16; %DAC   bits
%% 仿真输出：相位、正弦波
global PHASE;    %PHASE register
fcw = round(2^(N)*ft/fs); %frequancy control word(dec)
FCW = dectobin(fcw,N);%frequancy control word(binary)
PHASE = dectobin(round(2^(N)*offset),N); %PHASE initial
Phase = logical(zeros(point,N)); % phase time array
Out = logical(zeros(point,M)); % sinwave output array
phase = zeros(point,1);out = zeros(point,1);
%% 主函数
% 初始化
Phase(1,:) = PHASE;
Out(1,:) = PAC();
phase(1) = bintodec(Phase(1,:),N)/2+2^(-N);
out(1) = bintodec(Out(1,:),M);
% 生成
for i = 2:1:point
   % PA + PAC
   Phase(i,:) = PA(FCW);
   Out(i,:) = PAC();
   % bin -> dec
   phase(i) = bintodec(Phase(i,:),N)/2+2^(-N);
   out(i) = bintodec(Out(i,:),M);
end
%% display
figure();
phase_line = phase(1):ft/fs:(phase(1)+ft/fs*(point-1));
plot(phase_line,out,'b.-');
xlabel('Phase (2\pi)');ylabel('Amptitude');
samplerate = fs/10^9;
SpectrumIdentify(out',samplerate/2,samplerate,1,1)
xlabel('Frequency (GHz)');ylabel('S(f)')


