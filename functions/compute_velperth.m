%compute speed in the direction perpendicular to tail-head direction
function [trx]=compute_velperth(trx,outputfolder)

inputfilenameth=fullfile(outputfolder,'tailcentralang.mat');
if ~exist(inputfilenameth,'file')
    [trx]=compute_tailcentralang(trx,outputfolder);
end
load(inputfilenameth,'data')
tailheadang=data;
inputfilenameang=fullfile(outputfolder,'velang.mat');
if ~exist(inputfilenameang,'file')
    compute_velang(trx,outputfolder);
end
load(inputfilenameang, 'data')
velang=data;
inputfilenamemag=fullfile(outputfolder,'velmag_ctr.mat');
if ~exist(inputfilenamemag,'file')
    compute_velmag_ctr(trx,outputfolder);
end
load(inputfilenamemag, 'data')
velmag=data;
numlarvae=size(tailheadang,2);
velperth=cell(1,numlarvae);
tailheadangperp=cell(1,numlarvae);
for i=1:numlarvae
    tailheadangperp{1,i}=tailheadang{1,i}-pi/2;
    velperth{1,i}=velmag{1,i}.*(cos(velang{1,i}).*cos(tailheadangperp{1,i}(1,1:end-1))+sin(velang{1,i}).*sin(tailheadangperp{1,i}(1,1:end-1)));
end

units=struct('num','mm','den','s');
data=velperth;
filename=fullfile(outputfolder, 'velperth.mat');
save(filename, 'data', 'units')
