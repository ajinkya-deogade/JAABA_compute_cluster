%compute xinflection
function [trx]=compute_xinflection_mm(trx,outputfolder)
inputfilename=fullfile(outputfolder,'inflectionpointdistance.mat');
if ~exist(inputfilename,'file')
    [trx]=inflectionpointdistance(trx,outputfolder);
end
load(inputfilename,'data')
inflectionpoint=data;

numlarvae=size(trx,2);
xinflection_mm=cell(1,numlarvae);
for i=1:numlarvae
    xinflection_mm{1,i}=zeros(1,size(trx(i).xspine_mm,2));
    for j=1:size(trx(i).xspine_mm,2)
    xinflection_mm{1,i}(j)=trx(i).xspine_mm(inflectionpoint{1,i}(j),j);
    end
end

units=struct('num','mm','den',[]);
data=xinflection_mm;
filename=fullfile(outputfolder, 'xinflection_mm.mat');
save(filename, 'data', 'units') 
