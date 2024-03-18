function [ds_all] = get_drop(ds_all, environment)


    for i = 1:numel(ds_all)


    [classProportions, uniqueLabels] = compute_class_proportions(ds_all{i}, environment);
    
    drop_factor = round(classProportions/min(classProportions));
    
    % labels = ds_all{i}.Labels;
    if strcmp(environment,'local')==1
        for x = 1:numel(uniqueLabels)
        count=1;
            for ii = 1:numel(ds_all{i}.Labels)
                if  ds_all{i}.Labels(ii) == uniqueLabels{x}
                    class_ind{x}(count)=ii;
                    count=count+1;
                end
            end
        drop_ind{x} = class_ind{x};clear class_ind;
        drop_ind{x}(1:drop_factor(x):end) = [];
        end
    
    drop_ind = cell2mat(drop_ind);
    
    ds_all{i}.Files(drop_ind)=[]; clear drop_ind;

    elseif strcmp(environment,'online')==1
    
        curr_ds = ds_all{i};
        dataout = readall(curr_ds,UseParallel=true);
        labels = dataout(:,2);
        samples = dataout(:,1);
        labels_str={};
        
        for xx  = 1:numel(labels)
        labels_str{xx} = char(labels{xx});
        end
        for x = 1:numel(uniqueLabels)
        count=1;
            for ii = 1:numel(labels_str)
                if  strcmp(labels_str{ii},uniqueLabels{x})==1
                    class_ind{x}(count)=ii;
                    count=count+1;
                end
            end
        drop_ind{x} = class_ind{x};clear class_ind;
        drop_ind{x}(1:drop_factor(x):end) = [];
        end
        drop_ind = cell2mat(drop_ind);

     labels_str(drop_ind)=[];
     samples(drop_ind)=[]; clear drop_ind;

     curr_samples_ds = arrayDatastore(samples,'OutputType','same'); 
     curr_labels_ds = arrayDatastore(categorical(labels_str)');
     
    ds_all{i} = combine(curr_samples_ds,curr_labels_ds);

    end
   
   
     
     
    
end
end