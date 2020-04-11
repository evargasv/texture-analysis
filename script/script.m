dataDir = 'rois/';
folders = dir(dataDir);

nr_folders = size(folders,1);

for i=3:nr_folders
    
    folder_name = folders(i).name;
    
    txt_files = dir([dataDir folder_name '/*.txt']);
    nr_files = size(txt_files,1);
    
    for j=1:nr_files
        
        file_name = txt_files(j).name;
        roi_parser( dataDir, folder_name, file_name );

    end
    
end