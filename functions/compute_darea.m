%compute darea
function [trx]=compute_darea(trx,outputfolder)
inputfilename=fullfile(outputfolder,'area_mm.mat');
if ~exist(inputfilename,'file')
    compute_area_mm(trx,outputfolder);
end
load(fullfile(outputfolder,'area_mm.mat'),'data');
area_mm=data;

numlarvae=size(trx,2);
darea=cell(1,numlarvae);
for i=1:numlarvae
    darea{1,i}=(area_mm{1,i}(2:end)-area_mm{1,i}(1:end-1))./trx(i).dt;
end


units=struct('num','mm2','den','s');
data=darea;
filename=fullfile(outputfolder, 'darea.mat');
save(filename, 'data', 'units')