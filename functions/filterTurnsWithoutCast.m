function all_events_filteredTurn = filterTurnsWithoutCast(all_events_filtered)
all_events_filteredTurn = all_events_filtered;
for i = 1:length(all_events_filtered(:,3))
    if i == 1
        if all_events_filtered(i, 3) == 2 || all_events_filtered(i, 3) == 3
            all_events_filteredTurn(1:end-1,:) = all_events_filteredTurn(2:end,:);
            all_events_filteredTurn(end,:) = [];
        end
    end
end