%compute tail speed in the tail-head direction
function [trx]=compute_veltailth(trx,outputfolder)
inputfilenameth=fullfile(outputfolder,'tailcentralang.mat');
if ~exist(inputfilenameth,'file')
    [trx]=compute_tailheadang(trx,outputfolder);
end
load(inputfilenameth,'data')
tailheadang=data;
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
numlarvae=size(tailheadang,2);
veltailth=cell(1,numlarvae);
for i=1:numlarvae
    veltailth{1,i}=velmagtail{1,i}.*(cos(velangtail{1,i}).*cos(tailheadang{1,i}(1,1:end-1))+sin(velangtail{1,i}).*sin(tailheadang{1,i}(1,1:end-1)));
end

units=struct('num','mm','den','s');
data=veltailth;
filename=fullfile(outputfolder, 'veltailth.mat');
save(filename, 'data', 'units')