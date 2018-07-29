%compute ang between vector tailinfl and vector inflhead

function [trx]=compute_angihvsangti(trx,outputfolder)
inputfilenameti=fullfile(outputfolder,'tailinflang.mat');
if ~exist(inputfilenameti,'file')
    [trx]=compute_tailinflang(trx,outputfolder);
end
load(inputfilenameti,'data')
tailinflang=data;
inputfilenameih=fullfile(outputfolder,'inflheadang.mat');
if ~exist(inputfilenameih,'file')
    [trx]=compute_inflheadang(trx,outputfolder);
end
load(inputfilenameih,'data')
inflheadang=data;

numlarvae=size(trx,2);
angihvsangti=cell(1,numlarvae);
absangihvsangti=cell(1,numlarvae);
for i=1:numlarvae
    absangihvsangti{1,i}=real(acos(cos(tailinflang{1,i}).*cos(inflheadang{1,i})+sin(tailinflang{1,i}).*sin(inflheadang{1,i})));
    temp=tailinflang{1,i}-pi/2;
    cosperp=sign(cos(temp).*cos(inflheadang{1,i})+sin(temp).*sin(inflheadang{1,i}));
    angihvsangti{1,i}=bsxfun(@times,absangihvsangti{1,i},cosperp);
end

units=struct('num','rad','den',[]);
data=absangihvsangti;
filename=fullfile(outputfolder, 'absangihvsangti.mat');
save(filename, 'data', 'units')

units=struct('num','rad','den',[]);
data=angihvsangti;
filename=fullfile(outputfolder, 'angihvsangti.mat');
save(filename, 'data', 'units')
