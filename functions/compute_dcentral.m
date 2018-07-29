%compute distance to closest larva using central to central metric

function [trx]=compute_dcentral(trx,outputfolder)

inputfilename=[outputfolder,'xcentral_mm.mat'];
if ~exist(inputfilename,'file')
    [trx]=compute_spinerelevantpositions(trx,outputfolder);
end
load(inputfilename, 'data')
xcentral_mm=data;

inputfilename=[outputfolder,'ycentral_mm.mat'];
load(inputfilename, 'data')
ycentral_mm=data;

numlarvae=size(trx,2);
dcentral=cell(1,numlarvae);
closestlarva=cell(1,numlarvae);


for i1 = 1:numlarvae,
  dcentraltemp = inf(numlarvae,trx(i1).nframes);
  for i2 = 1:numlarvae,
    if i1 == i2,
      continue;
    end
    dcentraltemp(i2,:) = dcentral_pair(trx,i1,i2,xcentral_mm{1,i1},ycentral_mm{1,i1},xcentral_mm{1,i2},ycentral_mm{1,i2});
  end
  [dcentral{i1},closesti] = min(dcentraltemp,[],1);
  closestlarva{i1} = closesti;
  closestlarva{i1}(isnan(dcentral{i1})) = nan;
end


units=struct('num','mm','den',[]);
data=dcentral;
filename=[outputfolder, 'dcentral.mat'];
save(filename, 'data', 'units')