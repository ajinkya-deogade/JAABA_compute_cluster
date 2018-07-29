function all_events_filtered = mergeConsecutive(all_events_filtered, m)
j = 2;
while j <= length(all_events_filtered)-1
    if all_events_filtered(j, 3) == m && all_events_filtered(j+1, 3) == m
        all_events_filtered(j-1, 2) = all_events_filtered(j, 2);
        all_events_filtered = all_events_filtered([1:j-1,j+1:end],:);
        all_events_filtered(:,4) = all_events_filtered(:,2)-all_events_filtered(:,1);
        j = 2;
    end
    j = j + 1;
end
all_events_filtered(:,4) = all_events_filtered(:,2)-all_events_filtered(:,1);