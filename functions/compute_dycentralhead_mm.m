%compute dycentralhead
function [trx]=compute_dycentralhead_mm(trx,outputfolder)

numlarvae=size(trx,2);
dycentralhead=cell(1,numlarvae);
dt=cell(1,numlarvae);
inputfilename=fullfile(outputfolder,'ycentralhead_mm.mat');
if ~exist(inputfilename,'file')
    compute_ycentralhead_mm(trx,outputfolder);
end
load(inputfilename, 'data')
ycentralhead=data;
for i=1:numlarvae
    dt{1,i}=trx(i).dt;
    dycentralhead{1,i}=(ycentralhead{1,i}(2:end)-ycentralhead{1,i}(1:end-1))./dt{1,i};
end

units=struct('num','mm','den','s');
data=dycentralhead;
filename=fullfile(outputfolder, 'dycentralhead_mm.mat');
save(filename, 'data', 'units')