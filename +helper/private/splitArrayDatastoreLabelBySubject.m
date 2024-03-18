function [train_ds, val_ds, test_ds] = splitArrayDatastoreLabelBySubject(ds, environment, selected_labels, selected_sample_ID, base_dir)

dataout = readall(ds,UseParallel=true);
labels = dataout(:,2);
samples = dataout(:,1);
sample_ID_all_sel = selected_sample_ID;

row_selected = zeros(1,numel(labels), 'logical');
    
    for iSelected = 1:length(selected_labels)
    inds = strmatch(selected_labels{iSelected}, labels, 'exact');
    row_selected(inds) = true;
    end

  
for i = 1:numel(sample_ID_all_sel)
   a = min(findstr(sample_ID_all_sel{i},'sub-'));
   subj_mat(i,:) = sample_ID_all_sel{i}((a+4):(a+6));
end
   

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


set_subjects = {subj_train, subj_val, subj_test};

    for i = 1:numel(set_subjects)
       
        for ii = 1:size(set_subjects{i},1)
        curr_subj_inds{ii} = strmatch(set_subjects{i}(ii,:), subj_mat, 'exact');%indices from one subject
        
        end
        row_selected_set{i} = cell2mat(curr_subj_inds'); clear curr_subj_inds;
    end
    


     
    train_labels = labels(row_selected_set{1});
    val_labels = labels(row_selected_set{2});
    test_labels = labels(row_selected_set{3});

    train_samples = samples(row_selected_set{1});
    val_samples = samples(row_selected_set{2});
    test_samples = samples(row_selected_set{3});
    
    samples_train_ds = arrayDatastore(samples(row_selected_set{1}),'OutputType','same'); samples_val_ds = arrayDatastore(samples(row_selected_set{2}),'OutputType','same'); samples_test_ds= arrayDatastore(samples(row_selected_set{3}),'OutputType','same');
labels_train_ds = arrayDatastore(categorical(labels(row_selected_set{1}))); labels_val_ds = arrayDatastore(categorical(labels(row_selected_set{2}))); labels_test_ds = arrayDatastore(categorical(labels(row_selected_set{3})));
%sample_ID_train = sample_ID_all(idxs{1})'; sample_ID_val = sample_ID_all(idxs{2})'; sample_ID_test = sample_ID_all(idxs{3})';

train_ds = combine(samples_train_ds,labels_train_ds);
test_ds = combine(samples_test_ds,labels_test_ds);
val_ds = combine(samples_val_ds,labels_val_ds);


end
