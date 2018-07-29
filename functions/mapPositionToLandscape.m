%  Author: Ajinkya Deogade
%  Organisation: Center for Genomic Regulation
%  Year: 2014
%  Description:

function [kinData_xml] = mapPositionToLandscape(kinData_xml, kinData_xml_landscape)

for j = 1:length(kinData_xml)
    
    scale_up_factor = kinData_xml_landscape.gradient.scaling_up_factor*4;
    
    gridHeadPos = round(kinData_xml{j}.motorData.raw.corrected.headposition .* scale_up_factor);
    gridCentroidPos = round(kinData_xml{j}.motorData.raw.corrected.centroidposition .* scale_up_factor);
    gridTailPos = round(kinData_xml{j}.motorData.raw.corrected.tailposition .* scale_up_factor);
    gridMidpointPos = round(kinData_xml{j}.motorData.raw.corrected.midpointposition .* scale_up_factor);
    
    for i = 1:length(gridHeadPos)
        %             try
        %% Gradients @Head
        kinData_xml{j}.sensoryData.gradient.atHead.dx(i) = kinData_xml_landscape.gradient.dx(gridHeadPos(i,1),gridHeadPos(i,2));
        kinData_xml{j}.sensoryData.gradient.atHead.dy(i) = kinData_xml_landscape.gradient.dy(gridHeadPos(i,1),gridHeadPos(i,2));
        kinData_xml{j}.sensoryData.gradient.atHead.gradientDirection(i) = kinData_xml_landscape.gradientDirection(gridHeadPos(i,1),gridHeadPos(i,2));
        kinData_xml{j}.sensoryData.gradient.atHead.gradientIntensity(i) = kinData_xml_landscape.gradientIntensity(gridHeadPos(i,1),gridHeadPos(i,2));
        %         catch
        %             continue
        %     end
        
        %     try
        %% Gradients @Tail
        kinData_xml{j}.sensoryData.gradient.atTail.dx(i) = kinData_xml_landscape.gradient.dx(gridTailPos(i,1),gridTailPos(i,2));
        kinData_xml{j}.sensoryData.gradient.atTail.dy(i) = kinData_xml_landscape.gradient.dy(gridTailPos(i,1),gridTailPos(i,2));
        kinData_xml{j}.sensoryData.gradient.atTail.gradientDirection(i) = kinData_xml_landscape.gradientDirection(gridTailPos(i,1),gridTailPos(i,2));
        kinData_xml{j}.sensoryData.gradient.atTail.gradientIntensity(i) = kinData_xml_landscape.gradientIntensity(gridTailPos(i,1),gridTailPos(i,2));
        %     catch
        %         continue
        %     end
        
        %     try
        %% Gradients @Centroid
        kinData_xml{j}.sensoryData.gradient.atCentroid.dx(i) = kinData_xml_landscape.gradient.dx(gridCentroidPos(i,1),gridCentroidPos(i,2));
        kinData_xml{j}.sensoryData.gradient.atCentroid.dy(i) = kinData_xml_landscape.gradient.dy(gridCentroidPos(i,1),gridCentroidPos(i,2));
        kinData_xml{j}.sensoryData.gradient.atCentroid.gradientDirection(i) = kinData_xml_landscape.gradientDirection(gridCentroidPos(i,1),gridCentroidPos(i,2));
        kinData_xml{j}.sensoryData.gradient.atCentroid.gradientIntensity(i) = kinData_xml_landscape.gradientIntensity(gridCentroidPos(i,1),gridCentroidPos(i,2));
        %     catch
        %         continue
        %     end
        
        %     try
        %% Gradients @Midpoint
        kinData_xml{j}.sensoryData.gradient.atMidpoint.dx(i) = kinData_xml_landscape.gradient.dx(gridMidpointPos(i,1),gridMidpointPos(i,2));
        kinData_xml{j}.sensoryData.gradient.atMidpoint.dy(i) = kinData_xml_landscape.gradient.dy(gridMidpointPos(i,1),gridMidpointPos(i,2));
        kinData_xml{j}.sensoryData.gradient.atMidpoint.gradientDirection(i) = kinData_xml_landscape.gradientDirection(gridMidpointPos(i,1),gridMidpointPos(i,2));
        kinData_xml{j}.sensoryData.gradient.atMidpoint.gradientIntensity(i) = kinData_xml_landscape.gradientIntensity(gridMidpointPos(i,1),gridMidpointPos(i,2));
        %     catch
        %         continue
        %     end
    end
    %     end
end
