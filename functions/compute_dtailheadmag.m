%compute dtailheadmag
function [trx]=compute_dtailheadmag(trx,outputfolder)

inputfilename=fullfile(outputfolder,'tailheadmag.mat');
if ~exist(inputfilename,'file')
    [trx]=compute_tailheadmag(trx,outputfolder);
end
load(fullfile(outputfolder,'tailheadmag.mat'), 'data')
tailheadmag=data;

numlarvae=size(trx,2);
dtailheadmag=cell(1,numlarvae);
for i=1:numlarvae
    dtailheadmag{1,i}=(tailheadmag{1,i}(2:end)-tailheadmag{1,i}(1:end-1))./trx(i).dt;
end

units=struct('num','mm','den','s');
data=dtailheadmag;
filename=fullfile(outputfolder, 'dtailheadmag.mat');
save(filename, 'data', 'units')