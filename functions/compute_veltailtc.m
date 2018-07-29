%compute tail speed in the tail-central direction
function [trx]=compute_veltailtc(trx,outputfolder)
inputfilenametc=fullfile(outputfolder,'tailcentralang.mat');
if ~exist(inputfilenametc,'file')
    [trx]=compute_tailcentralang(trx,outputfolder);
end
load(inputfilenametc,'data')
tailcentralang=data;
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
numlarvae=size(tailcentralang,2);
veltailtc=cell(1,numlarvae);
for i=1:numlarvae
    veltailtc{1,i}=velmagtail{1,i}.*(cos(velangtail{1,i}).*cos(tailcentralang{1,i}(1,1:end-1))+sin(velangtail{1,i}).*sin(tailcentralang{1,i}(1,1:end-1)));
end

units=struct('num','mm','den','s');
data=veltailtc;
filename=fullfile(outputfolder, 'veltailtc.mat');
save(filename, 'data', 'units')