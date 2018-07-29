%  Author: Ajinkya Deogade
%  Organisation: Center for Genomic Regulation
%  Year: 2014
%  Description: 

function [kinData_xml] = calculateBearing(kinData_xml)

    for i = 1:length(kinData_xml)
        bodyangleUW = deg2rad(kinData_xml{i}.motorData.smoothed.bodyangle);
%         bodyangleUW = deg2rad(kinData_xml{i}.motorData.smoothed.bodyangle)+deg2rad(kinData_xml{i}.motorData.smoothed.headangle);
        for j = 1:length(bodyangleUW)
            diff_1 = kinData_xml{i}.sensoryData.gradient.atMidpoint.gradientDirection(j) - bodyangleUW(j);
%             diff_1 = kinData_xml{i}.sensoryData.gradient.atHead.gradientDirection(j) - bodyangleUW(j);
            bearing = atan2(sin(diff_1), cos(diff_1));
            kinData_xml{i}.sensoryData.bearing(j) = bearing;
        end
    end
    
end