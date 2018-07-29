%compute dxtailcentral
function [trx]=compute_dxtailcentral_mm(trx,outputfolder)

numlarvae=size(trx,2);
dxtailcentral=cell(1,numlarvae);
dt=cell(1,numlarvae);
inputfilename=fullfile(outputfolder,'xtailcentral_mm.mat');
if ~exist(inputfilename,'file')
    compute_xtailcentral_mm(trx,outputfolder);
end
load(inputfilename, 'data')
xtailcentral=data;
for i=1:numlarvae
    dt{1,i}=trx(i).dt;
    dxtailcentral{1,i}=(xtailcentral{1,i}(2:end)-xtailcentral{1,i}(1:end-1))./dt{1,i};
end

units=struct('num','mm','den','s');
data=dxtailcentral;
filename=fullfile(outputfolder, 'dxtailcentral_mm.mat');
save(filename, 'data', 'units')