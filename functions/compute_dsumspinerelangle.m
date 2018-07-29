%compute dsumspinerelangle 
function [trx]=compute_dsumspinerelangle(trx,outputfolder)
inputfilename=fullfile(outputfolder,'sumspinerelangle.mat');
if ~exist(inputfilename,'file')
    [trx]=compute_sumspinerelangle(trx,outputfolder);
end
load(inputfilename,'data')
sumspinerelangle=data;
numlarvae=size(trx,2);
dsumspinerelangle=cell(1,numlarvae);
for i=1:numlarvae
   dsumspinerelangle{1,i}=bsxfun(@minus,sumspinerelangle{1,i}(2:end),sumspinerelangle{1,i}(1:end-1));
end

units=struct('num','rad','den','s');
data=dsumspinerelangle;
filename=fullfile(outputfolder, 'dsumspinerelangle.mat');
save(filename, 'data', 'units') 

