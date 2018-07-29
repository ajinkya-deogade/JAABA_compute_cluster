function [kinData_xml] = extractNumberOfCastBeforeTurn(kinData_xml)
    for i = 1:length(kinData_xml)

        eventSeries = kinData_xml{i}.motorData.behavioralModes.tracker.modeIndices.filtered.eventSeries;
        allTurnsStart = kinData_xml{i}.motorData.behavioralModes.tracker.modeIndices.filtered.allTurnsStart;
        allTurnsEnd = kinData_xml{i}.motorData.behavioralModes.tracker.modeIndices.filtered.allTurnsEnd;
        numberCastsBeforeTurn = zeros(1, 9);

        for j = 1:length(allTurnsEnd)
            if j ~= 1
                indexPreviousTurnEnd = find(eventSeries(:, 2) == allTurnsEnd(j-1));
                indexPresentTurnStart = find(eventSeries(:, 1) == allTurnsStart(j));
            else
                indexPreviousTurnEnd = 1;
                indexPresentTurnStart = find(eventSeries(:, 1) == allTurnsStart(j));
            end
            nCastInterval = length(find(eventSeries(indexPreviousTurnEnd:indexPresentTurnStart, 3) == 5 | eventSeries(indexPreviousTurnEnd:indexPresentTurnStart, 3) == 6));
            if nCastInterval+1 > length(numberCastsBeforeTurn)
                nCastInterval = length(numberCastsBeforeTurn)-1;
                numberCastsBeforeTurn(1, nCastInterval+1) = numberCastsBeforeTurn(1, nCastInterval+1) + 1;
            else
                numberCastsBeforeTurn(1, nCastInterval+1) = numberCastsBeforeTurn(1, nCastInterval+1) + 1;
            end
        end
        kinData_xml{i}.motorData.behavioralModes.tracker.modeIndices.analyzed.numberCastsBeforeTurn = numberCastsBeforeTurn;
    end
end