%compute dxinflection
function[trx]=compute_dxinflection_mm(trx,outputfolder)
inputfilename=fullfile(outputfolder,'inflectionpointdistance.mat');
if ~exist(inputfilename,'file')
    [trx]=inflectionpointdistance(trx,outputfolder);
end
load(inputfilename,'data')
inflectionpoint=data;
numlarvae=size(trx,2);
dxinflection_mm=cell(1,numlarvae);
for i=1:numlarvae
    dxinflection_mm{1,i}=zeros(1,size(trx(i).xspine_mm,2));
    for j=1:size(trx(i).xspine_mm,2)-1
    dxinflection_mm{1,i}(j)=(trx(i).xspine_mm(inflectionpoint{1,i}(j),j+1)-trx(i).xspine_mm(inflectionpoint{1,i}(j),j))./trx(i).dt(j);
    end
end

units=struct('num','mm','den',[]);
data=dxinflection_mm;
filename=fullfile(outputfolder, 'dxinflection_mm.mat');
save(filename, 'data', 'units') 
