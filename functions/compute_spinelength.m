%compute length of the spine 

function [trx]=compute_spinelength(trx,outputfolder)
inputfilename=fullfile(outputfolder,'tailheadang.mat');
if ~exist(inputfilename,'file')
    [trx]=compute_tailheadang(trx,outputfolder);
end
numlarvae=size(trx,2);
spinereldist=cell(1,numlarvae);
spinelength=cell(1,numlarvae);
for i=1:numlarvae
    spinereldist{1,i}=bsxfun(@hypot,trx(i).xspine_mm(1:end-1,:)-trx(i).xspine_mm(2:end,:),trx(i).yspine_mm(1:end-1,:)-trx(i).yspine_mm(2:end,:));
    spinelength{1,i}=sum(spinereldist{1,i},1);
end


units=struct('num','mm','den',[]);
data=spinelength;
filename=fullfile(outputfolder, 'spinelength.mat');
save(filename, 'data', 'units') 

units=struct('num','mm','den',[]);
data=spinereldist;
filename=fullfile(outputfolder, 'spinereldist.mat');
save(filename, 'data', 'units') 

