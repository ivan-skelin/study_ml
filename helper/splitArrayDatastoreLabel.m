function [train_ds, val_ds, test_ds] = splitArrayDatastoreLabel(ds)

dataout = readall(ds,UseParallel=true);
labels = dataout(:,2);
samples = dataout(:,1);


idxs = splitlabels(labels, [0.6 0.3 0.1],'randomized');

samples_train_ds = arrayDatastore(samples(idxs{1}),'OutputType','same'); samples_val_ds = arrayDatastore(samples(idxs{2}),'OutputType','same'); samples_test_ds= arrayDatastore(samples(idxs{3}),'OutputType','same');
labels_train_ds = arrayDatastore(categorical(labels(idxs{1}))); labels_val_ds = arrayDatastore(categorical(labels(idxs{2}))); labels_test_ds = arrayDatastore(categorical(labels(idxs{3})));
%sample_ID_train = sample_ID_all(idxs{1})'; sample_ID_val = sample_ID_all(idxs{2})'; sample_ID_test = sample_ID_all(idxs{3})';

train_ds = combine(samples_train_ds,labels_train_ds);
test_ds = combine(samples_test_ds,labels_test_ds);
val_ds = combine(samples_val_ds,labels_val_ds);

% sample_ID.train = sample_ID.train;
% sample_ID.test = sample_ID.test;
% sample_ID.val = sample_ID.val;

end
