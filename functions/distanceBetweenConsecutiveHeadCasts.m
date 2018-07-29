%% Distance Between Consecutive Head Casts

function [kinData_xml] = distanceBetweenConsecutiveHeadCasts(kinData_xml)
    for i = 1:length(kinData_xml)
        pathLength = kinData_xml{i}.motorData.smoothed.pathLength;
        for j = 2:length(kinData_xml{i}.motorData.behavioralModes.tracker.modeIndices.filtered.allCastsEnd)
            kinData_xml{i}.motorData.behavioralModes.tracker.modeIndices.analyzed.distanceBetweenConsecHeadCasts(j-1) = pathLength(kinData_xml{i}.motorData.behavioralModes.tracker.modeIndices.filtered.allCastsStart(j)) - pathLength(kinData_xml{i}.motorData.behavioralModes.tracker.modeIndices.filtered.allCastsEnd(j-1));
        end
    end
end