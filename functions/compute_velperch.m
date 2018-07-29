%compute speed in the direction perpendicular to central-head direction
function [trx]=compute_velperch(trx,outputfolder)

inputfilenamech=fullfile(outputfolder,'centralheadang.mat');
if ~exist(inputfilenamech,'file')
    [trx]=compute_centralheadang(trx,outputfolder);
end
load(inputfilenamech,'data')
centralheadang=data;
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
numlarvae=size(centralheadang,2);
velperch=cell(1,numlarvae);
centralheadangperp=cell(1,numlarvae);
for i=1:numlarvae
    centralheadangperp{1,i}=centralheadang{1,i}-pi/2;
    velperch{1,i}=velmag{1,i}.*(cos(velang{1,i}).*cos(centralheadangperp{1,i}(1,1:end-1))+sin(velang{1,i}).*sin(centralheadangperp{1,i}(1,1:end-1)));
end

units=struct('num','mm','den','s');
data=velperch;
filename=fullfile(outputfolder, 'velperch.mat');
save(filename, 'data', 'units')
