%compute inflection point based on distance
function [trx]=inflectionpointdistance(trx,outputfolder)
inputfilename=fullfile(outputfolder,'xhead_mm.mat');
if ~exist(inputfilename,'file')
    [trx]=compute_spinerelevantpositions(trx,outputfolder);
end

load(fullfile(outputfolder,'xhead_mm.mat'),'data')
xhead_mm=data;
load(fullfile(outputfolder,'yhead_mm.mat'),'data')
yhead_mm=data;
load(fullfile(outputfolder,'xtail_mm.mat'),'data')
xtail_mm=data;
load(fullfile(outputfolder,'ytail_mm.mat'),'data')
ytail_mm=data;

numlarvae=size(trx,2);
inflectionpoint=cell(1,numlarvae);
distances=cell(1,numlarvae);
for i=1:numlarvae
    m=(yhead_mm{1,i}-ytail_mm{1,i})./(xhead_mm{1,i}-xtail_mm{1,i});
    n=(1/2)*((yhead_mm{1,i}+ytail_mm{1,i})-m.*(xhead_mm{1,i}+xtail_mm{1,i}));
    m=repmat(m,size(trx(1).xspine_mm,1),1);
    n=repmat(n,size(trx(1).xspine_mm,1),1);
    distances{1,i}=abs(m.*trx(i).xspine_mm-trx(i).yspine_mm+n)./sqrt(m.^2+1);
    [~,inflectionpoint{1,i}]=max(distances{1,i});
end

units=struct('num','units','den',[]);
data=inflectionpoint;
filename=fullfile(outputfolder, 'inflectionpointdistance.mat');
save(filename, 'data', 'units')