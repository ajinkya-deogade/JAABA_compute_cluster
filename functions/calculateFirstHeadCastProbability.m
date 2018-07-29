function [kinData_xml] = calculateFirstHeadCastProbability(kinData_xml)

    for i = 1:length(kinData_xml)
        totalFirstCasts = length(kinData_xml{i}.motorData.behavioralModes.tracker.modeIndices.filtered.allFirstHeadCastStart);
        firstCastProbablityLeft = length(kinData_xml{i}.motorData.behavioralModes.tracker.modeIndices.filtered.leftFirstHeadCastStart)/totalFirstCasts;
        firstCastProbablityRight = length(kinData_xml{i}.motorData.behavioralModes.tracker.modeIndices.filtered.rightFirstHeadCastStart)/totalFirstCasts;
        kinData_xml{i}.motorData.behavioralModes.tracker.modeIndices.analyzed.firstCastProbablityLeft = firstCastProbablityLeft;
        kinData_xml{i}.motorData.behavioralModes.tracker.modeIndices.analyzed.firstCastProbablityRight = firstCastProbablityRight;
    end

end