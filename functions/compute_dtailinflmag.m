%compute dtailinflmag

function [trx]=compute_dtailinflmag(trx,outputfolder)
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
dtailinflmag=cell(1,numlarvae);

for i=1:numlarvae
     dtailinflmag{1,i}=zeros(1,size(trx(i).xspine_mm,2));
    for j=1:size(trx(i).xspine_mm,2)-1     
    dtailinflmag{1,i}(j)=(bsxfun(@hypot,trx(i).xspine_mm(inflectionpointdistance{1,i}(j),j+1)-xtail_mm{1,i}(j+1),trx(i).yspine_mm(inflectionpointdistance{1,i}(j),j+1)-ytail_mm{1,i}(j+1))-...
        bsxfun(@hypot,trx(i).xspine_mm(inflectionpointdistance{1,i}(j),j)-xtail_mm{1,i}(j),trx(i).yspine_mm(inflectionpointdistance{1,i}(j),j)-ytail_mm{1,i}(j)))./trx(i).dt(j);
    
    end
end

units=struct('num','mm','den','s');
data=dtailinflmag;
filename=fullfile(outputfolder, 'dtailinflmag.mat');
save(filename, 'data', 'units')