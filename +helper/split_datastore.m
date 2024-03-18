function [train_ds, val_ds, test_ds] = split_datastore(ds, splitting_mode, environment, selected_labels, base_dir, sample_ID_all)

if strcmp(environment,'local')==1 & strcmp(splitting_mode,'subjects_mixed')==1
   
    [train_ds, val_ds, test_ds] = splitEachLabel(ds, 0.6, 0.3, 0.1, 'randomized');%

elseif strcmp(environment,'local')==1 & strcmp(splitting_mode,'subjects_separated')==1
 
    [train_ds, val_ds, test_ds] = splitEachLabelBySubject(ds, environment, selected_labels, base_dir);%

elseif strcmp(environment,'online')==1 & strcmp(splitting_mode,'subjects_mixed')==1

    [train_ds, val_ds, test_ds] = splitArrayDatastoreLabel(ds);%test the two online environment options with the appropriate datastore

elseif strcmp(environment,'online')==1 & strcmp(splitting_mode,'subjects_separated')==1
  

    [train_ds, val_ds, test_ds] = splitArrayDatastoreLabelBySubject(ds, environment, selected_labels, sample_ID_all, base_dir);

end

end
