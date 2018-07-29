%compute dytailcentral
function [trx]=compute_dytailcentral_mm(trx,outputfolder)

numlarvae=size(trx,2);
dytailcentral=cell(1,numlarvae);
dt=cell(1,numlarvae);
inputfilename=fullfile(outputfolder,'ytailcentral_mm.mat');
if ~exist(inputfilename,'file')
    compute_ytailcentral_mm(trx,outputfolder);
end
load(inputfilename, 'data')
ytailcentral=data;
for i=1:numlarvae
    dt{1,i}=trx(i).dt;
    dytailcentral{1,i}=(ytailcentral{1,i}(2:end)-ytailcentral{1,i}(1:end-1))./dt{1,i};
end

units=struct('num','mm','den','s');
data=dytailcentral;
filename=fullfile(outputfolder, 'dytailcentral_mm.mat');
save(filename, 'data', 'units')