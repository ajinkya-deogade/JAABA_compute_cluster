function [kinData_xml] = extractTurnPrevFirstHeadCast(kinData_xml)
    
    for i = 1:length(kinData_xml)
        allFirstHeadCastStart = kinData_xml{i}.motorData.behavioralModes.tracker.modeIndices.filtered.allFirstHeadCastStart;
        allTurnsStart = kinData_xml{i}.motorData.behavioralModes.tracker.modeIndices.filtered.allTurnsStart;
        allTurnsEnd = kinData_xml{i}.motorData.behavioralModes.tracker.modeIndices.filtered.allTurnsEnd;
        
        turnsPrevToFirstHeadCast = [];
        for j = 1:length(allFirstHeadCastStart)
            allPrevTurn = [];
            allPrevTurn = find(allTurnsEnd < allFirstHeadCastStart(j));
            if ~isempty(allPrevTurn)
                turnsPrevToFirstHeadCast(j, 1) = allTurnsStart(allPrevTurn(end));
                turnsPrevToFirstHeadCast(j, 2) = allTurnsEnd(allPrevTurn(end));
            else
                turnsPrevToFirstHeadCast(j, 1) = NaN;
                turnsPrevToFirstHeadCast(j, 2) = NaN;
            end
        end
     kinData_xml{i}.motorData.behavioralModes.tracker.modeIndices.analyzed.turnPrevToFirstHeadCast = turnsPrevToFirstHeadCast;    
    end
    
end