function download_shrink_dataset(dataset_ID)

mkdir(sprintf('%s',dataset_ID));


imds = imageDatastore(sprintf("s3://openneuro.org/%s/",dataset_ID), 'FileExtensions', {'.tsv', '.json','.set'}, IncludeSubfolders=false);
filePaths = imds.Files;

for i = 1:numel(filePaths)
s3FilePath = filePaths{i};
localFilePath = sprintf('%s',dataset_ID);
copyfile(s3FilePath, localFilePath);
end

if strcmp(dataset_ID,'ds004186')==1

a = dir(sprintf("s3://openneuro.org/%s/",dataset_ID));
localFilePath = sprintf('%s',dataset_ID);
s3FilePath = sprintf("s3://openneuro.org/%s/",dataset_ID);

count=0;
for i = 1:numel(a)
    if a(i).isdir==1 & strcmp(a(i).name(1:3),'sub')==1 & i~=13
        tic
        curr_sub = a(i).name
        i
        %mkdir(sprintf('%s/%s',localFilePath,curr_sub));
        copyfile(sprintf('%s/%s',s3FilePath,curr_sub), sprintf('%s/%s',localFilePath,curr_sub));
        count = count+1;
        toc
    end
    if count>8
        break
    end
end



elseif strcmp(dataset_ID,'ds002680')==1

    s3FilePath = sprintf("s3://openneuro.org/%s/",dataset_ID)
    localFilePath = sprintf('%s',dataset_ID);

    for i = 2:4
        if numel(num2str(i))==1
            mkdir(sprintf('%s/sub-00%s',localFilePath,num2str(i)));

        elseif numel(num2str(i))==2
            mkdir(sprintf('%s/sub-0%s',localFilePath,num2str(i)));

        end
    end
    
    
   
    for i = 2:4
        tic
        status = copyfile(sprintf('%s/sub-00%s',s3FilePath,num2str(i)), sprintf('%s/sub-00%s',localFilePath,num2str(i)));
        toc
    end
end

end
