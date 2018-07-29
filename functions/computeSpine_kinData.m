function kinData_spine = computeSpine_kinData(kinData)


    number_of_points = 200; % Number of contour points to be reconstructed
    t_initial = 1; % Starting Frame number
    t_final = length(kinData.headposition); % Final Frame number
    pixel_to_mm = kinData.scales(1,1); % Camera resolution
    abs_to_mm = kinData.scales(1,2); % Stage resolution of movement
    f = kinData.fourier; % fourier coefficients for the required larvae

    %% Reconstruct Contours
    [contours_x, contours_y] = fourierReconstruct2(f, number_of_points, 7);

    %% Extract kinData values
    x_stage_position_arena(:,1) = kinData.absX(:,1) .* abs_to_mm;
    y_stage_position_arena(:,1) = kinData.absY(:,1) .* abs_to_mm;

    x_head_position_arena(:,1) = kinData.headposition(:,1);
    y_head_position_arena(:,1) = kinData.headposition(:,2);

    x_tail_position_arena(:,1) = kinData.tailposition(:,1);
    y_tail_position_arena(:,1) = kinData.tailposition(:,2);

    x_midpoint_position_arena(:,1) = kinData.midposition(:,1);
    y_midpoint_position_arena(:,1) = kinData.midposition(:,2);

    x_centroid_position_arena(:,1) = kinData.centroidposition(:,1);
    y_centroid_position_arena(:,1) = kinData.centroidposition(:,2);

    % Flip in X and Y values
    x_contour_frame = contours_y * pixel_to_mm;
    y_contour_frame = contours_x * pixel_to_mm;

    % Coordinates with respect to whole arena
    x_contour_arena = bsxfun(@plus, x_contour_frame, x_stage_position_arena(:,1));
    y_contour_arena = bsxfun(@plus, y_contour_frame, y_stage_position_arena(:,1));

    % Centroid from the reconstructed larval contour
    x_centroid_contour_arena = mean(x_contour_frame, 2);
    y_centroid_contour_arena = mean(y_contour_frame, 2);
    kinData_spine = kinData;

    parfor t = t_initial:t_final
    %     contour(:,1) = x_contour_arena(t,:)';
    %     contour(:,2) = y_contour_arena(t,:)';
    %     headposition(1) = x_head_position_arena(t,:);
    %     headposition(2) = y_head_position_arena(t,:);
    %     tailposition(1) = x_tail_position_arena(t,:);
    %     tailposition(2) = y_tail_position_arena(t,:);
        [spineX(t,:), spineY(t,:)] = computeSpine([x_contour_arena(t,:)', y_contour_arena(t,:)'], [x_head_position_arena(t,:), y_head_position_arena(t,:)], [x_tail_position_arena(t,:), y_tail_position_arena(t,:)]);
    %     spineX(t,:) = spine(:,1);
    %     spineY(t,:) = spine(:,2);
    %     contourX(t,:) = x_contour_arena(t,:);
    %     kinData_spine.contourY(t,:) = y_contour_arena(t,:);
    end
    kinData_spine.spineX = spineX;
    kinData_spine.spineY = spineY;
    kinData_spine.contourX = x_contour_arena;
    kinData_spine.contourY = y_contour_arena;

end
