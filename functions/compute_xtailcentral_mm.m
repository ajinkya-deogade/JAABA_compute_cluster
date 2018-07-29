%compute xtailcentral_mm
function [trx]=compute_xtailcentral_mm(trx,outputfolder)

inputfilename=fullfile(outputfolder,'xcentral_mm.mat');
if ~exist(inputfilename,'file')
    [trx]=compute_spinerelevantpositions(trx,outputfolder);
end
load(fullfile(outputfolder,'xcentral_mm.mat'), 'data')
xcentral_mm=data;
load(fullfile(outputfolder,'xtail_mm.mat'), 'data')
xtail_mm=data;

numlarvae=size(trx,2);
xtailcentral_mm=cell(1,numlarvae);

for i=1:numlarvae
    xtailcentral_mm{1,i}=xcentral_mm{1,i}-xtail_mm{1,i};
end
units=struct('num','mm','den',[]);
data=xtailcentral_mm;
filename=fullfile(outputfolder, 'xtailcentral_mm.mat');
save(filename, 'data', 'units')
