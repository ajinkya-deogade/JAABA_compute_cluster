%compute dang between vector tailinfl and vector inflhead

function [trx]=compute_dangihvsangti(trx,outputfolder)
inputfilename=fullfile(outputfolder,'inflectionpointdistance.mat');
if ~exist(inputfilename,'file')
    [trx]=compute_inflectionpointdistance(trx,outputfolder);
end
load(inputfilename,'data')
inflectionpointdistance=data;

inputfilename=fullfile(outputfolder,'xhead_mm.mat');
if ~exist(inputfilename,'file')
    [trx]=compute_spinerelevantpositions(trx,outputfolder);
end
load(fullfile(outputfolder,'xhead_mm.mat'), 'data')
xhead_mm=data;
load(fullfile(outputfolder,'yhead_mm.mat'), 'data')
yhead_mm=data;

inputfilename=fullfile(outputfolder,'xtail_mm.mat');
if ~exist(inputfilename,'file')
    [trx]=compute_spinerelevantpositions(trx,outputfolder);
end
load(fullfile(outputfolder,'xtail_mm.mat'), 'data')
xtail_mm=data;
load(fullfile(outputfolder,'ytail_mm.mat'), 'data')
ytail_mm=data;



numlarvae=size(trx,2);
dangihvsangti=cell(1,numlarvae);

for i=1:numlarvae
     dangihvsangti{1,i}=zeros(1,size(trx(i).xspine_mm,2));
    for j=1:size(trx(i).xspine_mm,2)-1     
    tailinflangzero=atan2(trx(i).yspine_mm(inflectionpointdistance{1,i}(j),j)-ytail_mm{1,i}(j),trx(i).xspine_mm(inflectionpointdistance{1,i}(j),j)-xtail_mm{1,i}(j));
    inflheadangzero=atan2(yhead_mm{1,i}(j)-trx(i).yspine_mm(inflectionpointdistance{1,i}(j),j),xhead_mm{1,i}(j)-trx(i).xspine_mm(inflectionpointdistance{1,i}(j),j));
    absangzero=real(acos(cos(tailinflangzero).*cos(inflheadangzero)+sin(tailinflangzero).*sin(inflheadangzero)));
    temp=tailinflangzero-pi/2;
    cosperpzero=sign(cos(temp).*cos(inflheadangzero)+sin(temp).*sin(inflheadangzero));
    angzero=bsxfun(@times,absangzero,cosperpzero);
    
    tailinflanguno=atan2(trx(i).yspine_mm(inflectionpointdistance{1,i}(j),j+1)-ytail_mm{1,i}(j+1),trx(i).xspine_mm(inflectionpointdistance{1,i}(j),j+1)-xtail_mm{1,i}(j+1));
    inflheadanguno=atan2(yhead_mm{1,i}(j+1)-trx(i).yspine_mm(inflectionpointdistance{1,i}(j),j+1),xhead_mm{1,i}(j+1)-trx(i).xspine_mm(inflectionpointdistance{1,i}(j),j+1));
    absanguno=real(acos(cos(tailinflanguno).*cos(inflheadanguno)+sin(tailinflanguno).*sin(inflheadanguno)));
    temp=tailinflanguno-pi/2;
    cosperpuno=sign(cos(temp).*cos(inflheadanguno)+sin(temp).*sin(inflheadanguno));
    anguno=bsxfun(@times,absanguno,cosperpuno);
    
    dangihvsangti{1,i}(j)=(mod1(anguno-angzero,pi)-pi)./trx(i).dt(j);
    end
end


units=struct('num','rad','den','s');
data=dangihvsangti;
filename=fullfile(outputfolder, 'dangihvsangti.mat');
save(filename, 'data', 'units')