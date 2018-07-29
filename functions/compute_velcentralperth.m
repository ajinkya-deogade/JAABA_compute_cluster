%compute central speed in the direction perpendicular to the tail-head direction
function [trx]=compute_velcentralperth(trx,outputfolder)
inputfilenameth=fullfile(outputfolder,'centralheadang.mat');
if ~exist(inputfilenameth,'file')
    [trx]=compute_tailheadang(trx,outputfolder);
end
load(inputfilenameth,'data')
tailheadang=data;
inputfilenameang=fullfile(outputfolder,'velangcentral.mat');
if ~exist(inputfilenameang,'file')
    [trx]=compute_velangcentral(trx,outputfolder);
end
load(inputfilenameang, 'data')
velangcentral=data;
inputfilenamemag=fullfile(outputfolder,'velmagcentral.mat');
if ~exist(inputfilenamemag,'file')
    [trx]=compute_velmagcentral(trx,outputfolder);
end
load(inputfilenamemag, 'data')
velmagcentral=data;
numlarvae=size(tailheadang,2);
velcentralperth=cell(1,numlarvae);
tailheadangperp=cell(1,numlarvae);
for i=1:numlarvae
    tailheadangperp{1,i}=tailheadang{1,i}-pi/2;
    velcentralperth{1,i}=velmagcentral{1,i}.*(cos(velangcentral{1,i}).*cos(tailheadangperp{1,i}(1,1:end-1))+sin(velangcentral{1,i}).*sin(tailheadangperp{1,i}(1,1:end-1)));
end

units=struct('num','mm','den','s');
data=velcentralperth;
filename=fullfile(outputfolder, 'velcentralperth.mat');
save(filename, 'data', 'units')