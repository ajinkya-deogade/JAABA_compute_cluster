%compute dxcentralhead
function [trx]=compute_dxcentralhead_mm(trx,outputfolder)

numlarvae=size(trx,2);
dxcentralhead=cell(1,numlarvae);
dt=cell(1,numlarvae);
inputfilename=fullfile(outputfolder,'xcentralhead_mm.mat');
if ~exist(inputfilename,'file')
    compute_xcentralhead_mm(trx,outputfolder);
end
load(inputfilename, 'data')
xcentralhead=data;
for i=1:numlarvae
    dt{1,i}=trx(i).dt;
    dxcentralhead{1,i}=(xcentralhead{1,i}(2:end)-xcentralhead{1,i}(1:end-1))./dt{1,i};
end

units=struct('num','mm','den','s');
data=dxcentralhead;
filename=fullfile(outputfolder, 'dxcentralhead_mm.mat');
save(filename, 'data', 'units')