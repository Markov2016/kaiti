clear all;close all;clc;
addpath('./test_1/');
fid = fopen('data_out.txt','r');
out = zeros(1,4096);
for i = 1:4096
    out(i) = fscanf(fid,'%x',1);
    if(out(i) >= 32768)
        out(i) = -(65536-out(i));
    end
end
figure();
plot(1:4096,out);
samplerate = 10;
SpectrumIdentify(out+0.5*ones(1,4096),samplerate/2,samplerate,1,1)
xlabel('Frequency (GHz)');ylabel('S(f)')
