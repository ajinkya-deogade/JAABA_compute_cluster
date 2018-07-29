%compute velmag
%calls compute_vx_cm.m and compute_vy_cm.mat
function compute_velmag_ctr(trx,outputfolder)
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
velmag=cell(size(vxcm));
for i=1:size(velmag,2);
    velmag{1,i}=bsxfun(@hypot,vxcm{1,i},vycm{1,i});
end

units=struct('num','mm','den','s');
data=velmag;
filename=fullfile(outputfolder, 'velmag_ctr.mat');
save(filename, 'data', 'units')

