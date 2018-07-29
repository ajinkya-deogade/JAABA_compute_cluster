%compute dtailcentralang
function [trx]=compute_dtailcentralang(trx,outputfolder)
inputfilename=fullfile(outputfolder,'tailcentralang.mat');
if ~exist(inputfilename,'file')
    [trx]=compute_tailcentralang(trx,outputfolder);
end
load(inputfilename, 'data')
tailcentralang=data;
numlarvae=size(trx,2);
%absdtailheadang=cell(1,numlarvae);
dtailcentralang=cell(1,numlarvae);
for i=1:numlarvae
%     absdtailheadang{1,i}=real(acos(cos(tailheadang{1,i}(1:end-1)).*cos(tailheadang{1,i}(2:end))+sin(tailheadang{1,i}(1:end-1)).*sin(tailheadang{1,i}(2:end))))./trx(i).dt;
%     temp=tailheadang{1,i}-pi/2;
%     cosperp=sign(cos(temp(1:end-1)).*cos(tailheadang{1,i}(2:end))+sin(temp(1:end-1)).*sin(tailheadang{1,i}(2:end)));
%     temp2=bsxfun(@times,absdtailheadang{1,i},cosperp);
    dtailcentralang{1,i}=(mod1(tailcentralang{1,i}(2:end)-tailcentralang{1,i}(1:end-1),pi)-pi)./trx(i).dt;
end

units=struct('num','rad','den','s');
data=dtailcentralang;
filename=fullfile(outputfolder, 'dtailcentralang.mat');
save(filename, 'data', 'units')
% 
% data=absdtailheadang;
% filename=[outputfolder, 'absdtailhead