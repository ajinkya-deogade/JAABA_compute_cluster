%compute dinflheadang

function [trx]=compute_dinflheadang(trx,outputfolder)
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
dinflheadang=cell(1,numlarvae);

for i=1:numlarvae
     dinflheadang{1,i}=zeros(1,size(trx(i).xspine_mm,2));
    for j=1:size(trx(i).xspine_mm,2)-1     
    dinflheadang{1,i}(j)=(bsxfun(@atan2,yhead_mm{1,i}(j+1)-trx(i).yspine_mm(inflectionpointdistance{1,i}(j),j+1),xhead_mm{1,i}(j+1)-trx(i).xspine_mm(inflectionpointdistance{1,i}(j),j+1))-...
        bsxfun(@atan2,yhead_mm{1,i}(j)-trx(i).yspine_mm(inflectionpointdistance{1,i}(j),j),xhead_mm{1,i}(j)-trx(i).xspine_mm(inflectionpointdistance{1,i}(j),j)))./trx(i).dt(j);
    
    end
end

units=struct('num','rad','den','s');
data=dinflheadang;
filename=fullfile(outputfolder, 'dinflheadang.mat');
save(filename, 'data', 'units')