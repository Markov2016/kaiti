function [ output ] = quantizatoin( input,P)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
output=round(input*2^P)*2^(-P);
end

