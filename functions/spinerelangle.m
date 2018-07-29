%compute the relative orientation of consecutive spine edges
function [trx]=spinerelangle(trx,outputfolder)
inputfilename=fullfile(outputfolder,'spineangles.mat');
if ~exist(inputfilename,'file')
    [trx]=spineangle(trx,outputfolder);
end
load(inputfilename,'data')
spineangles=data;
numlarvae=size(trx,2);
spinerelangle=cell(1,numlarvae);
for i=1:numlarvae
    spinerelangle{1,i}=bsxfun(@atan2,sin(spineangles{1,i}(2:end,:))-sin(spineangles{1,i}(1:end-1,:)),cos(spineangles{1,i}(2:end,:))-cos(spineangles{1,i}(1:end-1,:)));

end
units=struct('num','rad','den',[]);
data=spinerelangle;
filename=fullfile(outputfolder, 'spinerelangle.mat');
save(filename, 'data', 'units') 

