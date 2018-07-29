%compute length of tailheadvector

function [trx]=compute_tailheadmag(trx,outputfolder)

inputfilename=fullfile(outputfolder,'xhead_mm.mat');
if ~exist(inputfilename,'file')
    [trx]=compute_spinerelevantpositions(trx,outputfolder);
end
load(fullfile(outputfolder,'xhead_mm.mat'), 'data')
xhead_mm=data;
load(fullfile(outputfolder,'xtail_mm.mat'), 'data')
xtail_mm=data;
load(fullfile(outputfolder,'yhead_mm.mat'), 'data')
yhead_mm=data;
load(fullfile(outputfolder,'ytail_mm.mat'), 'data')
ytail_mm=data;

tailheadmag=cell(size(xhead_mm));

for i=1:size(xhead_mm,2)
    tailheadmag{1,i}=bsxfun(@hypot,xhead_mm{1,i}-xtail_mm{1,i},yhead_mm{1,i}-ytail_mm{1,i});
end

units=struct('num','mm','den',[]);
data=tailheadmag;
filename=fullfile(outputfolder, 'tailheadmag.mat');
save(filename, 'data', 'units')