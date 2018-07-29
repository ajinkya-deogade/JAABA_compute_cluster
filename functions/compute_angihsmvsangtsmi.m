%compute ang between vector tailsmoothinfl and vector inflheadsmooth

function [trx]=compute_angihsmvsangtsmi(trx,outputfolder)
inputfilenameti=[outputfolder,'tailsminflang.mat'];
if ~exist(inputfilenameti,'file')
    [trx]=compute_tailsminflang(trx,outputfolder);
end
load(inputfilenameti,'data')
tailsminflang=data;
inputfilenameih=[outputfolder,'inflheadsmang.mat'];
if ~exist(inputfilenameih,'file')
    [trx]=compute_inflheadsmang(trx,outputfolder);
end
load(inputfilenameih,'data')
inflheadsmang=data;

numlarvae=size(trx,2);
angihsmvsangtsmi=cell(1,numlarvae);
absangihsmvsangtsmi=cell(1,numlarvae);
for i=1:numlarvae
    absangihsmvsangtsmi{1,i}=real(acos(cos(tailsminflang{1,i}).*cos(inflheadsmang{1,i})+sin(tailsminflang{1,i}).*sin(inflheadsmang{1,i})));
    temp=tailsminflang{1,i}-pi/2;
    cosperp=sign(cos(temp).*cos(inflheadsmang{1,i})+sin(temp).*sin(inflheadsmang{1,i}));
    angihsmvsangtsmi{1,i}=bsxfun(@times,absangihsmvsangtsmi{1,i},cosperp);
end

units=struct('num','rad','den',[]);
data=absangihsmvsangtsmi;
filename=[outputfolder, 'absangihsmvsangtsmi.mat'];
save(filename, 'data', 'units')

units=struct('num','rad','den',[]);
data=angihsmvsangtsmi;
filename=[outputfolder, 'angihsmvsangtsmi.mat'];
save(filename, 'data', 'units')
