%  Author: Ajinkya Deogade
%  Organisation: Center for Genomic Regulation
%  Year: 2014
%  Description: 

function [kinData_xml] = makeSmoother_kinData_xml(kinData_xml)

    %% Initialization
    time_back = 1000; % time back in milliseconds
    fps = kinData_xml{1}.fps;
    frames_back = floor(fps*time_back/1000);
    wb = (frames_back*(frames_back+1))/2;

    parfor larvae = 1:length(kinData_xml)
        total_frames = length(kinData_xml{larvae}.motorData.raw.centroidposition);
        frames = 1:total_frames;
        
        %% Head Position
        [kinData_xml{larvae}.motorData.smoothed.headposition] = sgolayfilt(kinData_xml{larvae}.motorData.raw.headposition, 2, 57); %% Savitsky-Golay Filter
        
        %% Tail Position
        [kinData_xml{larvae}.motorData.smoothed.tailposition] = sgolayfilt(kinData_xml{larvae}.motorData.raw.tailposition, 2, 57); %% Savitsky-Golay Filter
        
        %% Centroid Position
        [kinData_xml{larvae}.motorData.smoothed.centroidposition] = sgolayfilt(kinData_xml{larvae}.motorData.raw.centroidposition, 2, 57); %% Savitsky-Golay Filter
        
        %% Midpoint Position 
        [kinData_xml{larvae}.motorData.smoothed.midpointposition] = sgolayfilt(kinData_xml{larvae}.motorData.raw.midpointposition, 2, 57); %% Savitsky-Golay Filter

        %% Body Angle
%         [kinData_xml{larvae}.motorData.smoothed.bodyangle] = filter_timeseries(kinData_xml{larvae}.motorData.raw.bodyangle, 10, 1); %% Averaging Filter
        [kinData_xml{larvae}.motorData.smoothed.bodyangle] = sgolayfilt(kinData_xml{larvae}.motorData.raw.bodyangle, 4, 15); %% Savitsky-Golay Filter

        %% Head Angle
        %[kinData_xml{larvae}.motorData.smoothed.headangle] = filter_timeseries(kinData_xml{larvae}.motorData.raw.headangle, 10, 1); %% Averaging Filter
        [kinData_xml{larvae}.motorData.smoothed.headangle] = sgolayfilt(kinData_xml{larvae}.motorData.raw.headangle, 4, 15); %% Savitsky-Golay Filter
        
        %% Reorientation speed -- Normal Average
        speed = NaN(1, total_frames);
        bodyangleUW = unwrap(kinData_xml{larvae}.motorData.smoothed.bodyangle); %ML: unwrap corrects for jumps larger than pi

        for i = 2:total_frames-1
            if length(intersect(i-1:i+1, frames)) == 3
                speed(i) = fps*(bodyangleUW(i+1)-bodyangleUW(i-1))/2; %ML: reorientation speed
            end
        end
        %     kinData_xml{larvae}.motorData.smoothed.bodyangleSpeed_norm_average = speed;

        %% Reorientation speed -- Weighted Average
        speedM = NaN(1,total_frames);
        for i = frames_back:total_frames-1 % avoiding the first Nb frames - ML: used for the weighted average
            ki = 1:frames_back;
            % what is there is a NaN around there...
            vecVW = (frames_back+1-ki).*speed(i+1-ki); %ML: weighted sum where the point furthest in the past contribute less
            speedM(i) = (1/wb)*sum(vecVW);
        end
        kinData_xml{larvae}.motorData.smoothed.bodyangleSpeed = speedM;

        %% Head Angle Speed -- Normal Average
        speed = NaN(1,total_frames);
        for i=2:total_frames-1
            if length(intersect(i-1:i+1,frames))==3
                speed(i)=fps*(kinData_xml{larvae}.motorData.smoothed.headangle(i+1) - kinData_xml{larvae}.motorData.smoothed.headangle(i-1))/2;
            end
        end

        %% Head Angle Speed -- Weighted Average
        speedM = NaN(1,total_frames);
        for i=frames_back:total_frames-1 % avoiding the first Nb frames
            ki=1:frames_back;
            % what is there is a NaN around there...
            vecVW=(frames_back+1-ki).*speed(i+1-ki);
            speedM(i)=(1/wb)*sum(vecVW);
        end
        kinData_xml{larvae}.motorData.smoothed.headangleSpeed = speedM;

        %% Head Speed
        speed = NaN(1,total_frames);
        for i = 2:total_frames-1
            if length(intersect(i-1:i+1,frames))==3
                dx2 = (kinData_xml{larvae}.motorData.raw.headposition(i+1,1) - kinData_xml{larvae}.motorData.raw.headposition(i-1,1))^2/4;
                dy2 = (kinData_xml{larvae}.motorData.raw.headposition(i+1,2) - kinData_xml{larvae}.motorData.raw.headposition(i-1,2))^2/4;
                speed(i) = fps*sqrt(dx2+dy2);
            end
        end

        speedM = NaN(1,total_frames);
        for i=frames_back:total_frames-1 % avoiding the first Nb frames
            ki=1:frames_back;
            % what is there is a NaN around there...
            vecVW=(frames_back+1-ki).*speed(i+1-ki);
            speedM(i)=(1/wb)*sum(vecVW);
        end
        kinData_xml{larvae}.motorData.smoothed.headSpeed = speedM;

        %% Tail speed
        speed=NaN(1,total_frames);
        for i=2:total_frames-1
            if length(intersect(i-1:i+1,frames))==3
                dx2=(kinData_xml{larvae}.motorData.raw.tailposition(i+1,1) - kinData_xml{larvae}.motorData.raw.tailposition(i-1,1))^2/4;
                dy2=(kinData_xml{larvae}.motorData.raw.tailposition(i+1,2) - kinData_xml{larvae}.motorData.raw.tailposition(i-1,2))^2/4;
                speed(i)=fps*sqrt(dx2+dy2);
            end
        end
        speedM=NaN(1,total_frames);
        for i=frames_back:total_frames-1; % avoiding the first Nb frames
            ki=1:frames_back;
            % what is there is a NaN around there...
            vecVW=(frames_back+1-ki).*speed(i+1-ki);
            speedM(i)=(1/wb)*sum(vecVW);
        end
        kinData_xml{larvae}.motorData.smoothed.tailSpeed = speedM;

        %% Centroid Speed
        speed=NaN(1,total_frames);
        for i=2:total_frames-1
            if length(intersect(i-1:i+1,frames))==3
                dx2=(kinData_xml{larvae}.motorData.raw.centroidposition(i+1,1) - kinData_xml{larvae}.motorData.raw.centroidposition(i-1,1))^2/4;
                dy2=(kinData_xml{larvae}.motorData.raw.centroidposition(i+1,2) - kinData_xml{larvae}.motorData.raw.centroidposition(i-1,2))^2/4;
                speed(i)=fps*sqrt(dx2+dy2);
            end
        end
        speedM=NaN(1,total_frames);
        for i=frames_back:total_frames-1 % avoiding the first Nb frames
            ki=1:frames_back;
            % what is there is a NaN around there...
            vecVW=(frames_back+1-ki).*speed(i+1-ki);
            speedM(i)=(1/wb)*sum(vecVW);
        end
        kinData_xml{larvae}.motorData.smoothed.centroidSpeed = speedM;

        %% MIDPOINT speed (new)
        speed=NaN(1,total_frames);
        for i=2:total_frames-1
            if length(intersect(i-1:i+1,frames))==3
                dx2=(kinData_xml{larvae}.motorData.raw.midpointposition(i+1,1) - kinData_xml{larvae}.motorData.raw.midpointposition(i-1,1))^2/4;
                dy2=(kinData_xml{larvae}.motorData.raw.midpointposition(i+1,2) - kinData_xml{larvae}.motorData.raw.midpointposition(i-1,2))^2/4;
                speed(i)=fps*sqrt(dx2+dy2);
            end
        end
        speedM=NaN(1,total_frames);
        for i=frames_back:total_frames-1 % avoiding the first Nb frames
            ki=1:frames_back;
            % what is there is a NaN around there...
            vecVW=(frames_back+1-ki).*speed(i+1-ki);
            speedM(i)=(1/wb)*sum(vecVW);
        end
        kinData_xml{larvae}.motorData.smoothed.midpointSpeed = speedM;

        %% Led speed
        speed=NaN(1,total_frames);
        for i=2:total_frames-1
            if length(intersect(i-1:i+1,frames))==3
                speed(i)=fps*(kinData_xml{larvae}.sensoryData.ledStimulusWperMS(i+1) - kinData_xml{larvae}.sensoryData.ledStimulusWperMS(i-1))/2;
            end
        end
        ledSpeedRaw = speed;
        %
        speedM=NaN(1,total_frames);
        for i=frames_back:total_frames-1 % avoiding the first Nb frames
            ki=1:frames_back;
            % what is there is a NaN around there...
            vecVW=(frames_back+1-ki).*speed(i+1-ki);
            speedM(i)=(1/wb)*sum(vecVW);
        end
        kinData_xml{larvae}.sensoryData.ledStimulusWperMS_Speed = speedM;

    end
end