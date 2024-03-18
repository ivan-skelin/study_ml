function [ds, selected_sample_ID] = create_datastore(base_dir, selected_labels, environment, labels_all, samples_all, sample_ID_all)

if strcmp(environment,'local')==1
    
    ds = imageDatastore(fullfile(base_dir, 'ML_EXPORT', 'mat_files'), 'FileExtensions','.mat','IncludeSubfolders',true);

    load_sample = @(x) x.data; 
    readfun = @(x) load_sample(load(x));
    ds.ReadFcn = readfun;
    
    label_info = readtable(fullfile(base_dir,'ML_EXPORT', 'labels_local.csv'));
    label_info_sorted = sortrows(label_info,1);
    label_col = label_info.Var12; % type of stimulus

    % if isnumeric(label_col(1))==1
    %     label_col = {};
    %     for i = 1:size(label_info_sorted,1)
    %         tic
    %         a = label_info_sorted{i,11};
    %         if contains(a{1}, 'EC')==1
    %             label_col{i}='EC';
    %         elseif contains(a{1}, 'EO')==1
    %             label_col{i}='EO';
    %         end
    %         toc
    %     end
    % 
    % end
    
    row_selected = zeros(1,length(label_col), 'logical');
    %selected_labels =  {'standard' 'oddball_with_reponse' 'response'};
    
    for iSelected = 1:length(selected_labels)
        inds = strmatch(selected_labels{iSelected}, label_col, 'exact');
        row_selected(inds) = true;
    end
    ds.Files = ds.Files(row_selected);
    ds.Labels = categorical(label_col(row_selected));
    

elseif strcmp(environment,'online')==1

    row_selected = zeros(1,numel(labels_all), 'logical');
    
    for iSelected = 1:length(selected_labels)
    inds = strmatch(selected_labels{iSelected}, labels_all, 'exact');
    row_selected(inds) = true;
    end
   
    samples_all_sel = samples_all(row_selected);
    selected_sample_ID = sample_ID_all(row_selected);
    labels_all_sel = labels_all(row_selected);

    sample_ds = arrayDatastore(samples_all_sel', 'OutputType', 'same');
    labels_ds = arrayDatastore(labels_all_sel', 'OutputType', 'same'); 
   

    ds = combine(sample_ds, labels_ds);
   
end
end