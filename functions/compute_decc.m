%compute decc 
function compute_decc(trx,outputfolder)
inputfilename=fullfile(outputfolder,'ecc.mat');
if ~exist(inputfilename,'file')
    compute_eccentricity(trx,outputfolder);
end
load(inputfilename, 'data')
ecc=data;
numlarvae=size(trx,2);
decc=cell(1,numlarvae);
for i=1:numlarvae
    decc{1,i}=bsxfun(@minus,ecc{1,i}(2:end),ecc{1,i}(1:end-1))./trx(i).dt;
end

units=struct('num','mm','den','s');
data=decc;
filename=fullfile(outputfolder, 'decc.mat');
save(filename, 'data', 'units') 