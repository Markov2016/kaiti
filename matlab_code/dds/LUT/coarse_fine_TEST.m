close all; clear all; clc;
K = 16;d = 0;
%% create diff
% index = 1;
% Phase = zeros(2^(K-d-1),K);
% v_r = zeros(1,2^(K-d-1));
% for i = 1:2^(K-d-1)-1
%     Phase(i,:) = dectobin(i*2^d,K);
%     v_r(i) = sin(i/2^(K-d-1)*pi/2);
% end
% diff = zeros(9,2^(K-d-1));
% for i = 1:2^(K-d-1)-1
%     phase = Phase(i,:);
%     for a = 5:1:7
%         for b = 5:1:7
%             c = K-a-b; 
%             C = phase(1:c);
%             B = phase(c+1:c+b);
%             A = phase(b+c+1:end);
%             coarse = sin(bintodec([B,A],a+b)*pi/2);
%             fine = cos(bintodec(A,a)*pi/2)*sin(bintodec([C,logical(zeros(1,a+b))],a+b+c)*pi/2);
%             diff((a-5)*3+b-4,i) = v_r(i) - coarse -fine;
%         end
%     end
% end
% save diff_cd diff
%% test
addpath('./test_1/');
load('diff_cd.mat');
samplerate = 10;
for a = 5:7
    for b = 5:7
        SFDR = SpectrumIdentify(diff((a-5)*2+b-4,:),samplerate/2,samplerate,1,1) ;
        area = 2^(a+b-K)+2^(-b);
    end
end