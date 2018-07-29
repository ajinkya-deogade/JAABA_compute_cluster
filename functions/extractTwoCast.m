%% Extract Two Casts

function [kinData_xml] = extractTwoCast(kinData_xml)
for i = 1:length(kinData_xml)
    eventSeries = kinData_xml{i}.motorData.behavioralModes.tracker.modeIndices.filtered.eventSeries;
    
    %% One cast is cast followed by any run/turn. Two casts is cast followed by cast.
    
    %% Left Head Cast
    leftTwoHeadCastStart = [];
    leftTwoHeadCastEnd = [];
    allTwoHeadCastStart = [];
    allTwoHeadCastEnd = [];
    
    for j = 5:6
        for k = 1:3
            patternIndices = strfind(eventSeries(:,3)', [5, j, k]);
            leftTwoHeadCastStart(end+1:end+length(patternIndices), 1) = eventSeries(patternIndices, 1);
            leftTwoHeadCastEnd(end+1:end+length(patternIndices), 1) = eventSeries(patternIndices, 2);
        end
    end
    allTwoHeadCastStart = [allTwoHeadCastStart; leftTwoHeadCastStart];
    allTwoHeadCastEnd = [allTwoHeadCastEnd; leftTwoHeadCastEnd];
    
    %% Right Head Cast
    rightTwoHeadCastStart = [];
    rightTwoHeadCastEnd = [];
    for j = 5:6
        for k = 1:3
            patternIndices = strfind(eventSeries(:,3)', [6, j, k]);
            rightTwoHeadCastStart(end+1:end+length(patternIndices), 1) = eventSeries(patternIndices, 1);
            rightTwoHeadCastEnd(end+1:end+length(patternIndices), 1) = eventSeries(patternIndices, 2);
        end
    end
    allTwoHeadCastStart = [allTwoHeadCastStart; rightTwoHeadCastStart];
    allTwoHeadCastEnd = [allTwoHeadCastEnd; rightTwoHeadCastEnd];
    
    kinData_xml{i}.motorData.behavioralModes.tracker.modeIndices.analyzed.leftTwoHeadCastStart = sort(leftTwoHeadCastStart);
    kinData_xml{i}.motorData.behavioralModes.tracker.modeIndices.analyzed.leftTwoHeadCastEnd = sort(leftTwoHeadCastEnd);
    kinData_xml{i}.motorData.behavioralModes.tracker.modeIndices.analyzed.rightTwoHeadCastStart = sort(rightTwoHeadCastStart);
    kinData_xml{i}.motorData.behavioralModes.tracker.modeIndices.analyzed.rightTwoHeadCastEnd = sort(rightTwoHeadCastEnd);
    kinData_xml{i}.motorData.behavioralModes.tracker.modeIndices.analyzed.allTwoHeadCastStart = sort(allTwoHeadCastStart);
    kinData_xml{i}.motorData.behavioralModes.tracker.modeIndices.analyzed.allTwoHeadCastEnd = sort(allTwoHeadCastEnd);
end
end