%compute dyinflection
function[trx]=compute_dyinflection_mm(trx,outputfolder)
inputfilename=fullfile(outputfolder,'inflectionpointdistance.mat');
if ~exist(inputfilename,'file')
    [trx]=inflectionpointdistance(trx,outputfolder);
end
load(inputfilename,'data')
inflectionpoint=data;
numlarvae=size(trx,2);
dyinflection_mm=cell(1,numlarvae);
for i=1:numlarvae
    dyinflection_mm{1,i}=zeros(1,size(trx(i).yspine_mm,2));
    for j=1:size(trx(i).yspine_mm,2)-1
    dyinflection_mm{1,i}(j)=(trx(i).yspine_mm(inflectionpoint{1,i}(j),j+1)-trx(i).yspine_mm(inflectionpoint{1,i}(j),j))./trx(i).dt(j);
    end
end

units=struct('num','mm','den','s');
data=dyinflection_mm;
filename=fullfile(outputfolder, 'dyinflection_mm.mat');
save(filename, 'data', 'units') 
