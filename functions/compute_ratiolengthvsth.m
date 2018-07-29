%compute ratio lengthvsth
function [trx]=compute_ratiolengthvsth(trx,outputfolder)
inputfilenamel=fullfile(outputfolder,'spinelength.mat');
if ~exist(inputfilenamel,'file')
    [trx]=compute_spinelength(trx,outputfolder);
end
load(inputfilenamel, 'data')
spinelength=data;

inputfilenameth=fullfile(outputfolder,'tailheadmag.mat');
if ~exist(inputfilenameth,'file')
    [trx]=compute_tailheadmag(trx,outputfolder);
end
load(inputfilenameth, 'data')
tailheadmag=data;

numlarvae=size(trx,2);
ratiolengthvsth=cell(1,numlarvae);
for i=1:numlarvae
    ratiolengthvsth{1,i}=spinelength{1,i}./tailheadmag{1,i};
end

units=struct('num','units','den',[]);
data=ratiolengthvsth;
filename=fullfile(outputfolder, 'ratiolengthvsth.mat');
save(filename, 'data', 'units')