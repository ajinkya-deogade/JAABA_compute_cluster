%compute orientation of tailcentralvector

function [trx]=compute_tailcentralang(trx,outputfolder)

inputfilename=[outputfolder,'xcentral_mm.mat'];
if ~exist(inputfilename,'file')
    [trx]=compute_spinerelevantpositions(trx,outputfolder);
end
load(fullfile(outputfolder,'xcentral_mm.mat'), 'data')
xcentral_mm=data;
load(fullfile(outputfolder,'xtail_mm.mat'), 'data')
xtail_mm=data;
load(fullfile(outputfolder,'ycentral_mm.mat'), 'data')
ycentral_mm=data;
load(fullfile(outputfolder,'ytail_mm.mat'), 'data')
ytail_mm=data;

tailcentralang=cell(size(xcentral_mm));

for i=1:size(xcentral_mm,2)
    tailcentralang{1,i}=bsxfun(@atan2,ycentral_mm{1,i}-ytail_mm{1,i},xcentral_mm{1,i}-xtail_mm{1,i});
end
units=struct('num','mm','den',[]);
data=tailcentralang;
filename=fullfile(outputfolder, 'tailcentralang.mat');
save(filename, 'data', 'units')