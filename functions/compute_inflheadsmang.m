%compute ang of inflheadsmvector

function [trx]=compute_inflheadsmang(trx,outputfolder)

inputfilename=[outputfolder,'xheadsm_mm.mat'];
if ~exist(inputfilename,'file')
    [trx]=compute_spinepositionssm(trx,outputfolder);
end
load([outputfolder,'xheadsm_mm.mat'], 'data')
xheadsm_mm=data;
load([outputfolder,'yheadsm_mm.mat'], 'data')
yheadsm_mm=data;

inputfilenamexin=[outputfolder,'xinflection_mm.mat'];
if ~exist(inputfilename,'file')
    [trx]=compute_xinflection_mm(trx,outputfolder);
end
load(inputfilenamexin, 'data')
xinflection_mm=data;

inputfilenameyin=[outputfolder,'yinflection_mm.mat'];
if ~exist(inputfilename,'file')
    [trx]=compute_yinflection_mm(trx,outputfolder);
end
load(inputfilenameyin, 'data')
yinflection_mm=data;

numlarvae=size(trx,2);
inflheadsmang=cell(1,numlarvae);

for i=1:numlarvae
    inflheadsmang{1,i}=bsxfun(@atan2,yheadsm_mm{1,i}-yinflection_mm{1,i},xheadsm_mm{1,i}-xinflection_mm{1,i});
end

units=struct('num','rad','den',[]);
data=inflheadsmang;
filename=[outputfolder, 'inflheadsmang.mat'];
save(filename, 'data', 'units')