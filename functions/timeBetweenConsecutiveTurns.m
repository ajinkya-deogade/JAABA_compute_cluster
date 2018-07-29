%% Time Between Consecutive Head Casts

function [kinData_xml] = timeBetweenConsecutiveTurns(kinData_xml)
    for i = 1:length(kinData_xml)
        for j = 2:length(kinData_xml{i}.motorData.behavioralModes.tracker.modeIndices.allTurnsEnd)
            kinData_xml{i}.motorData.behavioralModes.tracker.modeIndices.analyzed.timeBetweenConsecTurns(j-1) = 0.033*(kinData_xml{i}.motorData.behavioralModes.tracker.modeIndices.allTurnsStart(j) - kinData_xml{i}.motorData.behavioralModes.tracker.modeIndices.allTurnsEnd(j-1));
        end
    end
end