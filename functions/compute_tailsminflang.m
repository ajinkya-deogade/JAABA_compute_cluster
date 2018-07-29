%compute ang of tailsminflvector

function [trx]=compute_tailsminflang(trx,outputfolder)

inputfilename=[outputfolder,'xtailsm_mm.mat'];
if ~exist(inputfilename,'file')
    [trx]=compute_spinepositionssm(trx,outputfolder);
end
load([outputfolder,'xtailsm_mm.mat'], 'data')
xtailsm_mm=data;
load([outputfolder,'ytailsm_mm.mat'], 'data')
ytailsm_mm=data;

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
tailsminflang=cell(1,numlarvae);

for i=1:numlarvae
    tailsminflang{1,i}=bsxfun(@atan2,yinflection_mm{1,i}-ytailsm_mm{1,i},xinflection_mm{1,i}-xtailsm_mm{1,i});
end

units=struct('num','rad','den',[]);
data=tailsminflang;
filename=[outputfolder, 'tailsminflang.mat'];
save(filename, 'data', 'units')