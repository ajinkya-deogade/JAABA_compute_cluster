%% Author: Matthieu Louis

function [kinData_xml] = jump_stitcher_xml(kinData_xml)
plot_flag = 0;
for i = 1:length(kinData_xml)
    
    kinData_xml{i}.motorData.raw.headposition = jump_stitcher(kinData_xml{i}.motorData.raw.headposition, plot_flag);
    kinData_xml{i}.motorData.raw.centroidposition = jump_stitcher(kinData_xml{i}.motorData.raw.centroidposition, plot_flag);
    kinData_xml{i}.motorData.raw.midpointposition = jump_stitcher(kinData_xml{i}.motorData.raw.midpointposition, plot_flag);
    kinData_xml{i}.motorData.raw.tailposition = jump_stitcher(kinData_xml{i}.motorData.raw.tailposition, plot_flag);
    
end