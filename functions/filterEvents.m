function all_events_filteredTurn = filterEvents(all_events_sorted, tolerance)

    behaviors = 1:7;
    all_events_filtered = all_events_sorted;
    index_zero = find(all_events_filtered(:, 4) == 0);
    all_events_filtered(index_zero-1, 2) = all_events_filtered(index_zero, 2);
    all_events_filtered(index_zero, :) = [];
    for i = 1:length(behaviors)
        all_events_filtered = removeBelowTolerance(all_events_filtered, behaviors(i), tolerance(i));
        for m = 1:length(behaviors)
            all_events_filtered = mergeConsecutive(all_events_filtered, m);
        end
    end
    all_events_filteredTurn = filterTurnsWithoutCast(all_events_filtered);

end