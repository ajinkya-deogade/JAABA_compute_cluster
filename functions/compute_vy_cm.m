%compute vy_cm
function compute_vy_cm(trx,outputfolder)

numlarvae=size(trx,2);
vycm=cell(1,numlarvae);
dt=cell(1,numlarvae);
inputfilename=fullfile(outputfolder,'y_mm.mat');
if ~exist(inputfilename,'file')
    compute_y_mm(trx,outputfolder);
end
load(inputfilename, 'data')
ycm=data;
for i=1:numlarvae
    dt{1,i}=trx(i).dt;
    vycm{1,i}=(ycm{1,i}(2:end)-ycm{1,i}(1:end-1))./dt{1,i};
end

units=struct('num','mm','den','s');
data=vycm;
filename=fullfile(outputfolder, 'vy_cm.mat');
save(filename, 'data', 'units')