%compute central speed in the direction perpendicular to the central-head direction
function [trx]=compute_velcentralperch(trx,outputfolder)
inputfilenamech=fullfile(outputfolder,'centralheadang.mat');
if ~exist(inputfilenamech,'file')
    [trx]=compute_centralheadang(trx,outputfolder);
end
load(inputfilenamech,'data')
centralheadang=data;
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
numlarvae=size(centralheadang,2);
velcentralperch=cell(1,numlarvae);
centralheadangperp=cell(1,numlarvae);
for i=1:numlarvae
    centralheadangperp{1,i}=centralheadang{1,i}-pi/2;
    velcentralperch{1,i}=velmagcentral{1,i}.*(cos(velangcentral{1,i}).*cos(centralheadangperp{1,i}(1,1:end-1))+sin(velangcentral{1,i}).*sin(centralheadangperp{1,i}(1,1:end-1)));
end

units=struct('num','mm','den','s');
data=velcentralperch;
filename=fullfile(outputfolder, 'velcentralperch.mat');
save(filename, 'data', 'units')