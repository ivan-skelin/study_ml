
function [train_ds, val_ds, test_ds] = splitEachLabelBySubject(ds, environment, selected_labels, base_dir)

label_info = readtable(fullfile(base_dir,'ML_EXPORT', 'labels_local.csv'));
if isstring(label_info.Var9(1))==1
    subj = label_info.Var9;
else
    subj = label_info.Var4;
end

subj_mat = cell2mat(subj);
label_col = label_info.Var7;

unique_subj = unique(subj_mat,'rows');
num_subj = size(unique_subj,1);

num_subj_train = round(size(unique_subj,1)*0.6);
num_subj_val = round(size(unique_subj,1)*0.3);
num_subj_test = round(size(unique_subj,1)*0.1);

subj_train = unique_subj(1:num_subj_train,:);
unique_subj(1:num_subj_train,:)=[];


subj_val = unique_subj(1:num_subj_val,:);
unique_subj(1:num_subj_val,:)=[];


subj_test = unique_subj(1:num_subj_test,:);
unique_subj(1:num_subj_test,:)=[];

row_selected = zeros(1,length(label_col), 'logical');
    selected_labels =  {'standard' 'oddball_with_reponse' 'response'};
    
    for iSelected = 1:length(selected_labels)
        inds = strmatch(selected_labels{iSelected}, label_col, 'exact');
        row_selected(inds) = true;
    end

    subj_mat = subj_mat(row_selected,:);


set_subjects = {subj_train, subj_val, subj_test};

    for i = 1:numel(set_subjects)
       
        for ii = 1:size(set_subjects{i},1)
        curr_subj_inds{ii} = strmatch(set_subjects{i}(ii,:), subj_mat, 'exact');%indices from one subject
        
        end
        row_selected_set{i} = cell2mat(curr_subj_inds'); clear curr_subj_inds;
    end
    
    [ds] = create_datastore(base_dir, selected_labels, environment,selected_labels);
    train_ds = ds; 
    train_ds.Files(cell2mat(row_selected_set(2:3)'))=[];

    [ds] = create_datastore(base_dir, selected_labels, environment,selected_labels);
    val_ds = ds; 
    val_ds.Files(cell2mat(row_selected_set([1 3])'))=[];

    [ds] = create_datastore(base_dir, selected_labels, environment,selected_labels);
    test_ds = ds; 
    test_ds.Files(cell2mat(row_selected_set(1:2)'))=[];


end
