function [kinData_xml] = findFrames_AppliedHeadThresholdsAndSteps(kinData_xml)

    for i = 1:length(kinData_xml)
        for j = 1:length(kinData_xml{i}.thresholdApplied)
            idx = find(kinData_xml{i}.timestamps == kinData_xml{i}.thresholdApplied(j,1));
            kinData_xml{i}.thresholdApplied(j,3) = kinData_xml{i}.thresholdApplied(j,1);
            kinData_xml{i}.thresholdApplied(j,1) = idx;
        end

        for j = 1:length(kinData_xml{i}.step)
            idx = find(kinData_xml{i}.timestamps == kinData_xml{i}.step(j,1));
            kinData_xml{i}.step(j,3) = kinData_xml{i}.step(j,1);
            kinData_xml{i}.step(j,1) = idx;            
        end

    end

end