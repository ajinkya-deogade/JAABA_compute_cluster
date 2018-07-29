%compute central speed in the tail-central direction
function [trx]=compute_velcentraltc(trx,outputfolder)
inputfilenametc=fullfile(outputfolder,'tailcentralang.mat');
if ~exist(inputfilenametc,'file')
    [trx]=compute_tailcentralang(trx,outputfolder);
end
load(inputfilenametc,'data')
tailcentralang=data;
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
numlarvae=size(tailcentralang,2);
velcentraltc=cell(1,numlarvae);
for i=1:numlarvae
    velcentraltc{1,i}=velmagcentral{1,i}.*(cos(velangcentral{1,i}).*cos(tailcentralang{1,i}(1,1:end-1))+sin(velangcentral{1,i}).*sin(tailcentralang{1,i}(1,1:end-1)));
end

units=struct('num','mm','den','s');
data=velcentraltc;
filename=fullfile(outputfolder, 'velcentraltc.mat');
save(filename, 'data', 'units')