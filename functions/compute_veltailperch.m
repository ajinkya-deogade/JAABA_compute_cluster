%compute tail speed in the direction perpendicular to the central-head direction
function [trx]=compute_veltailperch(trx,outputfolder)
inputfilenamech=fullfile(outputfolder,'centralheadang.mat');
if ~exist(inputfilenamech,'file')
    [trx]=compute_centralheadang(trx,outputfolder);
end
load(inputfilenamech,'data')
centralheadang=data;
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
numlarvae=size(centralheadang,2);
veltailperch=cell(1,numlarvae);
centralheadangperp=cell(1,numlarvae);
for i=1:numlarvae
    centralheadangperp{1,i}=centralheadang{1,i}-pi/2;
    veltailperch{1,i}=velmagtail{1,i}.*(cos(velangtail{1,i}).*cos(centralheadangperp{1,i}(1,1:end-1))+sin(velangtail{1,i}).*sin(centralheadangperp{1,i}(1,1:end-1)));
end

units=struct('num','mm','den','s');
data=veltailperch;
filename=fullfile(outputfolder, 'veltailperch.mat');
save(filename, 'data', 'units')