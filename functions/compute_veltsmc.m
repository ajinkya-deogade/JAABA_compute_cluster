%compute speed in the tailsmooth-central direction
function [trx]=compute_veltsmc(trx,outputfolder)
inputfilenamech=[outputfolder,'tailsmcentralang.mat'];
if ~exist(inputfilenamech,'file')
    [trx]=compute_tailsmcentralang(trx,outputfolder);
end
load(inputfilenamech,'data')
tailsmcentralang=data;
inputfilenameang=[outputfolder,'velang.mat'];
if ~exist(inputfilenameang,'file')
    compute_velang(trx,outputfolder);
end
load(inputfilenameang, 'data')
velang=data;
inputfilenamemag=[outputfolder,'velmag_ctr.mat'];
if ~exist(inputfilenamemag,'file')
    compute_velmag_ctr(trx,outputfolder);
end
load(inputfilenamemag, 'data')
velmag=data;
numlarvae=size(tailsmcentralang,2);
veltsmc=cell(1,numlarvae);
for i=1:numlarvae
    veltsmc{1,i}=velmag{1,i}.*(cos(velang{1,i}).*cos(tailsmcentralang{1,i}(1,1:end-1))+sin(velang{1,i}).*sin(tailsmcentralang{1,i}(1,1:end-1)));
end

units=struct('num','mm','den','s');
data=veltsmc;
filename=[outputfolder, 'veltsmc.mat'];
save(filename, 'data', 'units')