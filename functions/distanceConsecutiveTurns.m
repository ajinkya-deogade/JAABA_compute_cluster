%% Interval Between Consecutive Turns
function [kinData_xml] = distanceConsecutiveTurns(kinData_xml)
    for i = 1:length(kinData_xml)
        pathLength = kinData_xml{i}.motorData.smoothed.pathLength;
        for j = 2:length(kinData_xml{i}.motorData.behavioralModes.tracker.modeIndices.filtered.allTurnsEnd)
            kinData_xml{i}.motorData.behavioralModes.tracker.modeIndices.analyzed.distanceBetweenConsecTurns(j-1) = pathLength(kinData_xml{i}.motorData.behavioralModes.tracker.modeIndices.filtered.allTurnsStart(j)) - pathLength(kinData_xml{i}.motorData.behavioralModes.tracker.modeIndices.filtered.allTurnsEnd(j-1));
        end
    end
end