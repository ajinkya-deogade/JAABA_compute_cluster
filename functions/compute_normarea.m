%compute normalization of the area by the mean area size in the whole video
function [trx]=compute_normarea(trx,outputfolder)
inputfilename=fullfile(outputfolder,'area_mm.mat');
if ~exist(inputfilename,'file')
    compute_area(trx,outputfolder);
end
load(fullfile(outputfolder,'area_mm.mat'),'data');
area=data;

numlarvae=size(trx,2);
meanarea=zeros(1,numlarvae);
numelements=zeros(1,numlarvae);
for i=1:numlarvae
    meanarea(i)=mean(area{1,i});
    numelements(i)=numel(area{1,i});
end
normvalue=sum(meanarea.*numelements./(sum(numelements)));
normarea=cell(1,numlarvae);
for i=1:numlarvae
    normarea{1,i}=area{1,i}./normvalue;
end

units=struct('num',[],'den',[]);
data=normarea;
filename=fullfile(outputfolder, 'normarea.mat');
save(filename, 'data', 'units')