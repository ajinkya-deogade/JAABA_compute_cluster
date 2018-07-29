%compute y_mm
function compute_y_mm(trx,outputfolder)
numlarvae=size(trx,2);
ymm=cell(1,numlarvae);
for i=1:numlarvae
    ymm{1,i}=trx(i).y_mm;
end
units=struct('num','mm','den',[]);
data=ymm;
filename=fullfile(outputfolder, 'y_mm.mat');
save(filename, 'data', 'units')