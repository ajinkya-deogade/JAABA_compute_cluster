%compute dsumspinerelanglect
function [trx]=compute_dsumspinerelanglect(trx,outputfolder)
inputfilename=fullfile(outputfolder,'sumspinerelanglect.mat');
if ~exist(inputfilename,'file')
    [trx]=compute_sumspinerelanglect(trx,outputfolder);
end
load(inputfilename,'data')
sumspinerelanglect=data;
numlarvae=size(trx,2);
dsumspinerelanglect=cell(1,numlarvae);
for i=1:numlarvae
   dsumspinerelanglect{1,i}=bsxfun(@minus,sumspinerelanglect{1,i}(2:end),sumspinerelanglect{1,i}(1:end-1));
end

units=struct('num','rad','den','s');
data=dsumspinerelanglect;
filename=fullfile(outputfolder, 'dsumspinerelanglect.mat');
save(filename, 'data', 'units') 