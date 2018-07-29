%% Correlation between turns left and right

function [kinData_xml] = correlationPastVsPresentTurn(kinData_xml)

    turnRLcorr = {};
    probabilityTurnSameSideAsPrevious = [];
    for i = 1:length(kinData_xml)
        headAngle = kinData_xml{i}.motorData.smoothed.headangle;
        allTurnsStart = kinData_xml{i}.motorData.behavioralModes.tracker.modeIndices.filtered.allTurnsStart;
        for j = 2:length(allTurnsStart)-1
            turncorrelation = (headAngle(allTurnsStart(j))*headAngle(allTurnsStart(j-1)))>0;
        end
        probabilityTurnSameSideAsPrevious = length(find(turncorrelation))/length(turncorrelation);

        kinData_xml{i}.motorData.behavioralModes.tracker.modeIndices.analyzed.turnCorrelation = turncorrelation;
        kinData_xml{i}.motorData.behavioralModes.tracker.modeIndices.analyzed.probTurnSameSideAsPrevious = probabilityTurnSameSideAsPrevious;
    end

end