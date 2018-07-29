%compute the sum of relative angles from head to central
function [trx]=compute_sumspinerelanglehc(trx,outputfolder)
inputfilename=fullfile(outputfolder,'spinerelangle.mat');
if ~exist(inputfilename,'file')
    [trx]=compute_spinerelangle(trx,outputfolder);
end
load(inputfilename,'data')
spinerelangle=data;
numlarvae=size(trx,2);
sumspinerelanglehc=cell(1,numlarvae);
for i=1:numlarvae
    sumspinerelanglehc{1,i}=sum(spinerelangle{1,i}(1:5,:));
end

units=struct('num','rad','den',[]);
data=sumspinerelanglehc;
filename=fullfile(outputfolder, 'sumspinerelanglehc.mat');
save(filename, 'data', 'units') 
