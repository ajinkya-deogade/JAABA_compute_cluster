%compute orientation of tailsmoothheadsmoothvector

function [trx]=compute_tailsmheadsmang(trx,outputfolder)

inputfilenamesm=[outputfolder,'xtailsm_mm.mat'];
if ~exist(inputfilenamesm,'file')
    [trx]=compute_spinepositionssm(trx,outputfolder);
end
load([outputfolder,'xheadsm_mm.mat'], 'data')
xheadsm_mm=data;
load([outputfolder,'yheadsm_mm.mat'], 'data')
yheadsm_mm=data;
load([outputfolder,'xtailsm_mm.mat'], 'data')
xtailsm_mm=data;
load([outputfolder,'ytailsm_mm.mat'], 'data')
ytailsm_mm=data;



tailsmheadsmang=cell(size(xheadsm_mm));

for i=1:size(xheadsm_mm,2)
    tailsmheadsmang{1,i}=bsxfun(@atan2,yheadsm_mm{1,i}-ytailsm_mm{1,i},xheadsm_mm{1,i}-xtailsm_mm{1,i});
end
units=struct('num','mm','den',[]);
data=tailsmheadsmang;
filename=[outputfolder, 'tailsmheadsmang.mat'];
save(filename, 'data', 'units')