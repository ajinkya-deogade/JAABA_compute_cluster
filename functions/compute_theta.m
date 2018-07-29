%compute theta and correct theta in trx if necessary
function [trx]=compute_theta(trx,outputfolder)
inputfilename=fullfile(outputfolder,'velang.mat');
if ~exist(inputfilename,'file')
    compute_velang(trx,outputfolder);
end
load(inputfilename, 'data')
velang=data;
numlarvae=size(trx,2);
theta=cell(1,numlarvae);
for i=1:numlarvae
    for j=2:size(trx(i).theta,2)
    orientpairs=cos(trx(i).theta(j)).*cos(trx(i).theta(j-1))+sin(trx(i).theta(j)).*sin(trx(i).theta(j-1));
    if orientpairs<0
    trx(i).theta(j)=trx(i).theta(j)+pi;
    end
    end
 
    orient=cos(velang{1,i}).*cos(trx(i).theta(1:end-1))+sin(velang{1,i}).*sin(trx(i).theta(1:end-1));
    orient=sum(orient(~isnan(orient)));
    if orient<0
        theta{1,i}=trx(i).theta+pi;
    else 
       theta{1,i}=trx(i).theta;
    end
    theta{1,i}=mod1(theta{1,i},pi)-pi;
end
units=struct('num','rad','den',[]);
data=theta;
filename=fullfile(outputfolder, 'theta.mat');
save(filename, 'data', 'units') 
