%compute rhead_mm

function [trx]=compute_rhead_mm(trx,outputfolder)
inputfilename=[outputfolder,'xhead_mm.mat'];
if ~exist(inputfilename,'file')
    [trx]=compute_spinerelevantpositions(trx,outputfolder);
end
load(inputfilename,'data')
xhead_mm=data;

inputfilename=[outputfolder,'yhead_mm.mat'];
load(inputfilename,'data')
yhead_mm=data;

numlarvae=size(trx,2);
rhead_mm=cell(1,numlarvae);
for i=1:numlarvae
    rhead_mm{1,i}=bsxfun(@hypot,xhead_mm{1,i},yhead_mm{1,i});
end
units=struct('num','mm','den',[]);
filename=[outputfolder, 'rhead_mm.mat'];
data=rhead_mm;
save(filename, 'data', 'units')