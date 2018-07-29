%compute dnorlength
function [trx]=compute_dnormlength(trx,outputfolder)
inputfilename=fullfile(outputfolder,'normlength.mat');
if ~exist(inputfilename,'file')
    [trx]=compute_normlength(trx,outputfolder);
end
load(fullfile(outputfolder,'normlength.mat'),'data');
normlength=data;

numlarvae=size(trx,2);
dnormlength=cell(1,numlarvae);
for i=1:numlarvae
    dnormlength{1,i}=(normlength{1,i}(2:end)-normlength{1,i}(1:end-1))./trx(i).dt;
end


units=struct('num',[],'den','s');
data=dnormlength;
filename=fullfile(outputfolder, 'dnormlength.mat');
save(filename, 'data', 'units')