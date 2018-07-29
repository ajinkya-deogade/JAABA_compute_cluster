%  Author: Ajinkya Deogade
%  Organisation: Center for Genomic Regulation
%  Year: 2014
%  Description:

function [kinData_xml] = postProcess_kinData_XML_fromFile(fileName, flag_landscape)

%% Post process the tracker from Data for Light landscape
% step_size_for_tailbased_classifier=1; %current for light: 1.0; 0.5 for odor gradient; 0.5 for light gradient
% threshold_for_tailbased_classifier=20; %current for light: 15; 20 for odor gradient; 20 for exp-exp light gradient; 50 for Gaussian gradients

%% Load Data
load(fileName,'-mat');

%% Stitch Jumps
display('Stitching Jumps.......')
[kinData_xml] = jump_stitcher_xml(kinData_xml);

%% Smoothen Data
display('Smoothening Data.......')
[kinData_xml] = makeSmoother_kinData_xml(kinData_xml);

%% Extract Behavioral Modes - Tracker Classifiers
display('Extracting Behavioral Modes.......')
[kinData_xml] = extractBehavioralModes_xml(kinData_xml);

%% Process Essential Metrics
display('Computing Important Behavioral Metrics.......')
[kinData_xml] = processEssentialBehaviors(kinData_xml);
[kinData_xml] = findFrames_AppliedHeadThresholdsAndSteps(kinData_xml);

% %% Extract Behavioral Modes - Tailbased Classifier
% display('Extracting Behavioral Modes Tail-Based.......')
% [kinData_xml] = extractBehavioralModes_tailbased(kinData_xml, step_size_for_tailbased_classifier, threshold_for_tailbased_classifier);
%
% %% Extract Behavioral Modes - Nature Communication Classifier
% display('Extracting Behavioral Modes Nature Communications.......')
% [kinData_xml] = extractBehavioralModes_NatComm(kinData_xml, step_size_for_tailbased_classifier, threshold_for_tailbased_classifier)

%% Save Post-processed Data
display('Saving Post-processed data.......')
[path, name, ext] = fileparts(fileName);
save(fullfile(path, 'kinData_xml_postProcessed.mat'),'kinData_xml', '-mat');

end