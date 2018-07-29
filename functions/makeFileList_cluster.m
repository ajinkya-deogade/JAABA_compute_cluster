%% Prepare File List for JAABA
function [fileListFileNameXML, fileListFileNameCSV] = makeFileList_cluster(experimentFolder)
% experimentFolder = 'C:\Users\deogadea\Documents\MATLAB\JAABA\oldCLT_update\jaabaForCluster_2\Data';
temp_xml = dir(strcat(experimentFolder,'/XML/*.xml'));
allFiles_xml = {temp_xml.name};
fileListFileNameXML = fullfile(experimentFolder, 'fileListXML.dat');
fileWriter_xml = fopen(fileListFileNameXML ,'w');
formatSpec = '%s\n';
for nFile = 1:length(allFiles_xml)
        fprintf(fileWriter_xml, formatSpec, fullfile(experimentFolder, allFiles_xml{nFile}));
end
fclose(fileWriter_xml);

temp_txt = dir(strcat(experimentFolder,'/CSV/*.txt'));
allFiles_txt = {temp_txt.name};
fileListFileNameCSV = fullfile(experimentFolder, 'fileListCSV.dat');
fileWriter_txt = fopen(fileListFileNameCSV,'w');
formatSpec = '%s\n';
for nFile = 1:length(allFiles_txt)
        fprintf(fileWriter_txt, formatSpec, fullfile(experimentFolder, allFiles_txt{nFile}));
end
fclose(fileWriter_txt);