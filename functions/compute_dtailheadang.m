%compute dtailheadang
function [trx]=compute_dtailheadang(trx,outputfolder)
inputfilename=fullfile(outputfolder,'tailheadang.mat');
if ~exist(inputfilename,'file')
    [trx]=compute_tailheadang(trx,outputfolder);
end
load(inputfilename, 'data')
tailheadang=data;
numlarvae=size(trx,2);
%absdtailheadang=cell(1,numlarvae);
dtailheadang=cell(1,numlarvae);
for i=1:numlarvae
%     absdtailheadang{1,i}=real(acos(cos(tailheadang{1,i}(1:end-1)).*cos(tailheadang{1,i}(2:end))+sin(tailheadang{1,i}(1:end-1)).*sin(tailheadang{1,i}(2:end))))./trx(i).dt;
%     temp=tailheadang{1,i}-pi/2;
%     cosperp=sign(cos(temp(1:end-1)).*cos(tailheadang{1,i}(2:end))+sin(temp(1:end-1)).*sin(tailheadang{1,i}(2:end)));
%     temp2=bsxfun(@times,absdtailheadang{1,i},cosperp);
    dtailheadang{1,i}=(mod1(tailheadang{1,i}(2:end)-tailheadang{1,i}(1:end-1),pi)-pi)./trx(i).dt;
end

units=struct('num','rad','den','s');
data=dtailheadang;
filename=fullfile(outputfolder, 'dtailheadang.mat');
save(filename, 'data', 'units')
% 
% data=absdtailheadang;
% filename=[outputfolder, 'absdtailheadang.mat'];
% save(filename, 'data', 'units')