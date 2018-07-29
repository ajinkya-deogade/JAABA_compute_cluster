%% Run JAABA Classifier
clear all
close all
addpath(genpath('../JAABA/'));
addpath(genpath('./misc/'));
warning('off','all')
inputfileXML = './Data/venkman-log-20150724-000230497-sid-5.xml';
inputfileCSV = './Data/20150724-000230_data.txt';
outputFolder = './Data/JAABA_Output/';
if exist(outputFolder, 'dir') ~= 7
    mkdir(outputFolder)
end

lab = 1; % janelia = 1; crg = 0;
classifierFiles = './Classifiers/stop_cast_20150720.jab';
flagLandscape = 0;
[result] = jaabaClassifier(inputfileXML, inputfileCSV, outputFolder, '1', classifierFiles, '0');