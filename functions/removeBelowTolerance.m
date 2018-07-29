function all_events_filtered = removeBelowTolerance(all_events_filtered, m, tol)
    
    j = 2;
    
    while j <= (length(all_events_filtered))
        if all_events_filtered(j, 3) == m && all_events_filtered(j, 4) <= tol
            all_events_filtered(j-1, 2) = all_events_filtered(j, 2);
            all_events_filtered = all_events_filtered([1:j-1,j+1:end],:);
            all_events_filtered(:,4) = all_events_filtered(:,2)-all_events_filtered(:,1);
            j = 2;
        end
        j = j + 1;
    end
    all_events_filtered(:,4) = all_events_filtered(:,2)-all_events_filtered(:,1);

end