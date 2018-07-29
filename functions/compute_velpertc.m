%compute speed in the direction perpendicular to tail-central direction
function [trx]=compute_velpertc(trx,outputfolder)

inputfilenametc=fullfile(outputfolder,'tailcentralang.mat');
if ~exist(inputfilenametc,'file')
    [trx]=compute_tailcentralang(trx,outputfolder);
end
load(inputfilenametc,'data')
tailcentralang=data;
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
numlarvae=size(tailcentralang,2);
velpertc=cell(1,numlarvae);
tailcentralangperp=cell(1,numlarvae);
for i=1:numlarvae
    tailcentralangperp{1,i}=tailcentralang{1,i}-pi/2;
    velpertc{1,i}=velmag{1,i}.*(cos(velang{1,i}).*cos(tailcentralangperp{1,i}(1,1:end-1))+sin(velang{1,i}).*sin(tailcentralangperp{1,i}(1,1:end-1)));
end

units=struct('num','mm','den','s');
data=velpertc;
filename=fullfile(outputfolder, 'velpertc.mat');
save(filename, 'data', 'units')
