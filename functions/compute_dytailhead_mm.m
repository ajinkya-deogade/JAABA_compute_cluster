%compute dytailhead
function [trx]=compute_dytailhead_mm(trx,outputfolder)

numlarvae=size(trx,2);
dytailhead=cell(1,numlarvae);
dt=cell(1,numlarvae);
inputfilename=fullfile(outputfolder,'ytailhead_mm.mat');
if ~exist(inputfilename,'file')
    compute_ytailhead_mm(trx,outputfolder);
end
load(inputfilename, 'data')
ytailhead=data;
for i=1:numlarvae
    dt{1,i}=trx(i).dt;
    dytailhead{1,i}=(ytailhead{1,i}(2:end)-ytailhead{1,i}(1:end-1))./dt{1,i};
end

units=struct('num','mm','den','s');
data=dytailhead;
filename=fullfile(outputfolder, 'dytailhead_mm.mat');
save(filename, 'data', 'units')