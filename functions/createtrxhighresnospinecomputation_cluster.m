%Detects the spine and other features  from contours in one single larva experiments

function [outputfoldernew] = createtrxhighresnospinecomputation_cluster(inputfile, kinData, outputfolder)
Data = kinData;
trx=([]);

%number of frames in the trajectory
numframes=length(Data.absX);
a=zeros(1,numframes);
b=zeros(1,numframes);
theta=zeros(1,numframes);
xcontour=cell(1,numframes);%squeeze(contour(:,:,1));
ycontour=cell(1,numframes);%squeeze(contour(:,:,2));
xspine=Data.spineX;
yspine=Data.spineY;
curvtips=zeros(2,numframes);
xcontour=Data.contourX;
ycontour=Data.contourY;
scales = Data.scales;
absX = Data.absX;
absY = Data.absY;
parfor j=1:numframes
    [curvtips(:,j)] = computecurvtips(xcontour(j,:), ycontour(j,:), xspine(j,:),yspine(j,:),scales,absX(j),absY(j));
%     [curvtips(:,j)] = computecurvtips(Data.contourX(j,:),Data.contourY(j,:),Data.spineX(j,:),Data.spineY(j,:),Data.scales,Data.absX(j),Data.absY(j));
    [a(j),b(j),theta(j)] = computeinternalvariableshighres(xcontour(j,:), ycontour(j,:));
end
trx.x_mm=Data.centroidposition(:,1)';%*Data.scales(1)+Data.scales(2)*newabsX;
trx.x=trx.x_mm;
trx.y_mm=Data.centroidposition(:,2)';%*Data.scales(1)+Data.scales(2)*newabsY;
trx.y=trx.y_mm;
trx.xmidposition_mm=Data.midposition(:,1)';
trx.ymidposition_mm=Data.midposition(:,2)';
trx.area_mm=polyarea(Data.contourX,Data.contourY,2)';%'*Data.scales(1)^2';
trx.area=trx.area_mm;
trx.xcontour_mm=xcontour;%mat2cell(xcontour'*Data.scales(1)+repmat(Data.scales(2)*newabsX,200,1),200,ones(1,numframes));
trx.ycontour_mm=ycontour;%mat2cell(ycontour'*Data.scales(1)+repmat(Data.scales(2)*newabsY,200,1),200,ones(1,numframes));
trx.xcontour=trx.xcontour_mm;
trx.ycontour=trx.ycontour_mm;
trx.xspine_mm=Data.spineX';%xspinestrx*Data.scales(1)+repmat(Data.scales(2)*newabsX,11,1);
trx.yspine_mm=Data.spineY';%yspinestrx*Data.scales(1)+repmat(Data.scales(2)*newabsY,11,1);
trx.xspine=trx.xspine_mm;
trx.yspine=trx.yspine_mm;
trx.fps=Data.fps;
trx.firstframe=1;
trx.nframes=numframes;
trx.endframe=numframes;
trx.a_mm=(a./2);%*Data.scales(1);
trx.a=trx.a_mm;
trx.b_mm=(b./2);%*Data.scales(1);
trx.b=trx.b_mm;
trx.theta=theta;
trx.pxpermm=Data.scales;
trx.arena=struct('arena_x_mm', 400,'arena_y_mm', 400);
trx.dt=repmat(1/Data.fps,[1,trx.nframes-1]);
trx.curvtips=curvtips;
[~, name, ~] = fileparts(inputfile);
newStr = regexprep(name, '_data', '');
outputfoldernew = fullfile(outputfolder, newStr);
mkdir(outputfoldernew)
filename = fullfile(outputfoldernew, 'trx.mat');
save(filename, 'trx')
