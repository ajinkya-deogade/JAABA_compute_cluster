function [kinData_xml] = extractTurnSucceedingFirstHeadCast(kinData_xml)
    
    for i = 1:length(kinData_xml)
        allFirstHeadCastStart = kinData_xml{i}.motorData.behavioralModes.tracker.modeIndices.filtered.allFirstHeadCastStart;
        allTurnsStart = kinData_xml{i}.motorData.behavioralModes.tracker.modeIndices.filtered.allTurnsStart;
        allTurnsEnd = kinData_xml{i}.motorData.behavioralModes.tracker.modeIndices.filtered.allTurnsEnd;
        turnsAfterFirstHeadCast = [];
        for j = 1:length(allFirstHeadCastStart)
            allAfterTurn = [];
            allAfterTurn = find(allTurnsStart > allFirstHeadCastStart(j));
            if ~isempty(allAfterTurn)
                turnsAfterFirstHeadCast(j, 1) = allTurnsStart(allAfterTurn(1));
                turnsAfterFirstHeadCast(j, 2) = allTurnsEnd(allAfterTurn(1));
            else
                turnsAfterFirstHeadCast(j, 1) = NaN;
                turnsAfterFirstHeadCast(j, 2) = NaN;
            end
        end
     kinData_xml{i}.motorData.behavioralModes.tracker.modeIndices.analyzed.turnAfterFirstHeadCast = turnsAfterFirstHeadCast;    
    end
    
end