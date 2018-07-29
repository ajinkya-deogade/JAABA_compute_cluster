%compute orientation of tailsmoothcentralvector

function [trx]=compute_tailsmcentralang(trx,outputfolder)

inputfilenamesm=[outputfolder,'xtailsm_mm.mat'];
if ~exist(inputfilenamesm,'file')
    [trx]=compute_spinepositionssm(trx,outputfolder);
end
load([outputfolder,'xtailsm_mm.mat'], 'data')
xtailsm_mm=data;
load([outputfolder,'ytailsm_mm.mat'], 'data')
ytailsm_mm=data;

inputfilename=[outputfolder,'xcentral_mm.mat'];
if ~exist(inputfilename,'file')
    [trx]=compute_spinerelevantpositions(trx,outputfolder);
end
load([outputfolder,'xcentral_mm.mat'], 'data')
xcentral_mm=data;
load([outputfolder,'ycentral_mm.mat'], 'data')
ycentral_mm=data;

tailsmcentralang=cell(size(xcentral_mm));

for i=1:size(xcentral_mm,2)
    tailsmcentralang{1,i}=bsxfun(@atan2,ycentral_mm{1,i}-ytailsm_mm{1,i},xcentral_mm{1,i}-xtailsm_mm{1,i});
end
units=struct('num','mm','den',[]);
data=tailsmcentralang;
filename=[outputfolder, 'tailsmcentralang.mat'];
save(filename, 'data', 'units')