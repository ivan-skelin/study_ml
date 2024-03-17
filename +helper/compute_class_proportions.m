function [classProportions, uniqueLabels] = compute_class_proportions(ds,environment)

if strcmp(environment,'local')==1
classes = unique(ds.Labels);
uniqueLabels = cellstr(unique(ds.Labels));
labels_str = cellstr(ds.Labels);
elseif strcmp(environment,'online')==1
    labels_str = {};
    dataout = readall(ds,UseParallel=true);
    labels = dataout(:,2);
    for x  = 1:numel(labels)
        labels_str{x} = char(labels{x});
    end
    uniqueLabels = unique(labels_str);
end
    
    

for iCat = 1:length(uniqueLabels)
    n(iCat) = sum(cellfun(@(x)isequal(uniqueLabels{iCat}, x), labels_str));
end
classProportions = n/sum(n);
end
