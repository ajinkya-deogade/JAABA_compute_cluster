%compute ang between vector tailcentral and vector centralhead

function [trx]=compute_angchvsangtc(trx,outputfolder)
inputfilenametc=fullfile(outputfolder,'tailcentralang.mat');
if ~exist(inputfilenametc,'file')
    [trx]=compute_tailcentralang(trx,outputfolder);
end
load(inputfilenametc,'data')
tailcentralang=data;
inputfilenamech=fullfile(outputfolder,'centralheadang.mat');
if ~exist(inputfilenamech,'file')
    [trx]=compute_centralheadang(trx,outputfolder);
end
load(inputfilenamech,'data')
centralheadang=data;

numlarvae=size(trx,2);
angchvsangtc=cell(1,numlarvae);
absangchvsangtc=cell(1,numlarvae);
for i=1:numlarvae
    absangchvsangtc{1,i}=real(acos(cos(tailcentralang{1,i}).*cos(centralheadang{1,i})+sin(tailcentralang{1,i}).*sin(centralheadang{1,i})));
    temp=tailcentralang{1,i}-pi/2;
    cosperp=sign(cos(temp).*cos(centralheadang{1,i})+sin(temp).*sin(centralheadang{1,i}));
    angchvsangtc{1,i}=bsxfun(@times,absangchvsangtc{1,i},cosperp);
end

units=struct('num','rad','den',[]);
data=absangchvsangtc;
filename=fullfile(outputfolder, 'absangchvsangtc.mat');
save(filename, 'data', 'units')

units=struct('num','rad','den',[]);
data=angchvsangtc;
filename=fullfile(outputfolder, 'angchvsangtc.mat');
save(filename, 'data', 'units')
