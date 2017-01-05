function [WAVE] = LUT1(index)
global K;global M;
Index = logical(zeros(1,K));Index(1:K-2) = index;
phase = bintodec(Index,K);
wave = sin(phase*pi);
WAVE = dectobin(round(wave*2^(M-1)),M);
end