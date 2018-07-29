%% Correlation Between First Head Cast and Previous Turn
function [kinData_xml] = correlationFirstHeadCastVsPresentTurn(kinData_xml)

    for i = 1:length(kinData_xml)
        headAngle = kinData_xml{i}.motorData.smoothed.headangle;
        turnsAfterFirstHeadCast = kinData_xml{i}.motorData.behavioralModes.tracker.modeIndices.analyzed.turnAfterFirstHeadCast;
        turnsAfterFirstHeadCast = turnsAfterFirstHeadCast(find(~isnan(turnsAfterFirstHeadCast(:,1))), :);
        allFirstHeadCastStart = kinData_xml{i}.motorData.behavioralModes.tracker.modeIndices.filtered.allFirstHeadCastStart;
        maxL = length(turnsAfterFirstHeadCast);
        correlationAfterTurn =  headAngle(turnsAfterFirstHeadCast(1:maxL, 1)).*headAngle(allFirstHeadCastStart(1:maxL, 1))>0;
        probabilityPositiveCorrelation = length(find(correlationAfterTurn))/length(correlationAfterTurn);
        kinData_xml{i}.motorData.behavioralModes.tracker.modeIndices.analyzed.probSameTurnToPresentFirstCast = probabilityPositiveCorrelation;
        kinData_xml{i}.motorData.behavioralModes.tracker.modeIndices.analyzed.correlationSameTurnToPresentFirstCast = correlationAfterTurn;
    end

end