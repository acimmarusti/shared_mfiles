function [fdat, resp, freq] = notch_filter(dat, samp_time, fnotch, bw)

    %Sampling rate
    fs = 1 / samp_time;

    elements = size(dat, 1);

    %Notch freq and BW normalized by Nyquist frequency (= sampling rate / 2)
    notch_freq = fnotch / (fs / 2);

    notch_bw = bw / (fs / 2);
    
    %Notch filter
    if (is_octave)
        
        [zeros_coef, poles_coef] = pei_tseng_notch(notch_freq, notch_bw);

    else
    
        [zeros_coef, poles_coef] = iirnotch(notch_freq, notch_bw);
    
    end
    
    %Frequency response of filter
    [resp, freq] = freqz(zeros_coef, poles_coef, elements, fs);

    %Apply filter to time-domain signal
    fdat = filter(zeros_coef, poles_coef, dat);

end