%compute db_mm 
function compute_db_mm(trx,outputfolder)
inputfilename=fullfile(outputfolder,'b_mm.mat');
if ~exist(inputfilename,'file')
    compute_eccentricity(trx,outputfolder);
end
load(inputfilename, 'data')
b_mm=data;
numlarvae=size(trx,2);
db_mm=cell(1,numlarvae);
for i=1:numlarvae
    db_mm{1,i}=bsxfun(@minus,b_mm{1,i}(2:end),b_mm{1,i}(1:end-1))./trx(i).dt;
end

units=struct('num','mm','den','s');
data=db_mm;
filename=fullfile(outputfolder, 'db_mm.mat');
save(filename, 'data', 'units') 