%% makeEventSeries
function [kinData_xml] = makeEventSeries(kinData_xml)

for i = 1:length(kinData_xml)
    all_events_start = [];
    if isfield(kinData_xml{i}.motorData.behavioralModes.tracker.modeIndices.raw, 'runStart')
        all_events_start = [all_events_start; kinData_xml{i}.motorData.behavioralModes.tracker.modeIndices.raw.runStart];
    end
    if isfield(kinData_xml{i}.motorData.behavioralModes.tracker.modeIndices.raw, 'leftTurnStart')
        all_events_start = [all_events_start; kinData_xml{i}.motorData.behavioralModes.tracker.modeIndices.raw.leftTurnStart];
    end
    if isfield(kinData_xml{i}.motorData.behavioralModes.tracker.modeIndices.raw, 'rightTurnStart')
        all_events_start = [all_events_start; kinData_xml{i}.motorData.behavioralModes.tracker.modeIndices.raw.rightTurnStart];
    end
    if isfield(kinData_xml{i}.motorData.behavioralModes.tracker.modeIndices.raw, 'stopStart')
        all_events_start = [all_events_start; kinData_xml{i}.motorData.behavioralModes.tracker.modeIndices.raw.stopStart];
    end
    if isfield(kinData_xml{i}.motorData.behavioralModes.tracker.modeIndices.raw, 'leftCastStart')
        all_events_start = [all_events_start; kinData_xml{i}.motorData.behavioralModes.tracker.modeIndices.raw.leftCastStart];
    end
    if isfield(kinData_xml{i}.motorData.behavioralModes.tracker.modeIndices.raw, 'rightCastStart')
        all_events_start = [all_events_start; kinData_xml{i}.motorData.behavioralModes.tracker.modeIndices.raw.rightCastStart];
    end
    if isfield(kinData_xml{i}.motorData.behavioralModes.tracker.modeIndices.raw, 'backupStart')
        all_events_start = [all_events_start; kinData_xml{i}.motorData.behavioralModes.tracker.modeIndices.raw.backupStart];
    end
    
    all_events_end = [];
    all_events_mode = [];
    if isfield(kinData_xml{i}.motorData.behavioralModes.tracker.modeIndices.raw, 'runEnd')
        all_events_end = [all_events_end; kinData_xml{i}.motorData.behavioralModes.tracker.modeIndices.raw.runEnd];
        all_events_mode = [all_events_mode; ones(length(kinData_xml{i}.motorData.behavioralModes.tracker.modeIndices.raw.runEnd),1)*1];
    end
    if isfield(kinData_xml{i}.motorData.behavioralModes.tracker.modeIndices.raw, 'leftTurnEnd')
        all_events_end = [all_events_end; kinData_xml{i}.motorData.behavioralModes.tracker.modeIndices.raw.leftTurnEnd];
        all_events_mode = [all_events_mode; ones(length(kinData_xml{i}.motorData.behavioralModes.tracker.modeIndices.raw.leftTurnEnd),1)*2];
    end
    if isfield(kinData_xml{i}.motorData.behavioralModes.tracker.modeIndices.raw, 'rightTurnEnd')
        all_events_end = [all_events_end; kinData_xml{i}.motorData.behavioralModes.tracker.modeIndices.raw.rightTurnEnd];
        all_events_mode = [all_events_mode; ones(length(kinData_xml{i}.motorData.behavioralModes.tracker.modeIndices.raw.rightTurnEnd),1)*3];
    end
    if isfield(kinData_xml{i}.motorData.behavioralModes.tracker.modeIndices.raw, 'stopEnd')
        all_events_end = [all_events_end; kinData_xml{i}.motorData.behavioralModes.tracker.modeIndices.raw.stopEnd];
        all_events_mode = [all_events_mode; ones(length(kinData_xml{i}.motorData.behavioralModes.tracker.modeIndices.raw.stopEnd),1)*4];
    end
    if isfield(kinData_xml{i}.motorData.behavioralModes.tracker.modeIndices.raw, 'leftCastEnd')
        all_events_end = [all_events_end; kinData_xml{i}.motorData.behavioralModes.tracker.modeIndices.raw.leftCastEnd];
        all_events_mode = [all_events_mode; ones(length(kinData_xml{i}.motorData.behavioralModes.tracker.modeIndices.raw.leftCastEnd),1)*5];
    end
    if isfield(kinData_xml{i}.motorData.behavioralModes.tracker.modeIndices.raw, 'rightCastEnd')
        all_events_end = [all_events_end; kinData_xml{i}.motorData.behavioralModes.tracker.modeIndices.raw.rightCastEnd];
        all_events_mode = [all_events_mode; ones(length(kinData_xml{i}.motorData.behavioralModes.tracker.modeIndices.raw.rightCastEnd),1)*6];
    end
    if isfield(kinData_xml{i}.motorData.behavioralModes.tracker.modeIndices.raw, 'backupEnd')
        all_events_end = [all_events_end; kinData_xml{i}.motorData.behavioralModes.tracker.modeIndices.raw.backupEnd];
        all_events_mode = [all_events_mode; ones(length(kinData_xml{i}.motorData.behavioralModes.tracker.modeIndices.raw.backupEnd),1)*7];
    end
    if isfield(kinData_xml{i}.motorData.behavioralModes.tracker.modeIndices.raw, 'unknownEnd')
        all_events_end = [all_events_end; kinData_xml{i}.motorData.behavioralModes.tracker.modeIndices.raw.unknownEnd];
        all_events_mode = [all_events_mode; ones(length(kinData_xml{i}.motorData.behavioralModes.tracker.modeIndices.raw.unknownEnd),1)*8];
    end
    
    all_events = [];
    all_events(:,1) = all_events_start;
    all_events(:,2) = all_events_end;
    all_events(:,3) = all_events_mode;
    all_events(:,4) = all_events_end - all_events_start;
    all_events_sorted = sortrows(all_events, 1);
    kinData_xml{i}.motorData.behavioralModes.tracker.modeIndices.raw.eventSeries = all_events_sorted;
    
    filterTolerance = [10, 3, 3, 5, 3, 3, 5]; %[Runs, LeftTurn, RightTurn, Stop, LeftHeadCast, RightHeadCast, Backup]
    all_events_filtered = filterEvents(all_events_sorted, filterTolerance);
    [kinData_modes] = processFilteredEventSeries(all_events_filtered);
    kinData_xml{i}.motorData.behavioralModes.tracker.modeIndices.filtered = kinData_modes;
    kinData_xml{i}.motorData.behavioralModes.tracker.modeIndices.filtered.eventSeries = all_events_filtered;
    kinData_xml{i}.motorData.behavioralModes.tracker.modeIndices.filtered.filterTolerance = filterTolerance;
    
    [transition_matrix, number_transitions] = makeTransitionMatrix(all_events_filtered);
    kinData_xml{i}.motorData.behavioralModes.tracker.transition_matrix = transition_matrix;
    kinData_xml{i}.motorData.behavioralModes.tracker.number_transitions = number_transitions;

end