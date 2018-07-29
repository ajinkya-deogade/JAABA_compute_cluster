%compute orientation of centralheadsm vector

function [trx]=compute_centralheadsmang(trx,outputfolder)

inputfilenamesm=[outputfolder,'xheadsm_mm.mat'];
if ~exist(inputfilenamesm,'file')
    [trx]=compute_spinepositionssm(trx,outputfolder);
end
load([outputfolder,'xheadsm_mm.mat'], 'data')
xheadsm_mm=data;
load([outputfolder,'yheadsm_mm.mat'], 'data')
yheadsm_mm=data;

inputfilename=[outputfolder,'xcentral_mm.mat'];
if ~exist(inputfilename,'file')
    [trx]=compute_spinerelevantpositions(trx,outputfolder);
end
load([outputfolder,'xcentral_mm.mat'], 'data')
xcentral_mm=data;
load([outputfolder,'ycentral_mm.mat'], 'data')
ycentral_mm=data;



centralheadsmang=cell(size(xheadsm_mm));

for i=1:size(xheadsm_mm,2)
    centralheadsmang{1,i}=bsxfun(@atan2,yheadsm_mm{1,i}-ycentral_mm{1,i},xheadsm_mm{1,i}-xcentral_mm{1,i});
end

units=struct('num','rad','den',[]);
data=centralheadsmang;
filename=[outputfolder, 'centralheadsmang.mat'];
save(filename, 'data', 'units')