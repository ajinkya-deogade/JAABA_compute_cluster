%compute velmag_tailhead
function [trx]=compute_velmagtailhead(trx,outputfolder)
inputfilename=fullfile(outputfolder,'dxtailhead_mm.mat');
if ~exist(inputfilename,'file')
    [trx]=compute_dxtailhead_mm(trx,outputfolder);
end
load(fullfile(outputfolder,'dxtailhead_mm.mat'), 'data')
dxtailhead_mm=data;
inputfilename=fullfile(outputfolder,'dytailhead_mm.mat');
if ~exist(inputfilename,'file')
    [trx]=compute_dytailhead_mm(trx,outputfolder);
end
load(fullfile(outputfolder,'dytailhead_mm.mat'), 'data')
dytailhead_mm=data;
numlarvae=size(trx,2);
velmagtailhead=cell(1,numlarvae);
for i=1:numlarvae
    velmagtailhead{1,i}=bsxfun(@hypot,dxtailhead_mm{1,i},dytailhead_mm{1,i});
end

units=struct('num','mm','den','s');
data=velmagtailhead;
filename=fullfile(outputfolder, 'velmagtailhead.mat');
save(filename, 'data', 'units') 