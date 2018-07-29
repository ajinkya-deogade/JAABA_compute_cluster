%compute the sum of relative angles along the larva
function [trx]=compute_sumspinerelangle(trx,outputfolder)
inputfilename=fullfile(outputfolder,'spinerelangle.mat');
if ~exist(inputfilename,'file')
    [trx]=compute_spinerelangle(trx,outputfolder);
end
load(inputfilename,'data')
spinerelangle=data;
numlarvae=size(trx,2);
sumspinerelangle=cell(1,numlarvae);
for i=1:numlarvae
    sumspinerelangle{1,i}=sum(spinerelangle{1,i});
end

units=struct('num','rad','den',[]);
data=sumspinerelangle;
filename=fullfile(outputfolder, 'sumspinerelangle.mat');
save(filename, 'data', 'units') 


