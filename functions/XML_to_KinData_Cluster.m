%  Author: Ajinkya Deogade
%  Organisation: Center for Genomic Regulation
%  Year: 2014
%  Description: Converts XML log files to KinData Format

function [flag, save_file, kinData_xml] = XML_to_KinData_Cluster(inputfile, outputfolder, lab)
%% Convert XML data from close loop tracker to kinData structure
% Written by Ajinkya Deogade

close all;
tic
kinData_xml = {};
fps = 30;

%% image scale and zaber scale
if lab == 1
    scale=8.2/1000; %mm/pxl Janelia
    scale2=0.0005; %Stage Calibration Janelia (tick per mm): x = 2000, y= 1961
else
    scale = 7.62/1000; %mm/pxl Barcelona
    scale2 = 0.000495; %Stage Calibration Barcelona (tick/mm): x = 2007, y=2032
end

%% Gather all Files
% currentDir = pwd;
% fileList = dir(fullfile(rootdir, '*.xml'));
totalFiles = 1;

parfor i = 1:totalFiles
    %     try
%     display(sprintf('Working on file %s \n', num2str(i)))
    drawnow
    s2 = {};
    
    [s_1] = xml2struct_2(inputfile);
    
    s_1 = s_1.logSession;
    
    for j = 1:length(s_1.larvaFrameData)
        
              %% Motor Data
        % Head position (x, y)
        s2.motorData.raw.headposition(j,1) = str2double(s_1.larvaFrameData{j}.skeleton.head.Attributes.x);
        s2.motorData.raw.headposition(j,2) = str2double(s_1.larvaFrameData{j}.skeleton.head.Attributes.y);
        
        % Midpoint position
        s2.motorData.raw.midpointposition(j,1) = str2double(s_1.larvaFrameData{j}.skeleton.midpoint.Attributes.x);
        s2.motorData.raw.midpointposition(j,2) = str2double(s_1.larvaFrameData{j}.skeleton.midpoint.Attributes.y);
        
        % Tail position
        s2.motorData.raw.tailposition(j,1) = str2double(s_1.larvaFrameData{j}.skeleton.tail.Attributes.x);
        s2.motorData.raw.tailposition(j,2) = str2double(s_1.larvaFrameData{j}.skeleton.tail.Attributes.y);
        
        % Centroid position
        s2.motorData.raw.centroidposition(j,1) = str2double(s_1.larvaFrameData{j}.skeleton.centroid.Attributes.x);
        s2.motorData.raw.centroidposition(j,2) = str2double(s_1.larvaFrameData{j}.skeleton.centroid.Attributes.y);
        
        % Angles
        s2.motorData.raw.headangle(j,1) = str2double(s_1.larvaFrameData{j}.skeleton.Attributes.headToBodyAngle); % Head Angle
        s2.motorData.raw.bodyangle(j,1) = str2double(s_1.larvaFrameData{j}.skeleton.Attributes.tailBearing); % Tail Bearing
        
        % Time Stamp
        s2.timestamps(j, 1) = str2double(s_1.larvaFrameData{j}.skeleton.Attributes.captureTime); % Tail Bearing
        
        % Body Length
        s2.motorData.raw.length(j, 1) = str2double(s_1.larvaFrameData{j}.skeleton.Attributes.length); % Tail Bearing
        
        
        % Speeds
        s2.motorData.raw.headSpeed(j,1) = str2double(s_1.larvaFrameData{j}.Attributes.headSpeed);% Head Speed
        s2.motorData.raw.centroidSpeed(j,1) = str2double(s_1.larvaFrameData{j}.Attributes.centroidSpeed);% Centroid Speed
        s2.motorData.raw.midpointSpeed(j,1) = str2double(s_1.larvaFrameData{j}.Attributes.midpointSpeed);% Midpoint Speed
        s2.motorData.raw.tailSpeed(j,1) = str2double(s_1.larvaFrameData{j}.Attributes.tailSpeed);% Tail Speed
        s2.motorData.raw.headangleSpeed(j,1) = str2double(s_1.larvaFrameData{j}.Attributes.headAngleSpeed);% Head Angle Speed
        s2.motorData.raw.bodyangleSpeed(j,1) = str2double(s_1.larvaFrameData{j}.Attributes.bodyAngleSpeed); % Body Angle Speed
        s2.motorData.raw.smoothedHeadAngleSpeed(j,1) = str2double(s_1.larvaFrameData{j}.Attributes.smoothedHeadAngleSpeed);% Smoothed Head Angle Speed
        s2.motorData.raw.smoothedBodyAngleSpeed(j,1) = str2double(s_1.larvaFrameData{j}.Attributes.smoothedBodyAngleSpeed);% Smoothed Body Angle Speed
        s2.motorData.raw.smoothedTailSpeedDotBodyAngle(j,1) = str2double(s_1.larvaFrameData{j}.Attributes.smoothedTailSpeedDotBodyAngle);% Smoothed Tail Speed Dot BodyAngle
        s2.motorData.raw.tailSpeedDotBodyAngle(j,1) = str2double(s_1.larvaFrameData{j}.Attributes.tailSpeedDotBodyAngle);% Tail Speed Dot BodyAngle
        
        % Misc
        s2.motorData.raw.timeSinceLastBehaviorModeChange(j,1) = str2double(s_1.larvaFrameData{j}.Attributes.timeSinceLastBehaviorModeChange);% Time Since Last Behavior ModeChange
        s2.motorData.raw.maxLength(j,1) = str2double(s_1.larvaFrameData{j}.Attributes.derivedMaxLength);% Max Length
        s2.motorData.raw.behaviorMode{j,1} = s_1.larvaFrameData{j}.Attributes.behaviorMode; % Behavior Mode
        
        %% Sensory Data
        s2.sensoryData.ledStimulusPercentageMax(j,1) = str2double(s_1.larvaFrameData{j}.ledStimulus.intensityPercentage.Text); % LED Intensity in Percentage of Max Voltage
        s2.sensoryData.ledStimulusWperMS(j,1) = 0.0677*str2double(s_1.larvaFrameData{j}.ledStimulus.intensityPercentage.Text) - 0.0974; % LED Intensity in Watts per meter square based on calibration : WMS = 0.0677*PercentMaxVoltage - 0.0974
        if s2.sensoryData.ledStimulusWperMS(j,1) < 0
            s2.sensoryData.ledStimulusWperMS(j,1) = 0;
        end
        s2.sensoryData.duration(j,1) = str2double(s_1.larvaFrameData{j}.ledStimulus.duration.Text); % Duration of Stimulus
        
    end
    
    %% _________User Defined Environment Parameters__________
    
    %% For Light Landscape Biorule 1.7
    if isfield(s_1,'definedEnvironmentBasedUponOrientation')
        s2.definedEnvironmentBasedUponOrientation.ledActivationDuration = str2double(s_1.definedEnvironmentBasedUponOrientation.ledActivationDuration.Text);
        s2.definedEnvironmentBasedUponOrientation.enableOrientationLogic = s_1.definedEnvironmentBasedUponOrientation.enableOrientationLogic.Text;
        s2.definedEnvironmentBasedUponOrientation.orientationDerivationDuration = str2double(s_1.definedEnvironmentBasedUponOrientation.orientationDerivationDuration.Text);
        s2.definedEnvironmentBasedUponOrientation.centroidDistanceFromArenaCenter = str2double(s_1.definedEnvironmentBasedUponOrientation.centroidDistanceFromArenaCenter.Text);
        s2.definedEnvironmentBasedUponOrientation.centeredOrientationOffsetInDegrees = str2double(s_1.definedEnvironmentBasedUponOrientation.centeredOrientationOffsetInDegrees.Text);
        if isfield(s_1.definedEnvironmentBasedUponOrientation.intensityFilterFunctionList,'behaviorLimitedKinematicVariableFunction')
            s2.definedEnvironmentBasedUponOrientation.intensityFilterFunctionList.values = str2double(s_1.definedEnvironmentBasedUponOrientation.intensityFilterFunctionList.behaviorLimitedKinematicVariableFunction.values.Text);
            s2.definedEnvironmentBasedUponOrientation.intensityFilterFunctionList.isAdditive = s_1.definedEnvironmentBasedUponOrientation.intensityFilterFunctionList.behaviorLimitedKinematicVariableFunction.isAdditive.Text;
        else
            s2.definedEnvironmentBasedUponOrientation.intensityFilterFunctionList = str2double(s_1.definedEnvironmentBasedUponOrientation.intensityFilterFunctionList.Text);
        end
        s2.definedEnvironmentBasedUponOrientation.signalToNoiseRatio = str2double(s_1.definedEnvironmentBasedUponOrientation.signalToNoiseRatio.Text);
        s2.definedEnvironmentBasedUponOrientation.intensityFunction.variable = s_1.definedEnvironmentBasedUponOrientation.intensityFunction.variable.Text;
        s2.definedEnvironmentBasedUponOrientation.intensityFunction.maximumVariableX = str2double(s_1.definedEnvironmentBasedUponOrientation.intensityFunction.maximumVariableX.Text);
        s2.definedEnvironmentBasedUponOrientation.intensityFunction.maximumVariableY = str2double(s_1.definedEnvironmentBasedUponOrientation.intensityFunction.maximumVariableY.Text);
        s2.definedEnvironmentBasedUponOrientation.intensityFunction.positionRangeErrorHandlingMethod = s_1.definedEnvironmentBasedUponOrientation.intensityFunction.positionRangeErrorHandlingMethod.Text;
        s2.definedEnvironmentBasedUponOrientation.intensityFunction.columnCount = str2double(s_1.definedEnvironmentBasedUponOrientation.intensityFunction.columnCount.Text);
        s2.definedEnvironmentBasedUponOrientation.intensityFunction.rowCount = str2double(s_1.definedEnvironmentBasedUponOrientation.intensityFunction.rowCount.Text);
        %% Light Landscape
        s2.definedEnvironmentBasedUponOrientation.intensityFunction.factorX = str2double(s_1.definedEnvironmentBasedUponOrientation.intensityFunction.factorX.Text);
        s2.definedEnvironmentBasedUponOrientation.intensityFunction.factorY = str2double(s_1.definedEnvironmentBasedUponOrientation.intensityFunction.factorY.Text);
        temp_val_2 = textscan(s_1.definedEnvironmentBasedUponOrientation.intensityFunction.values.Text, '%f', 'Delimiter', {',','|'},'MultipleDelimsAsOne', 1);
        s2.definedEnvironmentBasedUponOrientation.intensityFunction.landscape = reshape(temp_val_2{:}, s2.definedEnvironmentBasedUponOrientation.intensityFunction.rowCount, s2.definedEnvironmentBasedUponOrientation.intensityFunction.columnCount);

        %% Offsets and Rotations
        s2.ruleData.rotationCenter = str2num(s_1.ruleData{1}.Attributes.value);
        s2.ruleData.rotationAngleInDegrees = str2double(s_1.ruleData{2}.Attributes.value);
        s2.ruleData.xOffset = str2double(s_1.ruleData{3}.Attributes.value);
        s2.ruleData.yOffset = str2double(s_1.ruleData{4}.Attributes.value);
    end
    
    %% For Discrete Sampling Biorule 8.6
    if isfield(s_1,'samplingWithMaintainedIntensityAndRandomSteps')
        s2.samplingWithMaintainedIntensityAndRandomSteps.ledActivationDuration = str2double(s_1.samplingWithMaintainedIntensityAndRandomSteps.ledActivationDuration.Text);
        s2.samplingWithMaintainedIntensityAndRandomSteps.baselineIntensityPercentage = str2double(s_1.samplingWithMaintainedIntensityAndRandomSteps.baselineIntensityPercentage.value.Text);
        s2.samplingWithMaintainedIntensityAndRandomSteps.noStimulusStartDuration = str2double(s_1.samplingWithMaintainedIntensityAndRandomSteps.noStimulusStartDuration.Text);
        s2.samplingWithMaintainedIntensityAndRandomSteps.resetMinimumIntensityPercentage = str2double(s_1.samplingWithMaintainedIntensityAndRandomSteps.resetMinimumIntensityPercentage.Text);
        s2.samplingWithMaintainedIntensityAndRandomSteps.resetMaximumIntensityPercentage = str2double(s_1.samplingWithMaintainedIntensityAndRandomSteps.resetMaximumIntensityPercentage.Text);
        
        s2.samplingWithMaintainedIntensityAndRandomSteps.forwardRampFunction.timeMin = str2double(s_1.samplingWithMaintainedIntensityAndRandomSteps.forwardRampFunction.minimumInputValue.Text);
        s2.samplingWithMaintainedIntensityAndRandomSteps.forwardRampFunction.timeMax = str2double(s_1.samplingWithMaintainedIntensityAndRandomSteps.forwardRampFunction.maximumInputValue.Text);
        s2.samplingWithMaintainedIntensityAndRandomSteps.forwardRampFunction.values = str2double(s_1.samplingWithMaintainedIntensityAndRandomSteps.forwardRampFunction.values.Text);
        
        s2.samplingWithMaintainedIntensityAndRandomSteps.headAngleThresholds = textscan(s_1.samplingWithMaintainedIntensityAndRandomSteps.headAngleThresholdFunction.values.Text, '%f', 'Delimiter', {',','|'},'MultipleDelimsAsOne', 1);
        s2.samplingWithMaintainedIntensityAndRandomSteps.headAngleThresholds = sort(s2.samplingWithMaintainedIntensityAndRandomSteps.headAngleThresholds{:});
        s2.samplingWithMaintainedIntensityAndRandomSteps.stepFunction = textscan(s_1.samplingWithMaintainedIntensityAndRandomSteps.stepFunction.values.Text, '%f', 'Delimiter', {',','|'},'MultipleDelimsAsOne', 1);
        s2.samplingWithMaintainedIntensityAndRandomSteps.stepFunction = sort(s2.samplingWithMaintainedIntensityAndRandomSteps.stepFunction{:});
        s2.samplingWithMaintainedIntensityAndRandomSteps.maintainSamplingIntensityDuration = str2double(s_1.samplingWithMaintainedIntensityAndRandomSteps.maintainSamplingIntensityDuration.Text);
        s2.samplingWithMaintainedIntensityAndRandomSteps.boutsBeforeReset = str2double(s_1.samplingWithMaintainedIntensityAndRandomSteps.boutsBeforeReset.Text);
        
        if isfield(s_1.samplingWithMaintainedIntensityAndRandomSteps.intensityFilterFunctionList,'behaviorLimitedKinematicVariableFunction')
            s2.samplingWithMaintainedIntensityAndRandomSteps.intensityFilterFunctionList.values = str2double(s_1.samplingWithMaintainedIntensityAndRandomSteps.intensityFilterFunctionList.behaviorLimitedKinematicVariableFunction.values.Text);
            s2.samplingWithMaintainedIntensityAndRandomSteps.intensityFilterFunctionList.isAdditive = s_1.samplingWithMaintainedIntensityAndRandomSteps.intensityFilterFunctionList.behaviorLimitedKinematicVariableFunction.isAdditive.Text;
        else
            s2.samplingWithMaintainedIntensityAndRandomSteps.intensityFilterFunctionList = str2double(s_1.samplingWithMaintainedIntensityAndRandomSteps.intensityFilterFunctionList.Text);
        end
        
        %% Rule Data
        s2.thresholdApplied = [];
        s2.boutReset = [];
        s2.step = [];
        for eventLength = 1:length(s_1.ruleData)
            if strcmp(s_1.ruleData{eventLength}.Attributes.name,'head angle threshold')
                s2.thresholdApplied(end+1, 1) = str2double(s_1.ruleData{eventLength}.Attributes.captureTime);
                s2.thresholdApplied(end, 2) = str2double(s_1.ruleData{eventLength}.Attributes.value);
            end
            if strcmp(s_1.ruleData{eventLength}.Attributes.name,'bout reset')
                s2.boutReset(end+1, 1) = str2double(s_1.ruleData{eventLength}.Attributes.captureTime);
                s2.boutReset(end, 2) = str2double(s_1.ruleData{eventLength}.Attributes.value);
            end
            if strcmp(s_1.ruleData{eventLength}.Attributes.name,'step')
                s2.step(end+1, 1) = str2double(s_1.ruleData{eventLength}.Attributes.captureTime);
                s2.step(end, 2) = str2double(s_1.ruleData{eventLength}.Attributes.value);
            end
            
        end
    end
    
    %% Sampling
    if isfield(s_1, 'samplingWithMaintainedIntensity')
        s2.samplingWithMaintainedIntensity.ledActivationDuration = str2double(s_1.samplingWithMaintainedIntensity.ledActivationDuration.Text);
        s2.samplingWithMaintainedIntensity.baselineIntensityPercentage = str2double(s_1.samplingWithMaintainedIntensity.baselineIntensityPercentage.value.Text);
        s2.samplingWithMaintainedIntensity.maintainSamplingIntensityDuration = str2double(s_1.samplingWithMaintainedIntensity.maintainSamplingIntensityDuration.Text);
        s2.samplingWithMaintainedIntensity.intensityFilterFunctionList = str2double(s_1.samplingWithMaintainedIntensity.intensityFilterFunctionList.Text);
        s2.samplingWithMaintainedIntensity.boutsBeforeReset = str2double(s_1.samplingWithMaintainedIntensity.boutsBeforeReset.Text);
        
        s2.samplingWithMaintainedIntensity.samplingFunction.minimumInputValue = str2double(s_1.samplingWithMaintainedIntensity.samplingFunction.minimumInputValue.Text);
        s2.samplingWithMaintainedIntensity.samplingFunction.maximumInputValue = str2double(s_1.samplingWithMaintainedIntensity.samplingFunction.maximumInputValue.Text);
        s2.samplingWithMaintainedIntensity.samplingFunction.minimumOutputValue = str2double(s_1.samplingWithMaintainedIntensity.samplingFunction.minimumOutputValue.Text);
        s2.samplingWithMaintainedIntensity.samplingFunction.maximumOutputValue = str2double(s_1.samplingWithMaintainedIntensity.samplingFunction.maximumOutputValue.Text);
        s2.samplingWithMaintainedIntensity.samplingFunction.factor = str2double(s_1.samplingWithMaintainedIntensity.samplingFunction.factor.Text);
        s2.samplingWithMaintainedIntensity.samplingFunction.values = str2double(s_1.samplingWithMaintainedIntensity.samplingFunction.values.Text);
        s2.samplingWithMaintainedIntensity.samplingFunction.variable = s_1.samplingWithMaintainedIntensity.samplingFunction.variable.Text;
    end
    
    %% Behavioral Parameters
    s2.behaviorParameters.minHeadAngleForCasting = str2double(s_1.larvaBehaviorParameters.minHeadAngleForCasting.Text);
    s2.behaviorParameters.minHeadAngleToContinueCasting = str2double(s_1.larvaBehaviorParameters.minHeadAngleToContinueCasting.Text);
    s2.behaviorParameters.minHeadAngleSpeedToContinueCasting = str2double(s_1.larvaBehaviorParameters.minHeadAngleSpeedToContinueCasting.Text);
    s2.behaviorParameters.minBodyAngleSpeedForTurns = str2double(s_1.larvaBehaviorParameters.minBodyAngleSpeedForTurns.Text);
    s2.behaviorParameters.minBodyAngleSpeedDuration = str2double(s_1.larvaBehaviorParameters.minBodyAngleSpeedDuration.Text);
    s2.behaviorParameters.minHeadAngleToContinueTurning = str2double(s_1.larvaBehaviorParameters.minHeadAngleToContinueTurning.Text);
    s2.behaviorParameters.dotProductThresholdForStraightModes = str2double(s_1.larvaBehaviorParameters.dotProductThresholdForStraightModes.Text);
    s2.behaviorParameters.minBehaviorModeDuration = str2double(s_1.larvaBehaviorParameters.minBehaviorModeDuration.Text);
    s2.behaviorParameters.minStopOrBackUpDuration = str2double(s_1.larvaBehaviorParameters.minStopOrBackUpDuration.Text);
    s2.behaviorParameters.minCentroidSpeedToFlagJump = str2double(s_1.larvaBehaviorParameters.minCentroidSpeedToFlagJump.Text);
    s2.behaviorParameters.maxJumpFramesToSkip = str2double(s_1.larvaBehaviorParameters.maxJumpFramesToSkip.Text);
    s2.behaviorParameters.maxLengthDerivationDuration = str2double(s_1.larvaBehaviorParameters.maxLengthDerivationDuration.Text);
    
    %% Venkman Configuration Data
    s2.configuration = s_1.configuration;
    
    %% Start Time
    s2.startTime = s_1.Attributes.startTime;
    
    %% End Time
    s2.endTime = s_1.logMessage.Attributes.time;
    
    %% Frame Rate and Scales
    s2.fps = fps;
    s2.scales = [scale, scale2];
    
    %% Write to kinData Structure
    kinData_xml{i} = s2;
    %
    %     catch
    %         continue
    %     end
end
% kinData_xml = kinData_xml{1};
[~,name,~] = fileparts(inputfile);
save_file = fullfile(outputfolder, strcat(name,'_', 'kinVariables_xml.mat'));
save(save_file, 'kinData_xml', '-mat');
flag = 1;
% cd(currentDir)
toc
end
