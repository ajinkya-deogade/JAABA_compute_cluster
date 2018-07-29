function moveCSVFilesOutside(csvdir)

    csvFolder = fullfile(csvdir, 'csv');
    if exist(csvFolder, 'dir') ~= 7
        mkdir(csvFolder);
    end
    allSubFolders = dir(csvdir);
    allSubFolders = allSubFolders(arrayfun(@(x) x.name(1), allSubFolders) ~= '.');

    for i = 1:length(allSubFolders)
        copyfile(fullfile(csvdir, allSubFolders(i).name,'*_data.txt'), fullfile(csvdir, 'csv'))
    end

end