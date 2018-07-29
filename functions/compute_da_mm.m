%compute da_mm 
function compute_da_mm(trx,outputfolder)
inputfilename=fullfile(outputfolder,'a_mm.mat');
if ~exist(inputfilename,'file')
    compute_eccentricity(trx,outputfolder);
end
load(inputfilename, 'data')
a_mm=data;
numlarvae=size(trx,2);
da_mm=cell(1,numlarvae);
for i=1:numlarvae
    da_mm{1,i}=bsxfun(@minus,a_mm{1,i}(2:end),a_mm{1,i}(1:end-1))./trx(i).dt;
end

units=struct('num','mm','den','s');
data=da_mm;
filename=fullfile(outputfolder, 'da_mm.mat');
save(filename, 'data', 'units') 