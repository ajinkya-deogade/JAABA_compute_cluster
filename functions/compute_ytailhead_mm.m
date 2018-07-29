%compute ytailhead_mm
function [trx]=compute_ytailhead_mm(trx,outputfolder)

inputfilename=fullfile(outputfolder,'ytail_mm.mat');
if ~exist(inputfilename,'file')
    [trx]=compute_spinerelevantpositions(trx,outputfolder);
end
load(fullfile(outputfolder,'yhead_mm.mat'), 'data')
yhead_mm=data;
load(fullfile(outputfolder,'ytail_mm.mat'), 'data')
ytail_mm=data;

numlarvae=size(trx,2);
ytailhead_mm=cell(1,numlarvae);

for i=1:numlarvae
    ytailhead_mm{1,i}=yhead_mm{1,i}-ytail_mm{1,i};
end
units=struct('num','mm','den',[]);
data=ytailhead_mm;
filename=fullfile(outputfolder, 'ytailhead_mm.mat');
save(filename, 'data', 'units')