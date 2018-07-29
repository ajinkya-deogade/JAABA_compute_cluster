function [kinData_xml] = durationOfIndivRuns(kinData_xml)
    for i = 1:length(kinData_xml)
        clear runLength
        runLength = kinData_xml{i}.motorData.behavioralModes.tracker.modeIndices.filtered.runEnd - kinData_xml{i}.motorData.behavioralModes.tracker.modeIndices.filtered.runStart;
        kinData_xml{i}.motorData.behavioralModes.tracker.modeIndices.analyzed.runLength = runLength*0.033;
    end
end