%compute tail speed in the central-head direction
function [trx]=compute_veltailch(trx,outputfolder)
inputfilenamech=fullfile(outputfolder,'centralheadang.mat');
if ~exist(inputfilenamech,'file')
    [trx]=compute_centralheadang(trx,outputfolder);
end
load(inputfilenamech,'data')
centralheadang=data;
inputfilenameang=fullfile(outputfolder,'velangtail.mat');
if ~exist(inputfilenameang,'file')
    [trx]=compute_velangtail(trx,outputfolder);
end
load(inputfilenameang, 'data')
velangtail=data;
inputfilenamemag=fullfile(outputfolder,'velmagtail.mat');
if ~exist(inputfilenamemag,'file')
    [trx]=compute_velmagtail(trx,outputfolder);
end
load(inputfilenamemag, 'data')
velmagtail=data;
numlarvae=size(centralheadang,2);
veltailch=cell(1,numlarvae);
for i=1:numlarvae
    veltailch{1,i}=velmagtail{1,i}.*(cos(velangtail{1,i}).*cos(centralheadang{1,i}(1,1:end-1))+sin(velangtail{1,i}).*sin(centralheadang{1,i}(1,1:end-1)));
end

units=struct('num','mm','den','s');
data=veltailch;
filename=fullfile(outputfolder, 'veltailch.mat');
save(filename, 'data', 'units')