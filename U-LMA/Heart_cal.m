function [SNR,Heart_Rate]=Heart_cal(y,FS,gd)
y(y<0)=0;
bp = designfilt('bandpassfir', 'FilterOrder',60, 'CutoffFrequency1', 0.7, 'CutoffFrequency2', 4.0, 'SampleRate', FS);
HB_filtered=filter(bp,y);

HB_filtered_fft=fft(HB_filtered);
[HB_peak,loc]=findpeaks(abs(HB_filtered_fft)); % Finding peaks
max_peak=max(HB_peak);  % finding max peak
Heart_Rate=round(log10(max_peak)*60);
SNR=snr(HB_filtered);
return