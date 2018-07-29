function [kinData_modes] = processFilteredEventSeries(all_events_filtered)

    n_runs = 0;
    n_lcast = 0;
    n_rcast = 0;
    n_lturn = 0;
    n_rturn = 0;
    n_stop = 0;
    n_backup = 0;
    n_unknown = 0;
    % kinData_modes.all = behaviorMode_num;
    kinData_modes.allTurnsStart = [];
    kinData_modes.allTurnsEnd = [];
    kinData_modes.allCastsStart = [];
    kinData_modes.allCastsEnd = [];
    kinData_modes.runIndices = [];
    kinData_modes.leftCastIndices = [];
    kinData_modes.rightCastIndices = [];
    kinData_modes.leftTurnIndices = [];
    kinData_modes.rightTurnIndices = [];
    kinData_modes.stopIndices = [];
    kinData_modes.backupIndices = [];
    kinData_modes.unknownIndices = [];

    for i = 1:length(all_events_filtered(:,3))
        switch all_events_filtered(i,3)
            case 1
                n_runs = n_runs + 1;
                kinData_modes.run{n_runs} = all_events_filtered(i,1):all_events_filtered(i,2);
                kinData_modes.runIndices(end+1:end+length(kinData_modes.run{n_runs}), 1) = kinData_modes.run{n_runs}; 
                kinData_modes.runStart(n_runs, 1) = all_events_filtered(i,1);
                kinData_modes.runEnd(n_runs, 1) = all_events_filtered(i,2);

            case 5
                n_lcast = n_lcast + 1;
                kinData_modes.leftCast{n_lcast} = all_events_filtered(i,1):all_events_filtered(i,2);
                kinData_modes.leftCastIndices(end+1:end+length(kinData_modes.leftCast{n_lcast}), 1) = kinData_modes.leftCast{n_lcast}; 
                kinData_modes.leftCastStart(n_lcast, 1) = all_events_filtered(i,1);
                kinData_modes.leftCastEnd(n_lcast, 1) = all_events_filtered(i,2);
                kinData_modes.allCastsStart(end+1, 1) = all_events_filtered(i,1);
                kinData_modes.allCastsEnd(end+1, 1) = all_events_filtered(i,2);

            case 6
                n_rcast = n_rcast + 1;
                kinData_modes.rightCast{n_rcast} = all_events_filtered(i,1):all_events_filtered(i,2);
                kinData_modes.rightCastIndices(end+1:end+length(kinData_modes.rightCast{n_rcast}), 1) = kinData_modes.rightCast{n_rcast}; 
                kinData_modes.rightCastStart(n_rcast, 1) =all_events_filtered(i,1);
                kinData_modes.rightCastEnd(n_rcast, 1) = all_events_filtered(i,2);
                kinData_modes.allCastsStart(end+1, 1) = all_events_filtered(i,1);
                kinData_modes.allCastsEnd(end+1, 1) = all_events_filtered(i,2);

            case 2
                n_lturn = n_lturn+ 1;
                kinData_modes.leftTurn{n_lturn} = all_events_filtered(i,1):all_events_filtered(i,2);
                kinData_modes.leftTurnIndices(end+1:end+length(kinData_modes.leftTurn{n_lturn}), 1) = kinData_modes.leftTurn{n_lturn}; 
                kinData_modes.leftTurnStart(n_lturn, 1) = all_events_filtered(i,1);
                kinData_modes.leftTurnEnd(n_lturn, 1) = all_events_filtered(i,2);
                kinData_modes.allTurnsStart(end+1, 1) = all_events_filtered(i,1);
                kinData_modes.allTurnsEnd(end+1, 1) = all_events_filtered(i,2);

            case 3
                n_rturn = n_rturn + 1;
                kinData_modes.rightTurn{n_rturn} = all_events_filtered(i,1):all_events_filtered(i,2);
                kinData_modes.rightTurnIndices(end+1:end+length(kinData_modes.rightTurn{n_rturn}), 1) = kinData_modes.rightTurn{n_rturn}; 
                kinData_modes.rightTurnStart(n_rturn, 1) = all_events_filtered(i,1);
                kinData_modes.rightTurnEnd(n_rturn, 1) = all_events_filtered(i,2);
                kinData_modes.allTurnsStart(end+1, 1) = all_events_filtered(i,1);
                kinData_modes.allTurnsEnd(end+1, 1) = all_events_filtered(i,2);

            case 4
                n_stop = n_stop + 1;
                kinData_modes.stop{n_stop} = all_events_filtered(i,1):all_events_filtered(i,2);
                kinData_modes.stopIndices(end+1:end+length(kinData_modes.stop{n_stop}), 1) = kinData_modes.stop{n_stop}; 
                kinData_modes.stopStart(n_stop, 1) = all_events_filtered(i,1);
                kinData_modes.stopEnd(n_stop, 1) = all_events_filtered(i,2);

            case 7
                n_backup = n_backup + 1;
                kinData_modes.backup{n_backup} = all_events_filtered(i,1):all_events_filtered(i,2);
                kinData_modes.backupIndices(end+1:end+length(kinData_modes.backup{n_backup}), 1) = kinData_modes.backup{n_backup}; 
                kinData_modes.backupStart(n_backup, 1) = all_events_filtered(i,1);
                kinData_modes.backupEnd(n_backup, 1) = all_events_filtered(i,2);

            case 0
                n_unknown = n_unknown + 1;
                kinData_modes.unknown{n_unknown} = all_events_filtered(i,1):all_events_filtered(i,2);
                kinData_modes.unknownIndices(end+1:end+length(kinData_modes.unknown{n_unknown}), 1) = kinData_modes.unknown{n_unknown}; 
                kinData_modes.unknownStart(n_unknown, 1) = all_events_filtered(i,1);
                kinData_modes.unknownEnd(n_unknown, 1) = all_events_filtered(i,2);
        end
    end
    kinData_modes.allTurnsStart = sort(kinData_modes.allTurnsStart,'ascend');
    kinData_modes.allTurnsEnd = sort(kinData_modes.allTurnsEnd,'ascend');
    kinData_modes.allCastsStart = sort(kinData_modes.allCastsStart,'ascend');
    kinData_modes.allCastsEnd = sort(kinData_modes.allCastsEnd,'ascend');
    
end

        
