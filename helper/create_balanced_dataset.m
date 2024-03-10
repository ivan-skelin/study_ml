function  [train_ds, val_ds, test_ds] = create_balanced_dataset(train_ds, val_ds, test_ds, environment)

%if strcmp(environment,'local')==1

    ds_all = {train_ds, val_ds, test_ds};

    [ds_all] = get_drop(ds_all, environment);

    train_ds = ds_all{1}; val_ds = ds_all{2}; test_ds = ds_all{3};
    
%end
end