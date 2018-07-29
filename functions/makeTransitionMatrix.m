function [transition_matrix, number_transitions] = makeTransitionMatrix(all_events_filtered)
transition_matrix = zeros(7, 7);
for i = 1:length(all_events_filtered)-1
    transition_matrix(all_events_filtered(i, 3), all_events_filtered(i+1, 3)) =  transition_matrix(all_events_filtered(i, 3), all_events_filtered(i+1, 3)) + 1;
end
number_transitions = i+1;
transition_matrix = transition_matrix/number_transitions;