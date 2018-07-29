%compute central speed in the tail-head direction
function [trx]=compute_velcentralth(trx,outputfolder)
inputfilenameth=fullfile(outputfolder,'tailheadang.mat');
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
velcentralth=cell(1,numlarvae);
for i=1:numlarvae
    velcentralth{1,i}=velmagcentral{1,i}.*(cos(velangcentral{1,i}).*cos(tailheadang{1,i}(1,1:end-1))+sin(velangcentral{1,i}).*sin(tailheadang{1,i}(1,1:end-1)));
end

units=struct('num','mm','den','s');
data=velcentralth;
filename=fullfile(outputfolder, 'velcentralth.mat');
save(filename, 'data', 'units')