%% Extract one casts

function [kinData_xml] = extractOneCast(kinData_xml)

    for i = 1:length(kinData_xml)
        eventSeries = kinData_xml{i}.motorData.behavioralModes.tracker.modeIndices.filtered.eventSeries;

        %% One cast is cast followed by any run/turn. Two casts is cast followed by cast.

        %% Left Head Cast
        leftOneHeadCastStart = [];
        leftOneHeadCastEnd = [];
        allOneHeadCastStart = [];
        allOneHeadCastEnd = [];

        for j = 1:3
            patternIndices = strfind(eventSeries(:,3)', [5, j]);
            leftOneHeadCastStart(end+1:end+length(patternIndices), 1) = eventSeries(patternIndices, 1);
            leftOneHeadCastEnd(end+1:end+length(patternIndices), 1) = eventSeries(patternIndices, 2);
        end
        allOneHeadCastStart = [allOneHeadCastStart; leftOneHeadCastStart];
        allOneHeadCastEnd = [allOneHeadCastEnd; leftOneHeadCastEnd];

        %% Right Head Cast
        rightOneHeadCastStart = [];
        rightOneHeadCastEnd = [];
        for j = 1:3
            patternIndices = strfind(eventSeries(:,3)', [6, j]);
            rightOneHeadCastStart(end+1:end+length(patternIndices), 1) = eventSeries(patternIndices, 1);
            rightOneHeadCastEnd(end+1:end+length(patternIndices), 1) = eventSeries(patternIndices, 2);
        end
        allOneHeadCastStart = [allOneHeadCastStart; rightOneHeadCastStart];
        allOneHeadCastEnd = [allOneHeadCastEnd; rightOneHeadCastEnd];

        kinData_xml{i}.motorData.behavioralModes.tracker.modeIndices.analyzed.leftOneHeadCastStart = sort(leftOneHeadCastStart);
        kinData_xml{i}.motorData.behavioralModes.tracker.modeIndices.analyzed.leftOneHeadCastEnd = sort(leftOneHeadCastEnd);
        kinData_xml{i}.motorData.behavioralModes.tracker.modeIndices.analyzed.rightOneHeadCastStart = sort(rightOneHeadCastStart);
        kinData_xml{i}.motorData.behavioralModes.tracker.modeIndices.analyzed.rightOneHeadCastEnd = sort(rightOneHeadCastEnd);
        kinData_xml{i}.motorData.behavioralModes.tracker.modeIndices.analyzed.allOneHeadCastStart = sort(allOneHeadCastStart);
        kinData_xml{i}.motorData.behavioralModes.tracker.modeIndices.analyzed.allOneHeadCastEnd = sort(allOneHeadCastEnd);
    end

end