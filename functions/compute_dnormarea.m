%compute dnormarea
function [trx]=compute_dnormarea(trx,outputfolder)
inputfilename=fullfile(outputfolder,'normarea.mat');
if ~exist(inputfilename,'file')
    compute_normarea(trx,outputfolder);
end
load(fullfile(outputfolder,'normarea.mat'),'data');
normarea=data;

numlarvae=size(trx,2);
dnormarea=cell(1,numlarvae);
for i=1:numlarvae
    dnormarea{1,i}=(normarea{1,i}(2:end)-normarea{1,i}(1:end-1))./trx(i).dt;
end


units=struct('num',[],'den','s');
data=dnormarea;
filename=fullfile(outputfolder, 'dnormarea.mat');
save(filename, 'data', 'units')