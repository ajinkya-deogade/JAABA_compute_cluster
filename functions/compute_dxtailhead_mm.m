%compute dxtailhead
function [trx]=compute_dxtailhead_mm(trx,outputfolder)

numlarvae=size(trx,2);
dxtailhead=cell(1,numlarvae);
dt=cell(1,numlarvae);
inputfilename=fullfile(outputfolder,'xtailhead_mm.mat');
if ~exist(inputfilename,'file')
    compute_xtailhead_mm(trx,outputfolder);
end
load(inputfilename, 'data')
xtailhead=data;
for i=1:numlarvae
    dt{1,i}=trx(i).dt;
    dxtailhead{1,i}=(xtailhead{1,i}(2:end)-xtailhead{1,i}(1:end-1))./dt{1,i};
end

units=struct('num','mm','den','s');
data=dxtailhead;
filename=fullfile(outputfolder, 'dxtailhead_mm.mat');
save(filename, 'data', 'units')