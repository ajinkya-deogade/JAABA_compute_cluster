%compute the orientation of the spine edges
function [trx]=spineangle(trx,outputfolder)
inputfilename=fullfile(outputfolder,'tailheadang.mat');
if ~exist(inputfilename,'file')
    [trx]=compute_tailheadang(trx,outputfolder);
end
numlarvae=size(trx,2);
spineangles=cell(1,numlarvae);
for i=1:numlarvae
    spineangles{1,i}=bsxfun(@atan2,trx(i).yspine(1:end-1,:)-trx(i).yspine(2:end,:),trx(i).xspine(1:end-1,:)-trx(i).xspine(2:end,:));
end
units=struct('num','rad','den',[]);
data=spineangles;
filename=fullfile(outputfolder, 'spineangles.mat');
save(filename, 'data', 'units') 


