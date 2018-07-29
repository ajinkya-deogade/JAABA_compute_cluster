%% Correlation Between First Head Cast and Previous Turn
function [kinData_xml] = correlationFirstHeadCastVsPreviousTurn(kinData_xml)
    for i = 1:length(kinData_xml)
        headAngle = kinData_xml{i}.motorData.smoothed.headangle;
        turnsPrevToFirstHeadCast = kinData_xml{i}.motorData.behavioralModes.tracker.modeIndices.analyzed.turnPrevToFirstHeadCast;
        allFirstHeadCastStart = kinData_xml{i}.motorData.behavioralModes.tracker.modeIndices.filtered.allFirstHeadCastStart;
        notNaNIdx = find(~isnan(turnsPrevToFirstHeadCast(:,1)));
        correlationFirstCastToPrevTurn = headAngle(turnsPrevToFirstHeadCast(notNaNIdx(1):end, 2)).*headAngle(allFirstHeadCastStart(notNaNIdx(1):end, 1))>0;
%         if ~isnan(turnsPrevToFirstHeadCast(2,2))
%             correlationFirstCastToPrevTurn =  headAngle(turnsPrevToFirstHeadCast(2:end, 2)).*headAngle(allFirstHeadCastStart(2:end, 1))>0;
%         else
%             correlationFirstCastToPrevTurn =  headAngle(turnsPrevToFirstHeadCast(3:end, 2)).*headAngle(allFirstHeadCastStart(3:end, 1))>0;
%         end
        kinData_xml{i}.motorData.behavioralModes.tracker.modeIndices.analyzed.probSameFirstCastToPrevTurn = length(find(correlationFirstCastToPrevTurn))/length(correlationFirstCastToPrevTurn);
        kinData_xml{i}.motorData.behavioralModes.tracker.modeIndices.analyzed.correlationFirstCastToPrevTurn = correlationFirstCastToPrevTurn;
    end
end