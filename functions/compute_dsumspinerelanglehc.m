%compute dsumspinerelanglehc 
function [trx]=compute_dsumspinerelanglehc(trx,outputfolder)
inputfilename=fullfile(outputfolder,'sumspinerelanglehc.mat');
if ~exist(inputfilename,'file')
    [trx]=compute_sumspinerelanglehc(trx,outputfolder);
end
load(inputfilename,'data')
sumspinerelanglehc=data;
numlarvae=size(trx,2);
dsumspinerelanglehc=cell(1,numlarvae);
for i=1:numlarvae
   dsumspinerelanglehc{1,i}=bsxfun(@minus,sumspinerelanglehc{1,i}(2:end),sumspinerelanglehc{1,i}(1:end-1));
end

units=struct('num','rad','den','s');
data=dsumspinerelanglehc;
filename=fullfile(outputfolder, 'dsumspinerelanglehc.mat');
save(filename, 'data', 'units') 