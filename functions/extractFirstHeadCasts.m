%% Extract First Head Cast Indices
function [kinData_xml] = extractFirstHeadCasts(kinData_xml)
    
    for i = 1:length(kinData_xml)
        eventSeries = kinData_xml{i}.motorData.behavioralModes.tracker.modeIndices.filtered.eventSeries;

        %% Left Head Cast
        leftFirstHeadCastStart = [];
        leftFirstHeadCastEnd = [];
        allFirstHeadCastStart = [];
        allFirstHeadCastEnd = [];
        
        for j = 1:4
            patternIndices = strfind(eventSeries(:,3)', [j, 5]);
            leftFirstHeadCastStart(end+1:end+length(patternIndices),1) = eventSeries(patternIndices+1, 1);
            leftFirstHeadCastEnd(end+1:end+length(patternIndices),1) = eventSeries(patternIndices+1, 2);
        end
        allFirstHeadCastStart = [allFirstHeadCastStart; leftFirstHeadCastStart];
        allFirstHeadCastEnd = [allFirstHeadCastEnd; leftFirstHeadCastEnd];
        
        %% Right Head Cast
        rightFirstHeadCastStart = [];
        rightFirstHeadCastEnd = [];
        for j = 1:4
            patternIndices = strfind(eventSeries(:,3)', [j, 6]);
            rightFirstHeadCastStart(end+1:end+length(patternIndices),1) = eventSeries(patternIndices+1, 1);
            rightFirstHeadCastEnd(end+1:end+length(patternIndices),1) = eventSeries(patternIndices+1, 2);
        end
        allFirstHeadCastStart = [allFirstHeadCastStart; rightFirstHeadCastStart];
        allFirstHeadCastEnd = [allFirstHeadCastEnd; rightFirstHeadCastEnd];
        
        kinData_xml{i}.motorData.behavioralModes.tracker.modeIndices.filtered.leftFirstHeadCastStart = sort(leftFirstHeadCastStart);
        kinData_xml{i}.motorData.behavioralModes.tracker.modeIndices.filtered.leftFirstHeadCastEnd = sort(leftFirstHeadCastEnd);
        kinData_xml{i}.motorData.behavioralModes.tracker.modeIndices.filtered.rightFirstHeadCastStart = sort(rightFirstHeadCastStart);
        kinData_xml{i}.motorData.behavioralModes.tracker.modeIndices.filtered.rightFirstHeadCastEnd = sort(rightFirstHeadCastEnd);
        kinData_xml{i}.motorData.behavioralModes.tracker.modeIndices.filtered.allFirstHeadCastStart = sort(allFirstHeadCastStart);
        kinData_xml{i}.motorData.behavioralModes.tracker.modeIndices.filtered.allFirstHeadCastEnd = sort(allFirstHeadCastEnd);
    end
    
end