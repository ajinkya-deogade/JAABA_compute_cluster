%compute velang_head
function [trx]=compute_velanghead(trx,outputfolder)
inputfilename=fullfile(outputfolder,'dxhead_mm.mat');
if ~exist(inputfilename,'file')
    [trx]=compute_dspinerelevantpositions(trx,outputfolder);
end
load(fullfile(outputfolder,'dxhead_mm.mat'), 'data')
dxhead_mm=data;
load(fullfile(outputfolder,'dyhead_mm.mat'), 'data')
dyhead_mm=data;
numlarvae=size(trx,2);
velanghead=cell(1,numlarvae);
for i=1:numlarvae
    velanghead{1,i}=bsxfun(@atan2,dyhead_mm{1,i},dxhead_mm{1,i});
end

units=struct('num','rad','den','s');
data=velanghead;
filename=fullfile(outputfolder, 'velanghead.mat');
save(filename, 'data', 'units') 
