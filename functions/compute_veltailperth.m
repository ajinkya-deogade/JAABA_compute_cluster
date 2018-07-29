%compute tail speed in the direction perpendicular to the tail-head direction
function [trx]=compute_veltailperth(trx,outputfolder)
inputfilenameth=fullfile(outputfolder,'tailheadang.mat');
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
veltailperth=cell(1,numlarvae);
tailheadangperp=cell(1,numlarvae);
for i=1:numlarvae
    tailheadangperp{1,i}=tailheadang{1,i}-pi/2;
    veltailperth{1,i}=velmagtail{1,i}.*(cos(velangtail{1,i}).*cos(tailheadangperp{1,i}(1,1:end-1))+sin(velangtail{1,i}).*sin(tailheadangperp{1,i}(1,1:end-1)));
end

units=struct('num','mm','den','s');
data=veltailperth;
filename=fullfile(outputfolder, 'veltailperth.mat');
save(filename, 'data', 'units')