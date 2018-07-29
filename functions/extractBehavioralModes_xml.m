%  Author: Ajinkya Deogade
%  Organisation: Center for Genomic Regulation
%  Year: 2014
%  Description:

function [kinData_xml] = extractBehavioralModes_xml(kinData_xml)

% kinData_modes = cell(size(kinData_xml));

for m = 1:length(kinData_xml)
    for mode = 1:length(kinData_xml{m}.motorData.raw.behaviorMode)
        %% Convert Behavioral Mode Names to Numbers
        switch kinData_xml{m}.motorData.raw.behaviorMode{mode}
            case 'RUN'
                kinData_xml{m}.motorData.behavioralModes.tracker.modeIndices.all(mode) = 1;
            case 'CAST_LEFT'
                kinData_xml{m}.motorData.behavioralModes.tracker.modeIndices.all(mode) = 5;
            case 'CAST_RIGHT'
                kinData_xml{m}.motorData.behavioralModes.tracker.modeIndices.all(mode) = 6;
            case 'STOP'
                kinData_xml{m}.motorData.behavioralModes.tracker.modeIndices.all(mode) = 4;
            case 'TURN_LEFT'
                kinData_xml{m}.motorData.behavioralModes.tracker.modeIndices.all(mode) = 2;
            case 'TURN_RIGHT'
                kinData_xml{m}.motorData.behavioralModes.tracker.modeIndices.all(mode) = 3;
            case 'BACK_UP'
                kinData_xml{m}.motorData.behavioralModes.tracker.modeIndices.all(mode) = 7;        
        end
    end
    
    [kinData_modes] = extract_behaviorStartsEnd(kinData_xml{m}.motorData.behavioralModes.tracker.modeIndices.all);
    kinData_xml{m}.motorData.behavioralModes.tracker.modeIndices.raw = kinData_modes;
end

[kinData_xml] = makeEventSeries(kinData_xml);