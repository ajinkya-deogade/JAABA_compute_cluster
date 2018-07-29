%compute velmag_tailcentral
function [trx]=compute_velmagtailcentral(trx,outputfolder)
inputfilename=fullfile(outputfolder,'dxtailcentral_mm.mat');
if ~exist(inputfilename,'file')
    [trx]=compute_dxtailcentral_mm(trx,outputfolder);
end
load(fullfile(outputfolder,'dxtailcentral_mm.mat'), 'data')
dxtailcentral_mm=data;
inputfilename=fullfile(outputfolder,'dytailcentral_mm.mat');
if ~exist(inputfilename,'file')
    [trx]=compute_dytailcentral_mm(trx,outputfolder);
end
load(fullfile(outputfolder,'dytailcentral_mm.mat'), 'data')
dytailcentral_mm=data;
numlarvae=size(trx,2);
velmagtailcentral=cell(1,numlarvae);
for i=1:numlarvae
    velmagtailcentral{1,i}=bsxfun(@hypot,dxtailcentral_mm{1,i},dytailcentral_mm{1,i});
end

units=struct('num','mm','den','s');
data=velmagtailcentral;
filename=fullfile(outputfolder, 'velmagtailcentral.mat');
save(filename, 'data', 'units') 