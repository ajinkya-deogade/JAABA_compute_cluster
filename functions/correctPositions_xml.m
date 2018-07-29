%  Author: Ajinkya Deogade
%  Organisation: Center for Genomic Regulation
%  Year: 2014
%  Description: 

function [kinData_xml] = correctPositions_xml(kinData_xml)

    for i = 1:length(kinData_xml)
        
        theta = kinData_xml{i}.ruleData.rotationAngleInDegrees*pi/180;
        rotation_center = kinData_xml{i}.ruleData.rotationCenter';
        rotation_matrix = [cos(theta), -1*sin(theta); sin(theta), cos(theta)];
        translation_matrix = [kinData_xml{i}.ruleData.xOffset; kinData_xml{i}.ruleData.yOffset];

        headposition = kinData_xml{i}.motorData.raw.headposition';
        tailposition = kinData_xml{i}.motorData.raw.tailposition';
        centroidposition = kinData_xml{i}.motorData.raw.centroidposition';
        midpointposition = kinData_xml{i}.motorData.raw.midpointposition';
        
        headposition_translate = [];
        tailposition_translate = [];
        centroidposition_translate = [];
        midpointposition_translate = [];
        
        headposition_trans_rotated = [];
        tailposition_trans_rotated = [];
        centroidposition_trans_rotated = [];
        midpointposition_trans_rotated = [];
        
        headposition_trans_rot_trans = [];
        tailposition_trans_rot_trans = [];
        centroidposition_trans_rot_trans = [];
        midpointposition_trans_rot_trans = [];
        
        headposition_corrected = [];
        tailposition_corrected = [];
        centroidposition_corrected = [];
        midpointposition_corrected = [];

        %% Head
            %% Translate Values to Origin
            headposition_translate(1,:) = headposition(1,:) - rotation_center(1,1);
            headposition_translate(2,:) = headposition(2,:) - rotation_center(2,1);

            %% Rotate about the origin and translate back
            headposition_trans_rotated = rotation_matrix * headposition_translate;
            headposition_trans_rot_trans(1,:) = headposition_trans_rotated(1,:) + rotation_center(1,1);
            headposition_trans_rot_trans(2,:) = headposition_trans_rotated(2,:) + rotation_center(2,1);

            %% Correct the Offset
            headposition_corrected(1,:) = headposition_trans_rot_trans(1,:) + translation_matrix(1,1);
            headposition_corrected(2,:) = headposition_trans_rot_trans(2,:) + translation_matrix(2,1);

        %% Tail
            %% Translate Values to Origin
            tailposition_translate(1,:) = tailposition(1,:) - rotation_center(1,1);
            tailposition_translate(2,:) = tailposition(2,:) - rotation_center(2,1);

            %% Rotate about the origin and translate back
            tailposition_trans_rotated = rotation_matrix * tailposition_translate;
            tailposition_trans_rot_trans(1,:) = tailposition_trans_rotated(1,:) + rotation_center(1,1);
            tailposition_trans_rot_trans(2,:) = tailposition_trans_rotated(2,:) + rotation_center(2,1);

            %% Correct the Offset
            tailposition_corrected(1,:) = tailposition_trans_rot_trans(1,:) + translation_matrix(1,1);
            tailposition_corrected(2,:) = tailposition_trans_rot_trans(2,:) + translation_matrix(2,1);

        %% Centroid
            %% Translate Values to Origin
            centroidposition_translate(1,:) = centroidposition(1,:) - rotation_center(1,1);
            centroidposition_translate(2,:) = centroidposition(2,:) - rotation_center(2,1);

            %% Rotate about the origin and translate back
            centroidposition_trans_rotated = rotation_matrix * centroidposition_translate;
            centroidposition_trans_rot_trans(1,:) = centroidposition_trans_rotated(1,:) + rotation_center(1,1);
            centroidposition_trans_rot_trans(2,:) = centroidposition_trans_rotated(2,:) + rotation_center(2,1);

            %% Correct the Offset
            centroidposition_corrected(1,:) = centroidposition_trans_rot_trans(1,:) + translation_matrix(1,1);
            centroidposition_corrected(2,:) = centroidposition_trans_rot_trans(2,:) + translation_matrix(2,1);

        %% Midpoint
            %% Translate Values to Origin
            midpointposition_translate(1,:) = midpointposition(1,:) - rotation_center(1,1);
            midpointposition_translate(2,:) = midpointposition(2,:) - rotation_center(2,1);

            %% Rotate about the origin and translate back
            midpointposition_trans_rotated = rotation_matrix * midpointposition_translate;
            midpointposition_trans_rot_trans(1,:) = midpointposition_trans_rotated(1,:) + rotation_center(1,1);
            midpointposition_trans_rot_trans(2,:) = midpointposition_trans_rotated(2,:) + rotation_center(2,1);

            %% Correct the Offset
            midpointposition_corrected(1,:) = midpointposition_trans_rot_trans(1,:) + translation_matrix(1,1);
            midpointposition_corrected(2,:) = midpointposition_trans_rot_trans(2,:) + translation_matrix(2,1);
        
        %% Write to kinData
        kinData_xml{i}.motorData.raw.corrected.headposition = headposition_corrected';
        kinData_xml{i}.motorData.raw.corrected.tailposition = tailposition_corrected';
        kinData_xml{i}.motorData.raw.corrected.centroidposition = centroidposition_corrected';
        kinData_xml{i}.motorData.raw.corrected.midpointposition = midpointposition_corrected';

    end

end