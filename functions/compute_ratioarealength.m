%compute width
function [trx]=compute_ratioarealength(trx,outputfolder)
inputfilenamearea=fullfile(outputfolder,'area_mm.mat');
if ~exist(inputfilenamearea,'file')
    compute_area_mm(trx,outputfolder);
end
load(inputfilenamearea,'data')
area_mm=data;
inputfilenamespinelength=fullfile(outputfolder,'spinelength.mat');
if ~exist(inputfilenamespinelength,'file')
    [trx]=compute_spinelength(trx,outputfolder);
end
load(inputfilenamespinelength,'data')
spinelength=data;

numlarvae=size(trx,2);
ratioarealength=cell(1,numlarvae);
for i=1:numlarvae
    ratioarealength{1,i}=bsxfun(@rdivide,area_mm{1,i},spinelength{1,i});
end


units=struct('num','mm','den',[]);
data=ratioarealength;
filename=fullfile(outputfolder, 'ratioarealength.mat');
save(filename, 'data', 'units') 