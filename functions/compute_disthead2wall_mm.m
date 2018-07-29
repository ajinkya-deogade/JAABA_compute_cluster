%compute disthead2wall_mm

function [trx]=compute_disthead2wall_mm(trx,outputfolder)
inputfilename=[outputfolder,'rhead_mm.mat'];
if ~exist(inputfilename,'file')
    [trx]=compute_rhead_mm(trx,outputfolder);
end
load(inputfilename,'data')
rhead_mm=data;

numlarvae=size(trx,2);
disthead2wall_mm=cell(1,numlarvae);

for i=1:numlarvae
    disthead2wall_mm{1,i}=trx(1,i).arena.arena_radius_mm-rhead_mm{1,i};
end

units=struct('num','mm','den',[]);
filename=[outputfolder, 'disthead2wall_mm.mat'];
data=disthead2wall_mm;
save(filename, 'data', 'units')