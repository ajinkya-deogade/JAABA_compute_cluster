%compute normalization of the spinelength by the mean spinelength size in the whole video
function [trx]=compute_normlength(trx,outputfolder)
inputfilename=fullfile(outputfolder,'spinelength.mat');
if ~exist(inputfilename,'file')
    [trx]=compute_spinelength(trx,outputfolder);
end
load(fullfile(outputfolder,'spinelength.mat'),'data');
spinelength=data;

numlarvae=size(trx,2);
meanlength=zeros(1,numlarvae);
numelements=zeros(1,numlarvae);
for i=1:numlarvae
    meanlength(i)=mean(spinelength{1,i});
    numelements(i)=numel(spinelength{1,i});
end
normvalue=sum(meanlength.*numelements./(sum(numelements)));
normlength=cell(1,numlarvae);
for i=1:numlarvae
    normlength{1,i}=spinelength{1,i}./normvalue;
end

units=struct('num',[],'den',[]);
data=normlength;
filename=fullfile(outputfolder, 'normlength.mat');
save(filename, 'data', 'units')