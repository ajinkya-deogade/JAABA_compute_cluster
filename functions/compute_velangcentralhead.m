%compute velang_centralhead
function [trx]=compute_velangcentralhead(trx,outputfolder)
inputfilename=fullfile(outputfolder,'dxcentralhead_mm.mat');
if ~exist(inputfilename,'file')
    [trx]=compute_dxcentralhead_mm(trx,outputfolder);
end
load(fullfile(outputfolder,'dxcentralhead_mm.mat'), 'data')
dxcentralhead_mm=data;
inputfilename=fullfile(outputfolder,'dycentralhead_mm.mat');
if ~exist(inputfilename,'file')
    [trx]=compute_dycentralhead_mm(trx,outputfolder);
end
load(fullfile(outputfolder,'dycentralhead_mm.mat'), 'data')
dycentralhead_mm=data;
numlarvae=size(trx,2);
velangcentralhead=cell(1,numlarvae);
for i=1:numlarvae
    velangcentralhead{1,i}=bsxfun(@atan2,dycentralhead_mm{1,i},dxcentralhead_mm{1,i});
end

units=struct('num','rad','den','s');
data=velangcentralhead;
filename=fullfile(outputfolder, 'velangcentralhead.mat');
save(filename, 'data', 'units') 