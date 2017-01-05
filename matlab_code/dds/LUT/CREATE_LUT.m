close all; clear all; clc;
index = 0;
K =16;M = 16;
LUT = logical(zeros(2^(K-2),M));
for index=1:1:2^(K-2)
    phase = (index-1)/2^(K-2)+2^(-K+1);
    LUT(index,:) = dectobin(round(sin(phase*0.5*pi)*2^(M-1)),M);
end
save LUT_K16_M16 LUT;