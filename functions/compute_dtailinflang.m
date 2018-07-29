%compute dtailinflang

function [trx]=compute_dtailinflang(trx,outputfolder)
inputfilename=fullfile(outputfolder,'inflectionpointdistance.mat');
if ~exist(inputfilename,'file')
    [trx]=compute_inflectionpointdistance(trx,outputfolder);
end
load(inputfilename,'data')
inflectionpointdistance=data;
inputfilename=fullfile(outputfolder,'xtail_mm.mat');
if ~exist(inputfilename,'file')
    [trx]=compute_spinerelevantpositions(trx,outputfolder);
end
load(fullfile(outputfolder,'xtail_mm.mat'), 'data')
xtail_mm=data;
load(fullfile(outputfolder,'ytail_mm.mat'), 'data')
ytail_mm=data;



numlarvae=size(trx,2);
dtailinflang=cell(1,numlarvae);

for i=1:numlarvae
     dtailinflang{1,i}=zeros(1,size(trx(i).xspine_mm,2));
    for j=1:size(trx(i).xspine_mm,2)-1     
    dtailinflang{1,i}(j)=(bsxfun(@atan2,trx(i).yspine_mm(inflectionpointdistance{1,i}(j),j+1)-ytail_mm{1,i}(j+1),trx(i).xspine_mm(inflectionpointdistance{1,i}(j),j+1)-xtail_mm{1,i}(j+1))-...
        bsxfun(@atan2,trx(i).yspine_mm(inflectionpointdistance{1,i}(j),j)-ytail_mm{1,i}(j),trx(i).xspine_mm(inflectionpointdistance{1,i}(j),j)-xtail_mm{1,i}(j)))./trx(i).dt(j);
    
    end
end

units=struct('num','rad','den','s');
data=dtailinflang;
filename=fullfile(outputfolder, 'dtailinflang.mat');
save(filename, 'data', 'units')