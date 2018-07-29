%compute dratiolengthvsth
function[trx]=compute_dratiolengthvsth(trx,outputfolder)
inputfilename=fullfile(outputfolder,'spinelength.mat');
if ~exist(inputfilename,'file')
    [trx]=compute_ratiolengthvsth(trx,outputfolder);
end
load(inputfilename, 'data')
ratiolengthvsth=data;
numlarvae=size(trx,2);
dratiolengthvsth=cell(1,numlarvae);
for i=1:numlarvae
    dratiolengthvsth{1,i}=bsxfun(@minus,ratiolengthvsth{1,i}(2:end),ratiolengthvsth{1,i}(1:end-1))./trx(i).dt;
end

units=struct('num','units','den','s');
data=dratiolengthvsth;
filename=fullfile(outputfolder, 'dratiolengthvsth.mat');
save(filename, 'data', 'units')
