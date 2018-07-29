%compute velmag_head
function [trx]=compute_velmaghead(trx,outputfolder)
inputfilename=fullfile(outputfolder,'dxhead_mm.mat');
if ~exist(inputfilename,'file')
    [trx]=compute_dspinerelevantpositions(trx,outputfolder);
end
load(fullfile(outputfolder,'dxhead_mm.mat'), 'data')
dxhead_mm=data;
load(fullfile(outputfolder,'dyhead_mm.mat'), 'data')
dyhead_mm=data;
numlarvae=size(trx,2);
velmaghead=cell(1,numlarvae);
for i=1:numlarvae
    velmaghead{1,i}=bsxfun(@hypot,dxhead_mm{1,i},dyhead_mm{1,i});
end

units=struct('num','mm','den','s');
data=velmaghead;
filename=fullfile(outputfolder, 'velmaghead.mat');
save(filename, 'data', 'units') 
