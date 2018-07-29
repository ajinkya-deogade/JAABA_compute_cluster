%compute area
function compute_area_mm(trx,outputfolder)
numlarvae=size(trx,2);
area_mm=cell(1,numlarvae);
for i=1:numlarvae
    area_mm{1,i}=trx(i).area_mm;
end

units=struct('num','mm2','den',[]);
data=area_mm;
filename=fullfile(outputfolder, 'area_mm.mat');
save(filename, 'data', 'units')