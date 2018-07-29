%compute dtailcentralmag
function [trx]=compute_dtailcentralmag(trx,outputfolder)

inputfilename=fullfile(outputfolder,'tailcentralmag.mat');
if ~exist(inputfilename,'file')
    [trx]=compute_tailcentralmag(trx,outputfolder);
end
load(fullfile(outputfolder,'tailcentralmag.mat'), 'data')
tailcentralmag=data;

numlarvae=size(trx,2);
dtailcentralmag=cell(1,numlarvae);
for i=1:numlarvae
    dtailcentralmag{1,i}=(tailcentralmag{1,i}(2:end)-tailcentralmag{1,i}(1:end-1))./trx(i).dt;
end

units=struct('num','mm','den','s');
data=dtailcentralmag;
filename=fullfile(outputfolder, 'dtailcentralmag.mat');
save(filename, 'data', 'units')