%compute head speed in the tail-central direction
function [trx]=compute_velheadtc(trx,outputfolder)
inputfilenametc=fullfile(outputfolder,'tailcentralang.mat');
if ~exist(inputfilenametc,'file')
    [trx]=compute_tailcentralang(trx,outputfolder);
end
load(inputfilenametc,'data')
tailcentralang=data;
inputfilenameang=fullfile(outputfolder,'velanghead.mat');
if ~exist(inputfilenameang,'file')
    [trx]=compute_velanghead(trx,outputfolder);
end
load(inputfilenameang, 'data')
velanghead=data;
inputfilenamemag=fullfile(outputfolder,'velmaghead.mat');
if ~exist(inputfilenamemag,'file')
    [trx]=compute_velmaghead(trx,outputfolder);
end
load(inputfilenamemag, 'data')
velmaghead=data;
numlarvae=size(tailcentralang,2);
velheadtc=cell(1,numlarvae);
for i=1:numlarvae
    velheadtc{1,i}=velmaghead{1,i}.*(cos(velanghead{1,i}).*cos(tailcentralang{1,i}(1,1:end-1))+sin(velanghead{1,i}).*sin(tailcentralang{1,i}(1,1:end-1)));
end

units=struct('num','mm','den','s');
data=velheadtc;
filename=fullfile(outputfolder, 'velheadtc.mat');
save(filename, 'data', 'units')