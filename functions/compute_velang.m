%compute velang
function compute_velang(trx,outputfolder)
inputfilenamex=fullfile(outputfolder,'vx_cm.mat');
if ~exist(inputfilenamex,'file')
    compute_vx_cm(trx,outputfolder);
end
load(inputfilenamex, 'data')
vxcm=data;
inputfilenamey=fullfile(outputfolder,'vy_cm.mat');
if ~exist(inputfilenamey,'file')
    compute_vy_cm(trx,outputfolder);
end
load(inputfilenamey, 'data')
vycm=data;
velang=cell(size(vxcm));
for i=1:size(velang,2);
    velang{1,i}=bsxfun(@atan2,vycm{1,i},vxcm{1,i});
end

units=struct('num','rad','den','s');
data=velang;
filename=fullfile(outputfolder, 'velang.mat');
save(filename, 'data', 'units')
