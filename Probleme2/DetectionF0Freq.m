


function [f0]=DetectionF0Freq(x,Fe,print_graphs)

N=length(x);
if print_graphs==true
    figure;
    plot(t, x)
    xlabel('Temps (secondes)');
    ylabel('Amplitude');
    title("Signal audio");
end

audio_fft=fft(x,N);
audio_fft=abs(audio_fft);
f=(0:N-1) * (Fe / N);

for i=2:length(audio_fft)-1
    if audio_fft(i)>audio_fft(i-1) && audio_fft(i)>audio_fft(i+1) && audio_fft(i)>max(audio_fft)/4
        kmax=i;
        break
    end 
end 
%[~,kmax]=max(audio_fft);
if f(kmax)<2*Fe
    f0=f(kmax);
end 
if print_graphs==true
    figure;
    plot(f,audio_fft);
    xlabel('Fréquences (Hz)');
    ylabel('Amplitude');
    title("Signal audio");
end

end