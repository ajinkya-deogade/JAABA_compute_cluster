%compute darea
function [trx]=compute_dratioarealength(trx,outputfolder)
inputfilename=fullfile(outputfolder,'ratioarealength.mat');
if ~exist(inputfilename,'file')
    [trx]=compute_ratioarealength(trx,outputfolder);
end
load(fullfile(outputfolder,'ratioarealength.mat'),'data');
ratioarealength=data;

numlarvae=size(trx,2);
dratioarealength=cell(1,numlarvae);
for i=1:numlarvae
    dratioarealength{1,i}=(ratioarealength{1,i}(2:end)-ratioarealength{1,i}(1:end-1))./trx(i).dt;
end


units=struct('num','mm','den','s');
data=dratioarealength;
filename=fullfile(outputfolder, 'dratioarealength.mat');
save(filename, 'data', 'units')