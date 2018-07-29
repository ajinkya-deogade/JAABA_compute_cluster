%compute speed in the tailsmooth-headsmooth direction
function [trx]=compute_veltsmhsm(trx,outputfolder)
inputfilenamech=[outputfolder,'tailsmheadsmang.mat'];
if ~exist(inputfilenamech,'file')
    [trx]=compute_tailsmheadsmang(trx,outputfolder);
end
load(inputfilenamech,'data')
tailsmheadsmang=data;
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
numlarvae=size(tailsmheadsmang,2);
veltsmhsm=cell(1,numlarvae);
for i=1:numlarvae
    veltsmhsm{1,i}=velmag{1,i}.*(cos(velang{1,i}).*cos(tailsmheadsmang{1,i}(1,1:end-1))+sin(velang{1,i}).*sin(tailsmheadsmang{1,i}(1,1:end-1)));
end

units=struct('num','mm','den','s');
data=veltsmhsm;
filename=[outputfolder, 'veltsmhsm.mat'];
save(filename, 'data', 'units')
