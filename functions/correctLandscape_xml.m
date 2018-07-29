%  Author: Ajinkya Deogade
%  Organisation: Center for Genomic Regulation
%  Year: 2014
%  Description: 

function [kinData_xml] = correctLandscape_xml(kinData_xml)
i = 3;
theta = kinData_xml{i}.ruleData.rotationAngleInDegrees;
rotation_center = kinData_xml{i}.ruleData.rotationCenter';
rotation_matrix = [cos(theta), -1*sin(theta); sin(theta), cos(theta)];
translation_matrix = [kinData_xml{i}.ruleData.xOffset; kinData_xml{i}.ruleData.yOffset];

headposition = kinData_xml{i}.motorData.headposition';
tailposition = kinData_xml{i}.motorData.tailposition';
centroidposition = kinData_xml{i}.motorData.centroidposition';
midpointposition = kinData_xml{i}.motorData.midpointposition';

%% Head
%% Translate Values to Origin
headposition_translate(1,:) = headposition(1,:) - rotation_center(1,1);
headposition_translate(2,:) = headposition(2,:) - rotation_center(2,1);

%% Rotate about the origin and translate back
headposition_trans_rotated = rotation_matrix * headposition_translate;
headposition_trans_rot_trans(1,:) = headposition_trans_rotated(1,:) + rotation_center(1,1);
headposition_trans_rot_trans(2,:) = headposition_trans_rotated(2,:) + rotation_center(2,1);

%% Correct the Offset
headposition_trans_rotated(1,:) = headposition_trans_rot_trans(1,:) + translation_matrix(1,1);
headposition_trans_rotated(2,:) = headposition_trans_rot_trans(2,:) + translation_matrix(2,1);

%% Tail
%% Translate Values to Origin
tailposition_translate(1,:) = headposition(1,:) - rotation_center(1,1);
tailposition_translate(2,:) = headposition(2,:) - rotation_center(2,1);

%% Rotate about the origin and translate back
tailposition_trans_rotated = rotation_matrix * tailposition_translate;
tailposition_trans_rot_trans(1,:) = tailposition_trans_rotated(1,:) + rotation_center(1,1);
tailposition_trans_rot_trans(2,:) = tailposition_trans_rotated(2,:) + rotation_center(2,1);

%% Correct the Offset
tailposition_trans_rotated(1,:) = tailposition_trans_rot_trans(1,:) + translation_matrix(1,1);
tailposition_trans_rotated(2,:) = tailposition_trans_rot_trans(2,:) + translation_matrix(2,1);

%% Centroid
%% Translate Values to Origin
centroidposition_translate(1,:) = headposition(1,:) - rotation_center(1,1);
centroidposition_translate(2,:) = headposition(2,:) - rotation_center(2,1);

%% Rotate about the origin and translate back
centroidposition_trans_rotated = rotation_matrix * centroidposition_translate;
centroidposition_trans_rot_trans(1,:) = centroidposition_trans_rotated(1,:) + rotation_center(1,1);
centroidposition_trans_rot_trans(2,:) = centroidposition_trans_rotated(2,:) + rotation_center(2,1);

%% Correct the Offset
centroidposition_trans_rotated(1,:) = centroidposition_trans_rot_trans(1,:) + translation_matrix(1,1);
centroidposition_trans_rotated(2,:) = centroidposition_trans_rot_trans(2,:) + translation_matrix(2,1);

%% Midpoint
%% Translate Values to Origin
midpointposition_translate(1,:) = headposition(1,:) - rotation_center(1,1);
midpointposition_translate(2,:) = headposition(2,:) - rotation_center(2,1);

%% Rotate about the origin and translate back
midpointposition_trans_rotated = rotation_matrix * midpointposition_translate;
midpointposition_trans_rot_trans(1,:) = midpointposition_trans_rotated(1,:) + rotation_center(1,1);
midpointposition_trans_rot_trans(2,:) = midpointposition_trans_rotated(2,:) + rotation_center(2,1);

%% Correct the Offset
midpointposition_trans_rotated(1,:) = midpointposition_trans_rot_trans(1,:) + translation_matrix(1,1);
midpointposition_trans_rotated(2,:) = midpointposition_trans_rot_trans(2,:) + translation_matrix(2,1);

imagesc(kinData_xml{1}.definedEnvironmentBasedUponOrientation.intensityFunction.landscape)
hold on
plot(headposition_trans_rotated(1,:), headposition_trans_rotated(2,:),'w.-');
hold off;


end