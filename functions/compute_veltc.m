%compute speed in the tail-central direction
function [trx]=compute_veltc(trx,outputfolder)
inputfilenamech=fullfile(outputfolder,'tailcentralang.mat');
if ~exist(inputfilenamech,'file')
    [trx]=compute_tailcentralang(trx,outputfolder);
end
load(inputfilenamech,'data')
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
veltc=cell(1,numlarvae);
for i=1:numlarvae
    veltc{1,i}=velmag{1,i}.*(cos(velang{1,i}).*cos(tailcentralang{1,i}(1,1:end-1))+sin(velang{1,i}).*sin(tailcentralang{1,i}(1,1:end-1)));
end

units=struct('num','mm','den','s');
data=veltc;
filename=fullfile(outputfolder, 'veltc.mat');
save(filename, 'data', 'units')
