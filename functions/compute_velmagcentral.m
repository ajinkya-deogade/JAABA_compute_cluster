%compute velmag_central
function [trx]=compute_velmagcentral(trx,outputfolder)
inputfilename=fullfile(outputfolder,'dxcentral_mm.mat');
if ~exist(inputfilename,'file')
    [trx]=compute_dspinerelevantpositions(trx,outputfolder);
end
load(fullfile(outputfolder,'dxcentral_mm.mat'), 'data')
dxcentral_mm=data;
load(fullfile(outputfolder,'dycentral_mm.mat'), 'data')
dycentral_mm=data;
numlarvae=size(trx,2);
velmagcentral=cell(1,numlarvae);
for i=1:numlarvae
    velmagcentral{1,i}=bsxfun(@hypot,dxcentral_mm{1,i},dycentral_mm{1,i});
end

units=struct('num','mm','den','s');
data=velmagcentral;
filename=fullfile(outputfolder, 'velmagcentral.mat');
save(filename, 'data', 'units') 
