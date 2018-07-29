function [save_file, flag, kinData] = JLight(inputfile, outputfolder, lab)
% Written by Alex Gomez-Marin
% Modified by Matthieu Louis
% Modified by Ajinkya Deogade
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% clear
close all
tic
flag = 0;
kinData={};

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SCALES
% time tracking
fps=30;
% image scale
if lab == 1
    scale=8.2/1000; %mm/pxl Janelia
    scale2=0.0005; %Stage Calibration Janelia (tick per mm): x = 2000, y= 1961
else
    scale=7.62/1000; %mm/pxl Barcelona
    scale2=0.000495; %Stage Calibration Barcelona (tick/mm): x = 2007, y=2032
end
% zaber scale
%%scale2=0.000476; %mm/Step first callibration Janelia



%% DATA FOLDER

% rootdir='/Users/adeogade/Documents/MATLAB/WhereToTurn/DataFiles/20141129_SmallAmplitudeHeadCast_Additive_ConstantStimulus/'

% dataFiles = dir(rootdir); %ML: poll the list of file names contained in the target folder
% numberData = length(dataFiles); %ML: define the number of files in the target folder

% cd(rootdir)

%% Odor droplet source position
% load sourceXY.mat
% C0=scaling*15; %uM gas phase
% lambda=27; %mm

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

numberData = 1;
for jk=1:numberData
%     jk
    
    %     fnameDir = fullfile(rootdir, dataFiles(jk).name);
    %     cd(fnameDir)
    dataFile = inputfile;
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Based on tracker's output format, we read every piece of info:
    %
    fid = fopen(dataFile);
    nums = textscan(fid,'%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%*s%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f','delimiter',','); %ML unclear why there is 4*7 Fourier coefficients
    % this is 17 numbers, 18th raw I skip (stimulus), and then 28 number
    % (fourier coeffs), so that first fourier is at position 18th and last at (18-1)+4*7=45
    data=cell2mat(nums);
    fclose(fid);
    clear nums
    % reading the stimulus format
    fid = fopen(dataFile);
    stim=textscan(fid,'%*f%*f%*f%*f%*f%*f%*f%*f%*f%*f%*f%*f%*f%*f%*f%*f%*f%s%*f%*f%*f%*f%*f%*f%*f%*f%*f%*f%*f%*f%*f%*f%*f%*f%*f%*f%*f%*f%*f%*f%*f%*f%*f%*f%*f%*f','delimiter',','); %ML: %8 skip the field.
    % %s% is at position 18, which corresponds to the stimulus command.
    %ML: in the absence of LED signal, stim contains entries = 'time'
    fclose(fid);
    %
    
    %%ML: what's being done below is unclear
    stim3=stim{1}; % for all times
    stimA=nan(1,length(stim3));
    stimB=nan(1,length(stim3));
    for j=1:length(stim3)
        ccc=char(stim3(j)); %ML: creates character array from the jth entry of stim3
        spaces=find(ccc==' ');
        try % thus, 'time' detected as 0, as opposed to 'wave 100 60'
            % arrenage that cause "time" is not equal to "wave 0"!
            stimA(j)=str2num(ccc(spaces(1)+1:spaces(2)-1)); %ML: remains an NaN vector in case the LED command isn't defined
            stimB(j)=str2num(ccc(spaces(2)+1:length(ccc))); %ML: remains an NaN vector in case the LED command isn't defined
        catch, end
    end
    %%
    
    %%%%
    % notation!!!
    % wave 6535... this is a real led on
    % wave 0 this is a fake led on
    % time ... this is just nothing changing
    %  column 18 is the stimulus and is sent as either "time",
    %  which means no command, or "wave ___? ___" where the 2
    %  numbers after wave are the intensity (divide it by?2^16-1
    %  to get intensity as %) and duration in 100s of microseconds
    %  ?(so 60 ms = 600 100 microseconds)
    stimA=stimA/(2^16-1);
    led=stimA;
    clear stim stim3
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    Ttime=length(data(:,8)); %ML: number of time points
    frames=1:Ttime;
    times=(1:Ttime)/fps; %ML: time vector
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%% interpreting log data file information:
    % load columns as parameters
    % Output from tracker defined in the accompanying file called 20120124-161659_configuration
    index = data(:,1);
    time = data(:,2); %ML: time in seconds
    % in pixels
    xh = data(:,3);
    yh = data(:,4);
    xt = data(:,7);
    yt = data(:,8);
    skelL = scale*data(:,9); % in mm already
    xc = data(:,10);
    yc = data(:,11);
    headangle = data(:,12);
    bodyangle = data(:,13);
    % stages
    absX=data(:,14);
    absY=data(:,15);
    % new ones add (21st May 2012)
    xm = data(:,5); %ML: this migt correspond to the neck position
    ym = data(:,6);
    
    % % check whether modes are useful (some data based on old classifiers)
    %ML: mode classification from tracker
    mode = data(:,16);
    % % legend:
    % % 0: None or Unrecognized Response
    % % 1: Run
    % % 2: Turn Left
    % % 3: Turn Right
    % % 4: Stop
    % % 5: Cast Left
    % % 6: Cast Right
    % % 7: Back Up
    %
    % looptime = data(:,17);
    
    %%% fourier decomposition
    %numF=data(1,24);
    %iniF=24+1;
    %endF=24+numF*4;
    numF=7; %
    fourier=data(:,18:45);  % not 18 but 19 onwards
    
    % %display('data Loaded')
    % %pause
    
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % build positions in the absolute physical reference system
    % beware with inversion symmetries
    %
    %ML: represents the conversion factor mm/pixel
    xSabs=absX*scale2; %ML: stage position - not sure why the scaling factor is different for the stage and the animal
    ySabs=absY*scale2;
    %
    xhabs=xh*scale+xSabs;
    yhabs=yh*scale+ySabs;
    xcabs=xc*scale+xSabs;
    ycabs=yc*scale+ySabs;
    xtabs=xt*scale+xSabs;
    ytabs=yt*scale+ySabs;
    %
    xmabs=xm*scale+xSabs;
    ymabs=ym*scale+ySabs;
    
    % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % reconstructing the perimeter and skeleton
    % Fitres=400;
    % fitx=zeros(length(xh),Fitres);
    % fity=zeros(length(xh),Fitres);
    % fitxAbs=zeros(length(xh),Fitres);
    % fityAbs=zeros(length(xh),Fitres);
    % fitxRel=zeros(length(xh),Fitres);
    % fityRel=zeros(length(xh),Fitres);
    % theta=[-pi:2*pi/(Fitres-1):pi];
    %
    % for i=1:numF
    %     for j=1:Fitres
    %         fitx(:,j)=fitx(:,j)+fourier(:,4*(i-1)+1)*cos((i-1)*theta(j)) + fourier(:,4*(i-1)+2)*sin((i-1)*theta(j));
    %         fity(:,j)=fity(:,j)+fourier(:,4*(i-1)+3)*cos((i-1)*theta(j)) + fourier(:,4*(i-1)+4)*sin((i-1)*theta(j));
    %     end
    % end
    %
    % for kkk=1:Ttime
    % for j=1:Fitres
    % %fitxAbs(k,j)=(fitx(k,j)+intMoveX(k))*scale;
    % %fityAbs(k,j)=(fity(k,j)+intMoveY(k))*scale;
    % fitxAbs(kkk,j)=fitx(kkk,j)*scale+xSabs(kkk);
    % fityAbs(kkk,j)=fity(kkk,j)*scale+ySabs(kkk);
    % fitxRel(kkk,j)=fitx(kkk,j)*scale;
    % fityRel(kkk,j)=fity(kkk,j)*scale;
    % end
    % end
    %
    % add ordered skeleton finding (perimeter walking from curv points head/tail)
    %
    % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %
    % close all
    %  figure,
    %  %subplot(2,1,1)
    %   hold on
    % %  kk=goodFrames;
    %   kk=1:fps:length(xhabs);
    %  %intt=1;
    %   %kk=goodFrames(1):intt:goodFrames(end);
    %   %kk=1:fps:Ttime;
    %   xlabel('mm')
    %   ylabel('mm')
    %  axis equal
    % %kk=aaa
    % plot(fitxAbs(kk,:),fityAbs(kk,:),'-k')
    % plot(xhabs(kk),yhabs(kk),'.g')
    % plot(sourceXY(jk,1),sourceXY(jk,2),'*b')
    % radi1=3; %mm
    % thet=0:0.1:2*pi;
    % xRing1=sourceXY(jk,1)+radi1*cos(thet);
    % yRing1=sourceXY(jk,2)+radi1*sin(thet);
    % plot(xRing1,yRing1,'-b')
    % radi1=6.25; %mm
    % thet=0:0.1:2*pi;
    % xRing1=sourceXY(jk,1)+radi1*cos(thet);
    % yRing1=sourceXY(jk,2)+radi1*sin(thet);
    % plot(xRing1,yRing1,'-b')
    % axis equal
    %
    % display('check stuff')
    % pause
    
    
    % -------------------------------------------------------------------------
    % ----- STIMULUS ----------------------------------------------------------
    % -------------------------------------------------------------------------
    % if odor gradient, instead of light stimulation:
    % Gaussian approximation to the gradient
    % % C0=15; %uM
    % % lambda=27; %mm
    %  r2=(xhabs-sourceXY(jk,1)).*(xhabs-sourceXY(jk,1))+(yhabs-sourceXY(jk,2)).*(yhabs-sourceXY(jk,2));
    %  Cxy=C0*exp(-r2/(2*lambda^2));
    %  led=Cxy;
    
    % local bearing to the stimulus steepest direction
    % [gx,gy]=gradient(dataTnew); %ML: dataTnew undefined - corresponds to
    % odor gradient. This variable is defined in reconstructJF
    % angles=atan2(gy,gx);
    % anglesM(i)=angles(yGridM(i),xGridM(i)); %ML: angles is a function that is
    % not defined
    % Cruns{run}.expAngle=anglesM;
    % diff=(Cruns{run}.expAngle-kinData{run}.bodyTheta);
    % bearing=atan2(sin(diff),cos(diff));
    % NewKin{run}.bearing=bearing;
    % % check if it makes sense!!
    % deltaXsp=xhabs-sourceXY(jk,1); %ML: xhabs represents the absolute position of the head
    % deltaYsp=yhabs-sourceXY(jk,2);
    % gaussangle=atan2(deltaYsp,deltaXsp);
    % bearing=gaussangle-bodyangle; %ML: computes the bearing with respect to the
    % source. Strangely, the bearing is computed based on the head position
    
    
    % -------------------------------------------------------------------------
    % BUILDING SPEEDS (3 approaches)
    % 1. POLYFIT
    % 2. DONWSAMPLE
    % 3. WEIGHT IN THE PAST: OK (as designed and decided together with Gus)
    %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % 1.
    % IN CASE I WANT TO DO A SMOOTHENING (POLY FIT)
    % ... nothing yet. Instead wiegthed average on the past
    %
    %         %the x-y positions for cm, head, tail and midpoint. Smoothed with a
    %         %polynomial filter.
    %         nl=fs;
    %         nr=fs;
    %         pOrder=3;
    %         %
    %         xFilt=zeros(4,maxFrame);
    %         yFilt=zeros(4,maxFrame);
    %         thetaFilt=zeros(1,maxFrame);
    %         % var=4 cause I do head, tail, cm and mid
    %         for var=1:4
    %             dataIdx=var*2-1;
    %             for frame=nl+1:maxFrame-(nr+1)
    %                 window=frame-nl:frame+nr;
    %                 %the good window frames
    %                 winIdx=setdiff(window,badFrames);
    %                 if (length(find(winIdx>frame+1))>3 && length(find(winIdx<frame))>3)
    %                     px=polyfit(1:length(winIdx),squeeze(data_array(winIdx,dataIdx))',pOrder);
    %                     xFilt(var,frame) = polyval(px,nl+1);
    %                     py=polyfit(1:length(winIdx),squeeze(data_array(winIdx,dataIdx+1))',pOrder);
    %                     yFilt(var,frame)=polyval(py,nl+1);
    %                     if var==3
    %                       %use the filter to construct the centroid velocity direction
    %                        xdot=polyval(polyder(px),nl+1);
    %                        ydot=polyval(polyder(py),nl+1);
    %                        thetaFilt(frame)=atan2(ydot,xdot);
    %                     end
    %                 end
    %             end
    %         end
    %         kinData{larvaIdx}.cmPos=cmScale*[xFilt(1,:)' yFilt(1,:)'];
    %         kinData{larvaIdx}.headPos=cmScale*[xFilt(2,:)',yFilt(2,:)'];
    %         kinData{larvaIdx}.tailPos=cmScale*[xFilt(3,:)',yFilt(3,:)'];
    %         kinData{larvaIdx}.midPos=cmScale*[xFilt(4,:)',yFilt(4,:)'];
    %         kinData{larvaIdx}.cmTheta=thetaFilt;
    %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % 2.
    % % % % coarse reorientation speed
    % % %         fc=30; % frame coarse
    % % %         speed=zeros(1,Ttime);
    % % %         for i=1+fc:Ttime-fc;
    % % %             %only define the derivative when there are three good frames in
    % % %             %a row
    % % %             if length(intersect(i-fc:i+fc,frames))==2*fc+1 % this should be goodFrames
    % % %                 bodyangleUW=unwrap(bodyangle);
    % % %                 %dx2=(bodyangleUW(i+1)-bodyangleUW(i-1))^2/4;
    % % %                 %speed(i)=fps*sqrt(dx2);
    % % %                 % or with sign
    % % %                 speed(i)=fps*(bodyangleUW(i+fc)-bodyangleUW(i-fc))/(2*fc);
    % % %             end
    % % %         end
    % % %         bodyangleCSpeed=speed;
    % % %
    % % %
    %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % 3.
    % HERE I CALCULATE THE SPEEDS FROM THE RAW DATA (NOT SMOOTHED)
    % AND THEN APPLY THE LINEAR FILTER BACK IN TIME TO ALL OF THEM
    %
    % linear weigth of a given duration
    Tb=1000; % time back in miliseconds
    Nb=floor(fps*Tb/1000);
    wb=(Nb*(Nb+1))/2;
    % reorientation speed
    speed=NaN(1,Ttime);
    bodyangleUW=unwrap(bodyangle); %ML: unwrap corrects for jumps larger than pi
    for i=2:Ttime-1;
        if length(intersect(i-1:i+1,frames))==3 %ML: returns value common to 2 vectors
            speed(i)=fps*(bodyangleUW(i+1)-bodyangleUW(i-1))/2; %ML: reorientation speed
        end
    end
    % bodyangleSpeed=speed;
    speedM=NaN(1,Ttime);
    for i=Nb:Ttime-1; % avoiding the first Nb frames - ML: used for the weighted average
        ki=1:Nb;
        % what is there is a NaN around there...
        vecVW=(Nb+1-ki).*speed(i+1-ki); %ML: weighted sum where the point furthest in the past contribute less
        speedM(i)=(1/wb)*sum(vecVW);
    end
    bodyangleSpeed=speedM;
    % head angle speed
    speed=NaN(1,Ttime);
    for i=2:Ttime-1;
        if length(intersect(i-1:i+1,frames))==3
            speed(i)=fps*(headangle(i+1)-headangle(i-1))/2;
        end
    end
    %
    speedM=NaN(1,Ttime);
    for i=Nb:Ttime-1; % avoiding the first Nb frames
        ki=1:Nb;
        % what is there is a NaN around there...
        vecVW=(Nb+1-ki).*speed(i+1-ki);
        speedM(i)=(1/wb)*sum(vecVW);
    end
    headangleSpeed=speedM;
    % head speed
    speed=NaN(1,Ttime);
    for i=2:Ttime-1;
        if length(intersect(i-1:i+1,frames))==3
            dx2=(xhabs(i+1)-xhabs(i-1))^2/4;
            dy2=(yhabs(i+1)-yhabs(i-1))^2/4;
            speed(i)=fps*sqrt(dx2+dy2);
        end
    end
    speedM=NaN(1,Ttime);
    for i=Nb:Ttime-1; % avoiding the first Nb frames
        ki=1:Nb;
        % what is there is a NaN around there...
        vecVW=(Nb+1-ki).*speed(i+1-ki);
        speedM(i)=(1/wb)*sum(vecVW);
    end
    headSpeed=speedM;
    % tail speed
    speed=NaN(1,Ttime);
    for i=2:Ttime-1;
        if length(intersect(i-1:i+1,frames))==3
            dx2=(xtabs(i+1)-xtabs(i-1))^2/4;
            dy2=(ytabs(i+1)-ytabs(i-1))^2/4;
            speed(i)=fps*sqrt(dx2+dy2);
        end
    end
    speedM=NaN(1,Ttime);
    for i=Nb:Ttime-1; % avoiding the first Nb frames
        ki=1:Nb;
        % what is there is a NaN around there...
        vecVW=(Nb+1-ki).*speed(i+1-ki);
        speedM(i)=(1/wb)*sum(vecVW);
    end
    tailSpeed=speedM;
    % centroid speed
    speed=NaN(1,Ttime);
    for i=2:Ttime-1;
        if length(intersect(i-1:i+1,frames))==3
            dx2=(xcabs(i+1)-xcabs(i-1))^2/4;
            dy2=(ycabs(i+1)-ycabs(i-1))^2/4;
            speed(i)=fps*sqrt(dx2+dy2);
        end
    end
    speedM=NaN(1,Ttime);
    for i=Nb:Ttime-1; % avoiding the first Nb frames
        ki=1:Nb;
        % what is there is a NaN around there...
        vecVW=(Nb+1-ki).*speed(i+1-ki);
        speedM(i)=(1/wb)*sum(vecVW);
    end
    centroidSpeed=speedM;
    % MIDPOINT speed (new)
    speed=NaN(1,Ttime);
    for i=2:Ttime-1;
        if length(intersect(i-1:i+1,frames))==3
            dx2=(xmabs(i+1)-xmabs(i-1))^2/4;
            dy2=(ymabs(i+1)-ymabs(i-1))^2/4;
            speed(i)=fps*sqrt(dx2+dy2);
        end
    end
    speedM=NaN(1,Ttime);
    for i=Nb:Ttime-1; % avoiding the first Nb frames
        ki=1:Nb;
        % what is there is a NaN around there...
        vecVW=(Nb+1-ki).*speed(i+1-ki);
        speedM(i)=(1/wb)*sum(vecVW);
    end
    midSpeed=speedM;
    % ---------
    % led speed
    speed=NaN(1,Ttime);
    for i=2:Ttime-1;
        if length(intersect(i-1:i+1,frames))==3
            speed(i)=fps*(led(i+1)-led(i-1))/2;
        end
    end
    ledSpeedRaw=speed;
    %
    speedM=NaN(1,Ttime);
    for i=Nb:Ttime-1; % avoiding the first Nb frames
        ki=1:Nb;
        % what is there is a NaN around there...
        vecVW=(Nb+1-ki).*speed(i+1-ki);
        speedM(i)=(1/wb)*sum(vecVW);
    end
    ledSpeed=speedM;
    
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % % A2. Vectorial information on speed (to be completed)
    %
    % % raw HEAD VECTOR speed,in mm/s
    %         speedx=zeros(1,Ttime);
    %         speedy=zeros(1,Ttime);
    %         for i=2:Ttime-1;
    %             %only define the derivative when there are three good frames in
    %             %a row
    %             if length(intersect(i-1:i+1,frames))==3
    %                 speedx(i)=fps*(xhabs(i+1)-xhabs(i-1))/2;
    %                 speedy(i)=fps*(yhabs(i+1)-yhabs(i-1))/2;
    %             end
    %         end
    %         headSpeedVec=[speedx',speedy'];
    %         % make equal to zero
    %         %ahV=find(headSpeedVec()>20);
    %         %
    %
    % % raw DIRECTION VECTOR
    %         aa=unwrap(bodyangle);
    %         bodyDirVec=[cos(aa), sin(aa)];
    %        % bodyDirVec=[sin(aa), cos(aa)];
    %
    %
    % % speed perpendicular
    % dotvn=bodyDirVec(:,1).*headSpeedVec(:,1)+bodyDirVec(:,2).*headSpeedVec(:,2);
    % for kk=1:length(dotvn)
    %         vII(kk)=abs(dotvn(kk));
    %         % and the orthogonal one
    %         vIU(kk)=sqrt(headSpeed(kk)^2-vII(kk)^2);
    % end
    % % notice that I kill the sign (something funny with X to -X.. to be solved)
    
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %
    % WRITE ALL STUFF IN ORDER TO SAVE DATA
    %     cd(rootdir)
    % beware rows and columns
    
    kinData{jk}.fps=fps;
    kinData{jk}.scales=[scale, scale2];
    
    kinData{jk}.skeL=skelL;
    
    kinData{jk}.led=led;
    kinData{jk}.ledSpeed=ledSpeed;
    kinData{jk}.ledSpeedRaw=ledSpeedRaw;
    
    % for some data in the past this was an error, so have to repeat it
    % kinData{jk}.headposition=[xhabs yhabs];
    % kinData{jk}.tailposition=[xhabs yhabs];
    % kinData{jk}.centroidposition=[xhabs yhabs];
    
    kinData{jk}.headposition=[xhabs yhabs];
    kinData{jk}.tailposition=[xtabs ytabs];
    kinData{jk}.centroidposition=[xcabs ycabs];
    %
    kinData{jk}.midposition=[xmabs ymabs];
    
    kinData{jk}.headSpeed=headSpeed;
    kinData{jk}.tailSpeed=tailSpeed;
    kinData{jk}.centroidSpeed=centroidSpeed;
    kinData{jk}.midSpeed=midSpeed;
    
    kinData{jk}.bodyangle=bodyangle;
    kinData{jk}.headangle=headangle;
    
    kinData{jk}.bodyangleSpeed=bodyangleSpeed;
    kinData{jk}.headangleSpeed=headangleSpeed;
    
    % behavioral mode (beware updated)
    kinData{jk}.mode=mode;
    
    % fourier coeffs (4*7)
    kinData{jk}.fourier=fourier;
    
    % absolute position of the stage in its units (cf. boundary)
    kinData{jk}.absX=absX;
    kinData{jk}.absY=absY;
    
    
    %%ML: routine to classify behavioral based on NCom classifiers
    

end
kinData = kinData{1};
[kinData] = jump_stitcher_csv(kinData);

[pathstr,name,ext] = fileparts(inputfile);
newStr = regexprep(name, '_data', '');
save_file = fullfile(outputfolder, strcat(newStr,'_kinVariables.mat'));
save(save_file, 'kinData')

toc
flag = 1;
end

