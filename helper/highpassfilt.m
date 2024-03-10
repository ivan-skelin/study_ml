function [ALLEEG] = highpassfilt(ALLEEG, freq, srate)
                     
nyq_freq = srate / 2;

[B, A] = cheby1(4, 0.1, freq/nyq_freq, 'high');


for i = 1:numel(ALLEEG)
    for ii = 1:size(ALLEEG(i).data,1)
       raw_lfp = ALLEEG(i).data(ii,:);
       ALLEEG(i).data(ii,:) =  single(filtfilt(B, A, double(raw_lfp)));
    end
end
end