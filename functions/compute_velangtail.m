%compute velang_tail
function [trx]=compute_velangtail(trx,outputfolder)
inputfilename=fullfile(outputfolder,'dxtail_mm.mat');
if ~exist(inputfilename,'file')
    [trx]=compute_dspinerelevantpositions(trx,outputfolder);
end
load(fullfile(outputfolder,'dxtail_mm.mat'), 'data')
dxtail_mm=data;
load(fullfile(outputfolder,'dytail_mm.mat'), 'data')
dytail_mm=data;
numlarvae=size(trx,2);
velangtail=cell(1,numlarvae);
for i=1:numlarvae
    velangtail{1,i}=bsxfun(@atan2,dytail_mm{1,i},dxtail_mm{1,i});
end

units=struct('num','rad','den','s');
data=velangtail;
filename=fullfile(outputfolder, 'velangtail.mat');
save(filename, 'data', 'units') 