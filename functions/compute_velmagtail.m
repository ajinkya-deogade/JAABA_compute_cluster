%compute velmag_tail
function [trx]=compute_velmagtail(trx,outputfolder)
inputfilename=fullfile(outputfolder,'dxtail_mm.mat');
if ~exist(inputfilename,'file')
    [trx]=compute_dspinerelevantpositions(trx,outputfolder);
end
load(fullfile(outputfolder,'dxtail_mm.mat'), 'data')
dxtail_mm=data;
load(fullfile(outputfolder,'dytail_mm.mat'), 'data')
dytail_mm=data;
numlarvae=size(trx,2);
velmagtail=cell(1,numlarvae);
for i=1:numlarvae
    velmagtail{1,i}=bsxfun(@hypot,dxtail_mm{1,i},dytail_mm{1,i});
end

units=struct('num','mm','den','s');
data=velmagtail;
filename=fullfile(outputfolder, 'velmagtail.mat');
save(filename, 'data', 'units') 
