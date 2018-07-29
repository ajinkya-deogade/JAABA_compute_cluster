%compute head speed in the direction perpendicular to the tail-head direction
function [trx]=compute_velheadperth(trx,outputfolder)
inputfilenameth=fullfile(outputfolder,'tailcentralang.mat');
if ~exist(inputfilenameth,'file')
    [trx]=compute_tailheadang(trx,outputfolder);
end
load(inputfilenameth,'data')
tailheadang=data;
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
numlarvae=size(tailheadang,2);
velheadperth=cell(1,numlarvae);
tailheadangperp=cell(1,numlarvae);
for i=1:numlarvae
    tailheadangperp{1,i}=tailheadang{1,i}-pi/2;
    velheadperth{1,i}=velmaghead{1,i}.*(cos(velanghead{1,i}).*cos(tailheadangperp{1,i}(1,1:end-1))+sin(velanghead{1,i}).*sin(tailheadangperp{1,i}(1,1:end-1)));
end

units=struct('num','mm','den','s');
data=velheadperth;
filename=fullfile(outputfolder, 'velheadperth.mat');
save(filename, 'data', 'units')