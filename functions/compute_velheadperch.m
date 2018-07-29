%compute head speed in the direction perpendicular to the central-head direction
function [trx]=compute_velheadperch(trx,outputfolder)
inputfilenamech=fullfile(outputfolder,'centralheadang.mat');
if ~exist(inputfilenamech,'file')
    [trx]=compute_centralheadang(trx,outputfolder);
end
load(inputfilenamech,'data')
centralheadang=data;
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
numlarvae=size(centralheadang,2);
velheadperch=cell(1,numlarvae);
centralheadangperp=cell(1,numlarvae);
for i=1:numlarvae
    centralheadangperp{1,i}=centralheadang{1,i}-pi/2;
    velheadperch{1,i}=velmaghead{1,i}.*(cos(velanghead{1,i}).*cos(centralheadangperp{1,i}(1,1:end-1))+sin(velanghead{1,i}).*sin(centralheadangperp{1,i}(1,1:end-1)));
end

units=struct('num','mm','den','s');
data=velheadperch;
filename=fullfile(outputfolder, 'velheadperch.mat');
save(filename, 'data', 'units')