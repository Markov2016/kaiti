function [WAVE] = LUT_TABLE(Index)
load LUT_K16_M16;
global K;
temp = reshape(0:1:K-3,K-2,1);
index = 1+ double(Index) * (2.^temp);
WAVE = LUT(index,:);
end