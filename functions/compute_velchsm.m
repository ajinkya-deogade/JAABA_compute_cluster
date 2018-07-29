%compute speed in the central-headsmooth direction
function [trx]=compute_velchsm(trx,outputfolder)
inputfilenamech=[outputfolder,'centralheadsmang.mat'];
if ~exist(inputfilenamech,'file')
    [trx]=compute_centralheadsmang(trx,outputfolder);
end
load(inputfilenamech,'data')
centralheadsmang=data;
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
numlarvae=size(centralheadsmang,2);
velchsm=cell(1,numlarvae);
for i=1:numlarvae
    velchsm{1,i}=velmag{1,i}.*(cos(velang{1,i}).*cos(centralheadsmang{1,i}(1,1:end-1))+sin(velang{1,i}).*sin(centralheadsmang{1,i}(1,1:end-1)));
end

units=struct('num','mm','den','s');
data=velchsm;
filename=[outputfolder, 'velchsm.mat'];
save(filename, 'data', 'units')
