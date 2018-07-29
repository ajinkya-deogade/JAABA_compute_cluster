%compute distance to closest larva using central to central metric

function [trx]=compute_dhead2central(trx,outputfolder)

inputfilename=[outputfolder,'xcentral_mm.mat'];
if ~exist(inputfilename,'file')
    [trx]=compute_spinerelevantpositions(trx,outputfolder);
end
load(inputfilename, 'data')
xcentral_mm=data;

inputfilename=[outputfolder,'ycentral_mm.mat'];
load(inputfilename, 'data')
ycentral_mm=data;

inputfilename=[outputfolder,'xhead_mm.mat'];
load(inputfilename, 'data')
xhead_mm=data;

inputfilename=[outputfolder,'yhead_mm.mat'];
load(inputfilename, 'data')
yhead_mm=data;

numlarvae=size(trx,2);
dhead2central=cell(1,numlarvae);
closestlarva=cell(1,numlarvae);


for i1 = 1:numlarvae,
  dcentraltemp = inf(numlarvae,trx(i1).nframes);
  for i2 = 1:numlarvae,
    if i1 == i2,
      continue;
    end
    dcentraltemp(i2,:) = dcentral_pair(trx,i1,i2,xcentral_mm{1,i1},ycentral_mm{1,i1},xhead_mm{1,i2},yhead_mm{1,i2});
  end
  [dhead2central{i1},closesti] = min(dcentraltemp,[],1);
  closestlarva{i1} = closesti;
  closestlarva{i1}(isnan(dhead2central{i1})) = nan;
end


units=struct('num','mm','den',[]);
data=dhead2central;
filename=[outputfolder, 'dhead2central.mat'];
save(filename, 'data', 'units')