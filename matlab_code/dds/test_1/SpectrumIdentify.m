%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%              Version: 1.0  -2010.1.26          %%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%   vin: data input                              %%%%%%%%%
%%%   bw: bandwidth of signal                      %%%%%%%%%
%%%   fs: sampling frequency                       %%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%   Ns: length of vin                            %%%%%%%%%
%%%   Usage of Vin generation                      %%%%%%%%%
%%%   t = (0:100000-1)*1/10000;                    %%%%%%%%%
%%%   vin = sin(2*pi*w1*t)                         %%%%%%%%%
%%%       + 0.0007*sin(2*pi*w2*2.1*t)              %%%%%%%%%
%%%       + 0.0002*randn(size(t))                  %%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [SFDR] = SpectrumIdentify(vin,bandwidth,samplingfrequency,window,plotornot)
    %% Initialization
    data = vin-mean(vin);
    Ns = length(data);
    bw = bandwidth;
    fs = samplingfrequency;
    w = hodiewindow(Ns);w=w';
    z=7;
    %% FFT
    if(window==1)
        data_f = abs(fft(data.*w))/Ns*2;
    else
        data_f = abs(fft(data))/Ns*2;
    end
    data_f = data_f(1:Ns/2);
    %% Spectrum
    if(plotornot~=0)
        figure();
        plot((1:Ns/2-1)/Ns*fs,20*(log10(data_f(2:length(data_f)))),'bo-');
        %plot((0:Ns-1)/Ns*fs,20*(log10(data_f)),'bo-');
        grid on;
        %xlim([0 0.5*fs]);
        xlim([0 bw]);
        xlabel('Frequency [Hz]');
        ylabel('Power [dB]');
        title('Output Spectrum');
    end
    %% Signal
    data_f(1:z) =0;
    [yn,dx] = max(data_f);
    dx_low = max([dx-z,1]);
    dx_high = min([dx+z,Ns/2]);
    Asignal = 10*log10(sum(data_f(dx_low:dx_high).^2));
    d_signal = dx;
    %% Noise
    data_noise_f = data_f;
    data_noise_f(dx_low:dx_high) = 0;
    Anoise = 10*log10(sum(data_noise_f(1:ceil(Ns*bw/fs)).^2));
    %% HD1
    data_noise_f = data_noise_f(1:ceil(Ns*bw/fs));
    [yn,dx] = max(data_noise_f);
    dx_low = max([dx-z,1]);
    dx_high = min([dx+z,Ns/2]);
    HD1 = 10*log10(sum(data_noise_f(dx_low:dx_high).^2));
    HD1_f = dx;
    %% HD2
    data_noise_f(dx_low:dx_high) = 0;
    [yn,dx] = max(data_noise_f);
    dx_low = max(dx-z,1);
    dx_high = min(dx+z,Ns/2);
    HD2 = 10*log10(sum(data_noise_f(dx_low:dx_high).^2));
    HD2_f = dx;
    %% HD3
    data_noise_f(dx_low:dx_high) = 0;
    [yn,dx] = max(data_noise_f);
    dx_low = max(dx-z,1);
    dx_high = min(dx+z,Ns/2);
    HD3 = 10*log10(sum(data_noise_f(dx_low:dx_high).^2));
    HD3_f = dx;
    %% HD4
    data_noise_f(dx_low:dx_high) = 0;
    [yn,dx] = max(data_noise_f);
    dx_low = max(dx-z,1);
    dx_high = min(dx+z,Ns/2);
    HD4 = 10*log10(sum(data_noise_f(dx_low:dx_high).^2));
    HD4_f = dx;
    %% HD5
    data_noise_f(dx_low:dx_high) = 0;
    [yn,dx] = max(data_noise_f);
    dx_low = max(dx-z,1);
    dx_high = min(dx+z,Ns/2);
    HD5 = 10*log10(sum(data_noise_f(dx_low:dx_high).^2));
    HD5_f = dx;    
    %% OUTPUT
    THD = 10*log10(10^(HD1/10)+10^(HD2/10)+10^(HD3/10)+...
        10^(HD4/10)+10^(HD5/10));
    SNR = Asignal-Anoise;
    ENOB=(SNR-1.76)/6.02;
    SFDR=Asignal-max([HD1,HD2,HD3]);
    display(['Asignal,  '  'SFDR,  ' 'SNR,  '  'ENOB,  ' 'HD1,  ' 'HD2,  ',...
        'HD3,   ']);
    display([Asignal SFDR SNR ENOB HD1 HD2 HD3]);
    display([d_signal*fs/Ns  HD1_f*fs/Ns HD2_f*fs/Ns HD3_f*fs/Ns]);
end