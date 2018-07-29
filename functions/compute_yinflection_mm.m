%compute yinflection
function [trx]=compute_yinflection_mm(trx,outputfolder)
inputfilename=fullfile(outputfolder,'inflectionpointdistance.mat');
if ~exist(inputfilename,'file')
    [trx]=inflectionpointdistance(trx,outputfolder);
end
load(inputfilename,'data')
inflectionpoint=data;

numlarvae=size(trx,2);
yinflection_mm=cell(1,numlarvae);
for i=1:numlarvae
     yinflection_mm{1,i}=zeros(1,size(trx(i).yspine_mm,2));
    for j=1:size(trx(i).xspine_mm,2)
    yinflection_mm{1,i}(j)=trx(i).yspine_mm(inflectionpoint{1,i}(j),j);
    end
end

units=struct('num','mm','den',[]);
data=yinflection_mm;
filename=fullfile(outputfolder, 'yinflection_mm.mat');
save(filename, 'data', 'units') 
