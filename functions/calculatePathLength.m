function [kinData_xml] = calculatePathLength(kinData_xml)
%% Calculate Path Length

%% Main
for i = 1:length(kinData_xml)
    midpointsPastX = kinData_xml{i}.motorData.smoothed.midpointposition(1:end-1, 1);
    midpointsPastY = kinData_xml{i}.motorData.smoothed.midpointposition(1:end-1, 2);
    midpointsFutureX = kinData_xml{i}.motorData.smoothed.midpointposition(2:end, 1);
    midpointsFutureY = kinData_xml{i}.motorData.smoothed.midpointposition(2:end, 2);
    distance = sqrt((midpointsFutureX-midpointsPastX).^2+(midpointsFutureY-midpointsPastY).^2);
    kinData_xml{i}.motorData.smoothed.pathLength = cumsum(distance);
    kinData_xml{i}.motorData.smoothed.stepLength = diff([0; kinData_xml{i}.motorData.smoothed.pathLength]);
    kinData_xml{i}.motorData.smoothed.totalDistanceTravelled = sum(distance(:));
end