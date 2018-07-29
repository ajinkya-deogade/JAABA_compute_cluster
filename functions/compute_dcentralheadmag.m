%compute dcentralheadmag
function [trx]=compute_dcentralheadmag(trx,outputfolder)

inputfilename=fullfile(outputfolder,'centralheadmag.mat');
if ~exist(inputfilename,'file')
    [trx]=compute_centralheadmag(trx,outputfolder);
end
load(fullfile(outputfolder,'centralheadmag.mat'), 'data')
centralheadmag=data;

numlarvae=size(trx,2);
dcentralheadmag=cell(1,numlarvae);
for i=1:numlarvae
    dcentralheadmag{1,i}=(centralheadmag{1,i}(2:end)-centralheadmag{1,i}(1:end-1))./trx(i).dt;
end

units=struct('num','mm','den','s');
data=dcentralheadmag;
filename=fullfile(outputfolder, 'dcentralheadmag.mat');
save(filename, 'data', 'units')