%% Compute Probability of Positives and Negatives
function [probab_1, probab_0] = findProbab(vec)

    probab_1 = length(find(vec == 1))/length(find(vec == 1 | vec == 0));
    probab_0 = length(find(vec == 0))/length(find(vec == 1 | vec == 0));

end
