%compute orientation of centralhead vector

function [trx]=compute_centralheadang(trx,outputfolder)

inputfilename=fullfile(outputfolder,'xhead_mm.mat');
if ~exist(inputfilename,'file')
    [trx]=compute_spinerelevantpositions(trx,outputfolder);
end
load(fullfile(outputfolder,'xhead_mm.mat'), 'data')
xhead_mm=data;
load(fullfile(outputfolder,'xcentral_mm.mat'), 'data')
xcentral_mm=data;
load(fullfile(outputfolder,'yhead_mm.mat'), 'data')
yhead_mm=data;
load(fullfile(outputfolder,'ycentral_mm.mat'), 'data')
ycentral_mm=data;


centralheadang=cell(size(xhead_mm));

for i=1:size(xhead_mm,2)
    centralheadang{1,i}=bsxfun(@atan2,yhead_mm{1,i}-ycentral_mm{1,i},xhead_mm{1,i}-xcentral_mm{1,i});
end

units=struct('num','rad','den',[]);
data=centralheadang;
filename=fullfile(outputfolder, 'centralheadang.mat');
save(filename, 'data', 'units')