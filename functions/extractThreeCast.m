%% Extract Three casts

function [kinData_xml] = extractThreeCast(kinData_xml)

for i = 1:length(kinData_xml)
    eventSeries = kinData_xml{i}.motorData.behavioralModes.tracker.modeIndices.filtered.eventSeries;
    
    %% One cast is cast followed by any run/turn. Two casts is cast followed by cast.
    %% Left Head Cast
    leftThreeHeadCastStart = [];
    leftThreeHeadCastEnd = [];
    allThreeHeadCastStart = [];
    allThreeHeadCastEnd = [];
    
    for j = 5:6
        for k = 5:6
            for l = 1:3
                patternIndices = strfind(eventSeries(:,3)', [5, j, k, l]);
                leftThreeHeadCastStart(end+1:end+length(patternIndices), 1) = eventSeries(patternIndices, 1);
                leftThreeHeadCastEnd(end+1:end+length(patternIndices), 1) = eventSeries(patternIndices, 2);
            end
        end
    end
    allThreeHeadCastStart = [allThreeHeadCastStart; leftThreeHeadCastStart];
    allThreeHeadCastEnd = [allThreeHeadCastEnd; leftThreeHeadCastEnd];
    
    %% Right Head Cast
    rightThreeHeadCastStart = [];
    rightThreeHeadCastEnd = [];
    for j = 5:6
        for k = 5:6
            for l = 1:3
                patternIndices = strfind(eventSeries(:,3)', [6, j, k, l]);
                rightThreeHeadCastStart(end+1:end+length(patternIndices), 1) = eventSeries(patternIndices, 1);
                rightThreeHeadCastEnd(end+1:end+length(patternIndices), 1) = eventSeries(patternIndices, 2);
            end
        end
    end
    allThreeHeadCastStart = [allThreeHeadCastStart; rightThreeHeadCastStart];
    allThreeHeadCastEnd = [allThreeHeadCastEnd; rightThreeHeadCastEnd];
    
    kinData_xml{i}.motorData.behavioralModes.tracker.modeIndices.analyzed.leftThreeHeadCastStart = sort(leftThreeHeadCastStart);
    kinData_xml{i}.motorData.behavioralModes.tracker.modeIndices.analyzed.leftThreeHeadCastEnd = sort(leftThreeHeadCastEnd);
    kinData_xml{i}.motorData.behavioralModes.tracker.modeIndices.analyzed.rightThreeHeadCastStart = sort(rightThreeHeadCastStart);
    kinData_xml{i}.motorData.behavioralModes.tracker.modeIndices.analyzed.rightThreeHeadCastEnd = sort(rightThreeHeadCastEnd);
    kinData_xml{i}.motorData.behavioralModes.tracker.modeIndices.analyzed.allThreeHeadCastStart = sort(allThreeHeadCastStart);
    kinData_xml{i}.motorData.behavioralModes.tracker.modeIndices.analyzed.allThreeHeadCastEnd = sort(allThreeHeadCastEnd);
end
end

