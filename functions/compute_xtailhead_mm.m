%compute xtailhead_mm
function [trx]=compute_xtailhead_mm(trx,outputfolder)

inputfilename=fullfile(outputfolder,'xtail_mm.mat');
if ~exist(inputfilename,'file')
    [trx]=compute_spinerelevantpositions(trx,outputfolder);
end
load(fullfile(outputfolder,'xhead_mm.mat'), 'data')
xhead_mm=data;
load(fullfile(outputfolder,'xtail_mm.mat'), 'data')
xtail_mm=data;

numlarvae=size(trx,2);
xtailhead_mm=cell(1,numlarvae);

for i=1:numlarvae
    xtailhead_mm{1,i}=xhead_mm{1,i}-xtail_mm{1,i};
end
units=struct('num','mm','den',[]);
data=xtailhead_mm;
filename=fullfile(outputfolder, 'xtailhead_mm.mat');
save(filename, 'data', 'units')