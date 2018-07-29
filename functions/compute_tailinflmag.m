%compute length of tailinflvector

function [trx]=compute_tailinflmag(trx,outputfolder)

inputfilename=fullfile(outputfolder,'xtail_mm.mat');
if ~exist(inputfilename,'file')
    [trx]=compute_spinerelevantpositions(trx,outputfolder);
end
load(fullfile(outputfolder,'xtail_mm.mat'), 'data')
xtail_mm=data;
load(fullfile(outputfolder,'ytail_mm.mat'), 'data')
ytail_mm=data;

inputfilenamexin=fullfile(outputfolder,'xinflection_mm.mat');
if ~exist(inputfilename,'file')
    [trx]=compute_xinflection_mm(trx,outputfolder);
end
load(inputfilenamexin, 'data')
xinflection_mm=data;

inputfilenameyin=fullfile(outputfolder,'yinflection_mm.mat');
if ~exist(inputfilename,'file')
    [trx]=compute_yinflection_mm(trx,outputfolder);
end
load(inputfilenameyin, 'data')
yinflection_mm=data;

numlarvae=size(trx,2);
tailinflmag=cell(1,numlarvae);

for i=1:numlarvae
    tailinflmag{1,i}=bsxfun(@hypot,xinflection_mm{1,i}-xtail_mm{1,i},yinflection_mm{1,i}-ytail_mm{1,i});
end

units=struct('num','mm','den',[]);
data=tailinflmag;
filename=fullfile(outputfolder, 'tailinflmag.mat');
save(filename, 'data', 'units')