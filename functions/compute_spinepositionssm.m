%compute the head and the tail based on the smooth outline
function [trx]=compute_spinepositionssm(trx,outputfolder)
inputfilename=[outputfolder,'xspinehead_mm.mat'];
if ~exist(inputfilename,'file')
    [trx]=compute_spinerelevantpositions(trx,outputfolder);
end
load([outputfolder,'xhead_mm.mat'], 'data')
xhead_mm=data;
load([outputfolder,'yhead_mm.mat'], 'data')
yhead_mm=data;


numlarvae=size(trx,2);
xheadsm=cell(1,numlarvae);
yheadsm=cell(1,numlarvae);
xtailsm=cell(1,numlarvae);
ytailsm=cell(1,numlarvae);
for i=1:numlarvae
    distheadbegin=bsxfun(@hypot,xhead_mm{1,i}-trx(i).xmaxcurvbegin_mm,yhead_mm{1,i}-trx(i).ymaxcurvbegin_mm);
    distheadend=bsxfun(@hypot,xhead_mm{1,i}-trx(i).xmaxcurvstop_mm,yhead_mm{1,i}-trx(i).ymaxcurvstop_mm);
    if sum(distheadbegin)<sum(distheadend)
        xheadsm{1,i}=trx(i).xmaxcurvbegin_mm;
        yheadsm{1,i}=trx(i).ymaxcurvbegin_mm;
        xtailsm{1,i}=trx(i).xmaxcurvstop_mm;
        ytailsm{1,i}=trx(i).ymaxcurvstop_mm;
    else
        xheadsm{1,i}=trx(i).xmaxcurvstop_mm;
        yheadsm{1,i}=trx(i).ymaxcurvstop_mm;
        xtailsm{1,i}=trx(i).xmaxcurvbegin_mm;
        ytailsm{1,i}=trx(i).ymaxcurvbegin_mm;
    end
end

units=struct('num','mm','den',[]);
filename=[outputfolder, 'xheadsm_mm.mat'];
data=xheadsm;
save(filename, 'data', 'units')

units=struct('num','mm','den',[]);
filename=[outputfolder, 'yheadsm_mm.mat'];
data=yheadsm;
save(filename, 'data', 'units')

units=struct('num','mm','den',[]);
filename=[outputfolder, 'xtailsm_mm.mat'];
data=xtailsm;
save(filename, 'data', 'units')

units=struct('num','mm','den',[]);
filename=[outputfolder, 'ytailsm_mm.mat'];
data=ytailsm;
save(filename, 'data', 'units')

        
  