%compute speed in the tail-head direction
function [trx]=compute_velth(trx,outputfolder)
inputfilenamech=fullfile(outputfolder,'tailheadang.mat');
if ~exist(inputfilenamech,'file')
    [trx]=compute_tailheadang(trx,outputfolder);
end
load(inputfilenamech,'data')
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
velth=cell(1,numlarvae);
for i=1:numlarvae
    velth{1,i}=velmag{1,i}.*(cos(velang{1,i}).*cos(tailheadang{1,i}(1,1:end-1))+sin(velang{1,i}).*sin(tailheadang{1,i}(1,1:end-1)));
end

units=struct('num','mm','den','s');
data=velth;
filename=fullfile(outputfolder, 'velth.mat');
save(filename, 'data', 'units')
