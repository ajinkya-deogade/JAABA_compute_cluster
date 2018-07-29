%  Author: Ajinkya Deogade
%  Organisation: Center for Genomic Regulation
%  Year: 2014
%  Description:

function [kinData_xml] = postProcess_kinData_XML(kinData_xml, outputfolder, inputfile, flag_landscape)

%% Stitch Jumps
display('Stitching Jumps.......')
[kinData_xml] = jump_stitcher_xml(kinData_xml);

%% Smoothen Data
display('Smoothen Data.......')
[kinData_xml] = makeSmoother_kinData_xml(kinData_xml);

%% Extract Behavioral Modes - Tracker Classifiers
display('Extracting Behavioral Modes.......')
[kinData_xml] = extractBehavioralModes_xml(kinData_xml);

%% Process Essential Metrics
display('Computing Important Behavioral Metrics.......')
[kinData_xml] = processEssentialBehaviors(kinData_xml);

%% For Landscape
if flag_landscape > 0
    %% Correct Positions
    display('Correcting Positions.......')
    [kinData_xml] = correctPositions_xml(kinData_xml);
    
    %% Smoothen Data
    display('Smoothen Data.......')
    [kinData_xml] = makeSmoother_kinData_xml_landscape(kinData_xml);
    
    %% Compute Gradient for Light landscape
    display('Calculating Gradient.......')
    [kinData_xml_landscape] = calculateGradient(kinData_xml, 20);
    save(strcat(fileName,'_landscape.mat'),'kinData_xml_landscape','-mat','-v7.3');
    
    %% Map Postions to Landscape
    display('Mapping Positions to Landscape.......')
    load(strcat(fileName, '_landscape.mat'));
    [kinData_xml] = mapPositionToLandscape(kinData_xml, kinData_xml_landscape);
    
    %% Calculate Bearing
    display('Calculating Bearing.......')
    [kinData_xml] = calculateBearing(kinData_xml);
    
    %% Extract Behavioral Modes - Tracker Classifiers
    display('Extracting Behavioral Modes.......')
    [kinData_xml] = extractBehavioralModes_xml(kinData_xml);
    
end

%% Save Post-processed Data
display('Saving Post-processed data.......')
[~,name,~] = fileparts(inputfile);
save(fullfile(outputfolder, strcat(name,'_', 'kinData_xml_postProcessed.mat')),'kinData_xml', '-mat');

end