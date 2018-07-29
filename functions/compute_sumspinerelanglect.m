%compute the sum of relative angles from central to tail
function [trx]=compute_sumspinerelanglect(trx,outputfolder)
inputfilename=fullfile(outputfolder,'spinerelangle.mat');
if ~exist(inputfilename,'file')
    [trx]=compute_spinerelangle(trx,outputfolder);
end
load(inputfilename,'data')
spinerelangle=data;
numlarvae=size(trx,2);
sumspinerelanglect=cell(1,numlarvae);
for i=1:numlarvae
    sumspinerelanglect{1,i}=sum(spinerelangle{1,i}(5:9,:));
end

units=struct('num','rad','den',[]);
data=sumspinerelanglect;
filename=fullfile(outputfolder, 'sumspinerelanglect.mat');
save(filename, 'data', 'units') 