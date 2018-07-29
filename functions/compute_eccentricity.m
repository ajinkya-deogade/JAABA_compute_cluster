%compute eccentricty 
function compute_eccentricity(trx,outputfolder)
numlarvae=size(trx,2);
a_mm=cell(1,numlarvae);
b_mm=cell(1,numlarvae);
ecc=cell(1,numlarvae);

for i=1:numlarvae
    a_mm{1,i}=trx(i).a_mm;
    b_mm{1,i}=trx(i).b_mm;
    ecc{1,i}=sqrt(1-(((2*trx(i).b_mm).^2)./((2*trx(i).a_mm).^2)));
end

units=struct('num','mm','den',[]);
data=a_mm;
filename=fullfile(outputfolder, 'a_mm.mat');
save(filename, 'data', 'units') 

units=struct('num','mm','den',[]);
data=b_mm;
filename=fullfile(outputfolder, 'b_mm.mat');
save(filename, 'data', 'units') 

units=struct('num','mm','den',[]);
data=ecc;
filename=fullfile(outputfolder, 'ecc.mat');
save(filename, 'data', 'units') 
