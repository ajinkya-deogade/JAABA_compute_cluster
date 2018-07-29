%compute velang_central
function [trx]=compute_velangcentral(trx,outputfolder)
inputfilename=fullfile(outputfolder,'dxcentral_mm.mat');
if ~exist(inputfilename,'file')
    [trx]=compute_dspinerelevantpositions(trx,outputfolder);
end
load(fullfile(outputfolder,'dxcentral_mm.mat'), 'data')
dxcentral_mm=data;
load(fullfile(outputfolder,'dycentral_mm.mat'), 'data')
dycentral_mm=data;
numlarvae=size(trx,2);
velangcentral=cell(1,numlarvae);
for i=1:numlarvae
    velangcentral{1,i}=bsxfun(@atan2,dycentral_mm{1,i},dxcentral_mm{1,i});
end

units=struct('num','rad','den','s');
data=velangcentral;
filename=fullfile(outputfolder, 'velangcentral.mat');
save(filename, 'data', 'units') 
