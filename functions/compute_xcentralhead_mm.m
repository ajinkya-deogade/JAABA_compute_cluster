%compute xcentralhead_mm
function [trx]=compute_xcentralhead_mm(trx,outputfolder)

inputfilename=fullfile(outputfolder,'xcentral_mm.mat');
if ~exist(inputfilename,'file')
    [trx]=compute_spinerelevantpositions(trx,outputfolder);
end
load(fullfile(outputfolder,'xhead_mm.mat'), 'data')
xhead_mm=data;
load(fullfile(outputfolder,'xcentral_mm.mat'), 'data')
xcentral_mm=data;

numlarvae=size(trx,2);
xcentralhead_mm=cell(1,numlarvae);

for i=1:numlarvae
    xcentralhead_mm{1,i}=xhead_mm{1,i}-xcentral_mm{1,i};
end
units=struct('num','mm','den',[]);
data=xcentralhead_mm;
filename=fullfile(outputfolder, 'xcentralhead_mm.mat');
save(filename, 'data', 'units')