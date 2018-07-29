%% Time Between Consecutive Head Casts

function [kinData_xml] = timeBetweenConsecutiveHeadCasts(kinData_xml)
    for i = 1:length(kinData_xml)
        for j = 2:length(kinData_xml{i}.motorData.behavioralModes.tracker.modeIndices.filtered.allCastsEnd)
            kinData_xml{i}.motorData.behavioralModes.tracker.modeIndices.analyzed.timeBetweenConsecHeadCasts(j-1) = 0.033*(kinData_xml{i}.motorData.behavioralModes.tracker.modeIndices.filtered.allCastsStart(j) - kinData_xml{i}.motorData.behavioralModes.tracker.modeIndices.filtered.allCastsEnd(j-1));
        end
    end
end