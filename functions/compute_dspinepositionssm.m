%compute dspinepositions from smooth outline

function [trx]=compute_dspinepositionssm(trx,outputfolder)
inputfilename=[outputfolder,'xheadsm_mm.mat'];
if ~exist(inputfilename,'file')
    [trx]=compute_spinepositionssm(trx,outputfolder);
end
load([outputfolder,'xheadsm_mm.mat'],'data');
xheadsm_mm=data;
load([outputfolder,'xtailsm_mm.mat'],'data');
xtailsm_mm=data;

load([outputfolder,'yheadsm_mm.mat'],'data');
yheadsm_mm=data;
load([outputfolder,'ytailsm_mm.mat'],'data');
ytailsm_mm=data;

numlarvae=size(trx,2);
dxheadsm_mm=cell(1,numlarvae);
dxtailsm_mm=cell(1,numlarvae);
dyheadsm_mm=cell(1,numlarvae);
dytailsm_mm=cell(1,numlarvae);
for i=1:numlarvae
    dxheadsm_mm{1,i}=(xheadsm_mm{1,i}(2:end)-xheadsm_mm{1,i}(1:end-1))./trx(i).dt;
    dxtailsm_mm{1,i}=(xtailsm_mm{1,i}(2:end)-xtailsm_mm{1,i}(1:end-1))./trx(i).dt;
    dyheadsm_mm{1,i}=(yheadsm_mm{1,i}(2:end)-yheadsm_mm{1,i}(1:end-1))./trx(i).dt;    
    dytailsm_mm{1,i}=(ytailsm_mm{1,i}(2:end)-ytailsm_mm{1,i}(1:end-1))./trx(i).dt;
end


units=struct('num','mm','den','s');

data=dxheadsm_mm;
filename=[outputfolder, 'dxheadsm_mm.mat'];
save(filename, 'data', 'units')
data=dxtailsm_mm;
filename=[outputfolder, 'dxtailsm_mm.mat'];
save(filename, 'data', 'units')
data=dyheadsm_mm;
filename=[outputfolder, 'dyheadsm_mm.mat'];
save(filename, 'data', 'units')
data=dytailsm_mm;
filename=[outputfolder, 'dytailsm_mm.mat'];
save(filename, 'data', 'units')