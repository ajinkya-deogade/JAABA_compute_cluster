%compute dcentralheadang
function [trx]=compute_dcentralheadang(trx,outputfolder)
inputfilename=fullfile(outputfolder,'centralheadang.mat');
if ~exist(inputfilename,'file')
    [trx]=compute_centralheadang(trx,outputfolder);
end
load(inputfilename, 'data')
centralheadang=data;
numlarvae=size(trx,2);
%absdtailheadang=cell(1,numlarvae);
dcentralheadang=cell(1,numlarvae);
for i=1:numlarvae
%     absdtailheadang{1,i}=real(acos(cos(tailheadang{1,i}(1:end-1)).*cos(tailheadang{1,i}(2:end))+sin(tailheadang{1,i}(1:end-1)).*sin(tailheadang{1,i}(2:end))))./trx(i).dt;
%     temp=tailheadang{1,i}-pi/2;
%     cosperp=sign(cos(temp(1:end-1)).*cos(tailheadang{1,i}(2:end))+sin(temp(1:end-1)).*sin(tailheadang{1,i}(2:end)));
%     temp2=bsxfun(@times,absdtailheadang{1,i},cosperp);
    dcentralheadang{1,i}=(mod1(centralheadang{1,i}(2:end)-centralheadang{1,i}(1:end-1),pi)-pi)./trx(i).dt;
end

units=struct('num','rad','den','s');
data=dcentralheadang;
filename=fullfile(outputfolder, 'dcentralheadang.mat');
save(filename, 'data', 'units')
% 
% data=absdtailheadang;
% filename=[outputfolder, 'absdtailhead