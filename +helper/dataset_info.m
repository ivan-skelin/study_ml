function dataset_info(ALLEEG)

count=1;
for i = 1:numel(ALLEEG)   
            dur_rec(count) = round(size(ALLEEG(i).data,2)/ALLEEG(i).srate);
            count=count+1;
end
min_dur_rec = min(dur_rec);
max_dur_rec = max(dur_rec);

eeg_ch_count=ALLEEG(1).nbchan;
% for i = 1:numel(ALLEEG(1).chanlocs)
%     if strcmp(ALLEEG(1).chanlocs(i).type,'EEG')==1
%         eeg_ch_count=eeg_ch_count+1;
%     end
% end

fprintf('The example consists of %d datasets, recorded from %d unique subjects.\nIndividual datasets consist of %d channels recorded at %d Hz. Recording durations are %d-%d sec.',numel(ALLEEG), numel(unique({ALLEEG(:).subject})), eeg_ch_count, ALLEEG(1).srate, min_dur_rec, max_dur_rec)

end