%compute vx_cm
function compute_vx_cm(trx,outputfolder)

numlarvae=size(trx,2);
vxcm=cell(1,numlarvae);
dt=cell(1,numlarvae);
inputfilename=fullfile(outputfolder,'x_mm.mat');
if ~exist(inputfilename,'file')
    compute_x_mm(trx,outputfolder);
end
load(inputfilename, 'data')
xcm=data;
for i=1:numlarvae
    dt{1,i}=trx(i).dt;
    vxcm{1,i}=(xcm{1,i}(2:end)-xcm{1,i}(1:end-1))./dt{1,i};
end

units=struct('num','mm','den','s');
data=vxcm;
filename=fullfile(outputfolder, 'vx_cm.mat');
save(filename, 'data', 'units')

