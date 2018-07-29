%compute tail speed in the direction perpendicular to the tail-central direction
function [trx]=compute_veltailpertc(trx,outputfolder)
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
veltailpertc=cell(1,numlarvae);
tailcentralangperp=cell(1,numlarvae);
for i=1:numlarvae
    tailcentralangperp{1,i}=tailcentralang{1,i}-pi/2;
    veltailpertc{1,i}=velmagtail{1,i}.*(cos(velangtail{1,i}).*cos(tailcentralangperp{1,i}(1,1:end-1))+sin(velangtail{1,i}).*sin(tailcentralangperp{1,i}(1,1:end-1)));
end

units=struct('num','mm','den','s');
data=veltailpertc;
filename=fullfile(outputfolder, 'veltailpertc.mat');
save(filename, 'data', 'units')