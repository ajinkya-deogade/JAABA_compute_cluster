%% Author: Matthieu Louis

function [kinData] = jump_stitcher_csv(kinData)
plot_flag = 0;

kinData.headposition = jump_stitcher(kinData.headposition, plot_flag);
kinData.centroidposition = jump_stitcher(kinData.centroidposition, plot_flag);
kinData.midposition = jump_stitcher(kinData.midposition, plot_flag);
kinData.tailposition = jump_stitcher(kinData.tailposition, plot_flag);
