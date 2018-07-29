%compute dtheta
function [trx]=compute_dtheta(trx,outputfolder)
inputfilename=fullfile(outputfolder,'theta.mat');
if ~exist(inputfilename,'file')
    [trx]=compute_theta(trx,outputfolder);
end
load(inputfilename, 'data')
theta=data;
numlarvae=size(trx,2);
dtheta=cell(1,numlarvae);
for i=1:numlarvae
    dtheta{1,i}=(mod1(bsxfun(@minus,theta{1,i}(2:end),theta{1,i}(1:end-1)),pi)-pi)./trx(i).dt;
end

units=struct('num','rad','den','s');
data=dtheta;
filename=fullfile(outputfolder, 'dtheta.mat');
save(filename, 'data', 'units') 