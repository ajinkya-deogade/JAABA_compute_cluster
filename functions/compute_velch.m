%compute speed in the central-head direction
function [trx]=compute_velch(trx,outputfolder)
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
velch=cell(1,numlarvae);
for i=1:numlarvae
    velch{1,i}=velmag{1,i}.*(cos(velang{1,i}).*cos(centralheadang{1,i}(1,1:end-1))+sin(velang{1,i}).*sin(centralheadang{1,i}(1,1:end-1)));
end

units=struct('num','mm','den','s');
data=velch;
filename=fullfile(outputfolder, 'velch.mat');
save(filename, 'data', 'units')
