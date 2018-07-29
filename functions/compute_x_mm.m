%compute x_mm
function compute_x_mm(trx,outputfolder)
numlarvae=size(trx,2);
xmm=cell(1,numlarvae);
for i=1:numlarvae
    xmm{1,i}=trx(i).x_mm;
end
units=struct('num','mm','den',[]);
data=xmm;
filename=fullfile(outputfolder, 'x_mm.mat');
save(filename, 'data', 'units')
