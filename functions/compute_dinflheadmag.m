%compute dinflheadmag

function [trx]=compute_dinflheadmag(trx,outputfolder)
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



numlarvae=size(trx,2);
dinflheadmag=cell(1,numlarvae);

for i=1:numlarvae
     dinflheadmag{1,i}=zeros(1,size(trx(i).xspine_mm,2));
    for j=1:size(trx(i).xspine_mm,2)-1     
    dinflheadmag{1,i}(j)=(bsxfun(@hypot,xhead_mm{1,i}(j+1)-trx(i).xspine_mm(inflectionpointdistance{1,i}(j),j+1),yhead_mm{1,i}(j+1)-trx(i).yspine_mm(inflectionpointdistance{1,i}(j),j+1))-...
        bsxfun(@hypot,xhead_mm{1,i}(j)-trx(i).xspine_mm(inflectionpointdistance{1,i}(j),j),yhead_mm{1,i}(j)-trx(i).yspine_mm(inflectionpointdistance{1,i}(j),j)))./trx(i).dt(j);
    
    end
end

units=struct('num','mm','den','s');
data=dinflheadmag;
filename=fullfile(outputfolder, 'dinflheadmag.mat');
save(filename, 'data', 'units')