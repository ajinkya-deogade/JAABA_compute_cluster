function [kinData_xml] = postProcess_XML_landscape(kinData_xml)
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
end