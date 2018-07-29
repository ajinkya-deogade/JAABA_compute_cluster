%% Head Cast Density
function [kinData_xml] = calculateHeadCastDensity(kinData_xml)
    for i = 1:length(kinData_xml)
        if ~isempty(kinData_xml{i}.motorData.behavioralModes.tracker.modeIndices.allCastsStart)
            totalPathLength = kinData_xml{i}.motorData.smoothed.pathlength;
            distPerCast = length(kinData_xml{i}.motorData.behavioralModes.tracker.modeIndices.allCastsStart)/totalPathLength;
            distPerTurn = length(kinData_xml{i}.motorData.behavioralModes.tracker.modeIndices.allTurnsStart)/totalPathLength;
            totalPathTime = (length(kinData_xml{i}.motorData.smoothed.headposition)*0.033);
            timePerCast = length(kinData_xml{i}.motorData.behavioralModes.tracker.modeIndices.allCastsStart)/totalPathTime;
            timePerTurn = length(kinData_xml{i}.motorData.behavioralModes.tracker.modeIndices.allTurnsStart)/totalPathTime;
        elseif sum(isnan(kinData_xml{i}.motorData.behavioralModes.tracker.modeIndices.allCastsStart))>0;
            keyboard
        else
            distPerCast = nan;
            timePerCast = nan;
            distPerTurn = nan;
            timePerTurn = nan;
        end
        kinData_xml{i}.motorData.smoothed.distancePerCast = distPerCast;
        kinData_xml{i}.motorData.smoothed.timePerCast = timePerCast;
        kinData_xml{i}.motorData.smoothed.distancePerTurn = distPerTurn;
        kinData_xml{i}.motorData.smoothed.timePerTurn = timePerTurn;
    end
end