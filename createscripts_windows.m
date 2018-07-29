clear all
curdirCluster = '/groups/visitors/home/deogadea/';
% compiledJaabaForCluster/
curdir_windows = 'W:\commands\';
% Path to the compiled script
SCRIPT = [curdirCluster, 'compiledJaabaForCluster/for_testing/run_jaabaClassifier.sh'];
% esto no es importante para ti, es el path a mis archivos de parametros
%tmpdatafile = [curdir,'/mouse/epxlists/params_M130.txt'];
% Ni idea de que es esto, pero va dentro del shellscript
TMP_ROOT_DIR = '/scratch/deogadea/';
MCR_CACHE_ROOT = [TMP_ROOT_DIR, 'mcr_cache_root'];
% MRC path
% MCR = '/usr/local/matlab-2013b/';
MCR = '/groups/branson/home/riveraalbam/MATLAB/R013b/';
% temp dir for scripts
tmpdir_cluster = [curdirCluster, 'temp/scripts/'];
% tmpdir_windows = tmpdir_cluster;
tmpdir_windows = [curdir_windows, 'temp\scripts'];
n_c = 1; %number of cores per job

%%%% General la lista de videos que quiero leer: En mi caso es un poco
% complicado, pero al final lo que necesitas es tener 'moviefiles_all',
% un cell array con tantos cells como videos quieras leer. Bastaria con
% que tengas la lista de videos en un txt y lo leas.
% [file,folder]=uigetfile('*.txt');
% expfile=fullfile(folder,file);
%
% fid = fopen(expfile,'r');
% %[expdirs_all,moviefiles_all,labeledpos]=read_exp_list_labeled(fid,dotest);
% %[~,moviefiles_all]=read_exp_list_NONlabeled(fid);
% moviefiles_all = {1;2;3;4;5;6;7;8;9;10};%{'a/b/c/1.avi';'/a/b/c/2.avi'};
%%%%
% expfile = ;
% [file, folder] = uigetfile('*.txt');
experimentFolder = 'W:\data\20151116and20151120_WhereToTurn_DiscreteSampling_Combined\';
[fileListFileNameXML, fileListFileNameCSV] = makeFileList_cluster(experimentFolder);
inputFilesXML = {};
fid = fopen(fileListFileNameXML, 'r');
% allFiles_xml = arrayfun(@(filename) strrep(filename, '\', '/'), allFiles_xml);
inputFilesXML{end+1} = strrep(strrep(fgets(fid), '\', '/'),'W:/', curdirCluster);
while ischar(inputFilesXML{end})
    %     disp(tline)
    inputFilesXML{end+1} = strrep(strrep(fgets(fid), '\', '/'),'W:/', curdirCluster);
end
inputFilesXML = inputFilesXML(1:end-1);
fclose(fid);

inputFilesCSV = {};
fid = fopen(fileListFileNameCSV, 'r');
inputFilesCSV{end+1} = strrep(strrep(fgets(fid), '\', '/'),'W:/', curdirCluster);
while ischar(inputFilesCSV{end})
    %     disp(tline)
    inputFilesCSV{end+1} = strrep(strrep(fgets(fid), '\', '/'),'W:/', curdirCluster);
end
inputFilesCSV = inputFilesCSV(1:end-1);
fclose(fid);

formatOut = 'yyyy/mm/dd';
dat = datestr(clock,formatOut);
dateName =  strrep(strrep(strrep(dat,'/',''),':',''),' ','_');
outputFolderCluster  = strcat(curdir_windows, 'output/', dateName, '/');

if exist(outputFolderCluster) ~= 7
    mkdir(outputFolderCluster);
end

% %%%%%%%%%%%%%%%% moviefile = [curdir, 'jaabaCluster', file];
lab=1;
flag_landscape =1;
classifierfile = strcat(curdirCluster, 'classifiers/', '20150730_turning_past.jab');
nbatches=1;
%nbatches=numel(moviefile); % Number of videos to analyze
%%
outfiles = cell(nbatches,1); % Log files, one per video
cmdchmod = cell(nbatches,1); % Tengo que cambiar los permisos de los
% shellscripts para poder ejecutarlos. Normalmente, eso se puede hacer
% desde matlab usando >> unix(cmdchmod), pero a mi no me funciona, asi que
% lo que hago es guardar cada uno de los comandos para cambiar los permisos
% a cada shellscript, luego los copio y lo spego en el terminal
cmd = cell(nbatches,1); % cell array with qsub commands

%This loop creates one script per each job to be send to the cluster
for batchi=1:nbatches
    %     moviefile = moviefile;%{batchi}; % Current movie file
    timestamp = datestr(now,'yyyymmddTHHMMSS');
    jobid = sprintf('pv%s_%03d',timestamp,batchi); % KB format
    outfiles{batchi} = [tmpdir_cluster, 'log_', jobid,'.txt']; % KB format
    scriptfile = [tmpdir_cluster, jobid,'.sh']; % path of script to be created
    scriptfile_windows = fullfile(tmpdir_windows, [jobid,'.sh']); % path of script to be created
    debug = 0;
    
    %%% Creates the scriptfile
    fid = fopen(scriptfile_windows, 'w');
    fprintf(fid,'if [ -d %s ]\n', TMP_ROOT_DIR);
    fprintf(fid,'  then export MCR_CACHE_ROOT=%s.%s \n', MCR_CACHE_ROOT, jobid);
    fprintf(fid,'fi \n');
    fprintf(fid,'%s %s %s %s %d %s %d \n', SCRIPT, MCR, inputFilesXML{batchi}, inputFilesCSV{batchi}, outputFolderCluster, lab, classifierfile, flag_landscape);
    display(sprintf('%s %s %s %s %d %s %d \n', SCRIPT, MCR, inputFilesXML{batchi}, inputFilesCSV{batchi}, outputFolderCluster, lab, classifierfile, flag_landscape))
   
    %   fprintf(fid,'%s %s %05d \n',...
    %       SCRIPT,MCR,batchi);
    fclose(fid);
    %%%
    
    %%% create the command to change permissions
    cmdchmod{batchi} = (sprintf('chmod u+x %s', scriptfile));
    % changes permissions
    [tmp1,tmp2] = unix(cmdchmod{batchi});
    %%%
    
    %%% Creates each qsub command
    % MultiThreaded
    %     cmd{batchi} = sprintf('qsub -pe batch %d -N %s -j y -b y -l short=false -o %s -cwd %s',n_c,jobid,outfiles{batchi},scriptfile);
    % Single Threaded
    %     cmd{batchi} = sprintf('qsub -N %s -j y -b y -o %s -cwd %s', jobid, outfiles{batchi}, scriptfile);
    cmd{batchi} = sprintf('qsub -N %s -j y -b y -l short=true -o %s -cwd %s', jobid, outfiles{batchi}, scriptfile);
    qsubcommandsfile = fullfile(tmpdir_windows, 'qsubcommands.txt');
    fid2=fopen(qsubcommandsfile,'w');
    fprintf(fid2,'%s \n',cmd{batchi});
    fclose(fid2);
    % Si quieres ejecutarlos directamente desde aqui (no te lo recomiendo,
    % por mas elegante que sea) usa:
    % cmd{batchi} = sprintf('ssh login1 ''source /etc/profile; cd %s; qsub -N %s -j y -b y -l short=true -o %s -cwd %s',...
    % curdir,jobid,outfiles{batchi},scriptfile);
    % [tmp1,tmp2] = unix(cmd);
    % if tmp1 ~= 0,
    %   error('Error submitting job %d:\n%s ->\n%s\n',batchi,cmd,tmp2);
    % end
    % m = regexp(tmp2,'job (\d+) ','once','tokens');
    % jobids = [jobids,str2double(m)]; %#ok<AGROW>
end

% qsubcommandsfile=fullfile(tmpdir, 'qsubcommands.txt');
qsubcommandsfile = fullfile(tmpdir_windows, 'qsubcommands.txt');
fid2=fopen(qsubcommandsfile,'w');

for i=1:nbatches
    fprintf(fid2,'%s \n',cmd{i});
end
fclose(fid2);