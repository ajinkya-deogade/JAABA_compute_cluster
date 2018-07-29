function [kinData_xml] = calculateProbabilityOfCastAcceptance(kinData_xml)

for i = 1:length(kinData_xml)
    
    eventSeries = kinData_xml{i}.motorData.behavioralModes.tracker.modeIndices.filtered.eventSeries;
    totalHeadCastsLeftIndices = strfind(eventSeries(:, 3)', 5);
    totalHeadCastsRightIndices = strfind(eventSeries(:, 3)', 6);
    if totalHeadCastsLeftIndices(end) == length(eventSeries(:, 3)')
        totalHeadCastsLeft = length(strfind(eventSeries(:, 3)', 5))-1;
        totalHeadCastsRight = length(strfind(eventSeries(:, 3)', 6));
        totalHeadCasts = totalHeadCastsLeft + totalHeadCastsRight;
    elseif totalHeadCastsRightIndices(end) == length(eventSeries(:, 3)')
        totalHeadCastsRight = length(strfind(eventSeries(:, 3)', 6))-1;
        totalHeadCastsLeft = length(strfind(eventSeries(:, 3)', 5));
        totalHeadCasts = totalHeadCastsLeft + totalHeadCastsRight;
    else
        totalHeadCastsLeft = length(strfind(eventSeries(:, 3)', 5));
        totalHeadCastsRight = length(strfind(eventSeries(:, 3)', 6));
        totalHeadCasts = totalHeadCastsLeft + totalHeadCastsRight;
    end
    
    leftHeadCastAccepted = length(strfind(eventSeries(:, 3)', [5, 2])) + length(strfind(eventSeries(:, 3)', [5, 1]));
    leftHeadCastFollowedByRightHeadCast = length(strfind(eventSeries(:, 3)', [5, 6]));
    leftCastWithStop = strfind(eventSeries(:, 3)', [5, 4]);
    for m = 1:length(leftCastWithStop)
        if eventSeries(leftCastWithStop(m)+2, 3) == 2 | eventSeries(leftCastWithStop(m)+2, 3) == 1
            leftHeadCastAccepted = leftHeadCastAccepted + 1;
        end
    end
    rightHeadCastAccepted = length(strfind(eventSeries(:, 3)', [6, 3])) + length(strfind(eventSeries(:, 3)', [6, 1]));
    rightHeadCastFollowedByLeftHeadCast = length(strfind(eventSeries(:, 3)', [6, 5]));
    rightCastWithStop = strfind(eventSeries(:, 3)', [6, 4]);
    for m = 1:length(rightCastWithStop)
        if rightCastWithStop(m)+2 <=length(eventSeries(:,3))
            if eventSeries(rightCastWithStop(m)+2, 3) == 2 | eventSeries(rightCastWithStop(m)+2, 3) == 1
                rightHeadCastAccepted = rightHeadCastAccepted + 1;
            end
        end
    end
    allCastsAccepted = leftHeadCastAccepted + rightHeadCastAccepted;
    
    probabilityAcceptanceLeft = leftHeadCastAccepted/totalHeadCastsLeft;
    probabilityAcceptanceRight = rightHeadCastAccepted/totalHeadCastsRight;
    probabilityAcceptanceAllCasts = allCastsAccepted/totalHeadCasts;
    
    kinData_xml{i}.motorData.behavioralModes.tracker.modeIndices.analyzed.probabilityAcceptanceLeft = probabilityAcceptanceLeft;
    kinData_xml{i}.motorData.behavioralModes.tracker.modeIndices.analyzed.probabilityAcceptanceRight = probabilityAcceptanceRight;
    kinData_xml{i}.motorData.behavioralModes.tracker.modeIndices.analyzed.probabilityAcceptanceAllCasts = probabilityAcceptanceAllCasts;
    
end

end