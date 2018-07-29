%  Author: Ajinkya Deogade
%  Organisation: Center for Genomic Regulation
%  Year: 2014
%  Description: 

function [kinData_xml_landscape] = calculateGradient(kinData_xml, scaling_up_factor)

        landscape = kinData_xml{1}.definedEnvironmentBasedUponOrientation.intensityFunction.landscape;
        landscape(end+1, 1600) = min(landscape(:));
%         landscape(find(landscape < 2.7)) = 2.7;
        [scaled_up_landscape] = scaleUp_Matrix(landscape, scaling_up_factor);
        scaled_up_landscape(isnan(scaled_up_landscape(:))) = min(scaled_up_landscape(:));
        
        [dx, dy] = gradient(scaled_up_landscape);
        gradientDirection = atan2(dy, dx);
        gradientIntensity = sqrt(dx.^2 + dy.^2);
        
        kinData_xml_landscape.gradient.scaling_up_factor = scaling_up_factor;
        kinData_xml_landscape.gradient.landscape = scaled_up_landscape;
        kinData_xml_landscape.gradient.dx = dx;
        kinData_xml_landscape.gradient.dy = dy;
        kinData_xml_landscape.gradientDirection = gradientDirection;
        kinData_xml_landscape.gradientIntensity = gradientIntensity;
    
end