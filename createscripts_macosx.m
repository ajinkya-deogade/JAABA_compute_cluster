curdir = '/groups/branson/home/riveraalbam/Desktop/experiments/tracker';
%output folder
outdir='/groups/branson/home/riveraalbam/Desktop/experiments';
% Path completo al script de matlab compilado
SCRIPT = [curdir,'/analysisforexperiments/for_testing/run_analysisforexperiments.sh']; 
% esto no es importante para ti, es el path a mis archivos de parametros
%tmpdatafile = [curdir,'/mouse/epxlists/params_M130.txt'];
% Ni idea de que es esto, pero va dentro del shellscript
TMP_ROOT_DIR = '/scratch/riveraalbam';
MCR_CACHE_ROOT = fullfile(TMP_ROOT_DIR,'mcr_cache_root');
% Path al MCR de matlab, supongo que el tuyo estara en un sitio parecido
MCR = '/groups/branson/home/riveraalbam/MATLAB/R013b/';  
% Este es el directorio temporal donde cuardo mis shellscripts
tmpdir = [curdir,'/temp/scripts'];

debug=0;

n_c = 1; % Numero de cores por trabajo, en mi caso solo usaba uno por video, 
% porque notengo paralelizado el script

%%%% General la lista de videos que quiero leer: En mi caso es un poco
% complicado, pero al final lo que necesitas es tener 'moviefiles_all',
% un cell array con tantos cells como videos quieras leer. Bastaria con
% que tengas la lista de videos en un txt y lo leas.
load('/groups/branson/home/riveraalbam/Desktop/experiments/torun.mat')


nbatches=numel(inputfiles); % Numero de videos que quieres mandar
%%
outfiles = cell(nbatches,1); % Log files, uno por video
cmdchmod = cell(nbatches,1); % Tengo que cambiar los permisos de los 
% shellscripts para poder ejecutarlos. Normalmente, eso se puede hacer
% desde matlab usando >> unix(cmdchmod), pero a mi no me funciona, asi que
% lo que hago es guardar cada uno de los comandos para cambiar los permisos
% a cada shellscript, luego los copio y lo spego en el terminal
cmd = cell(nbatches,1); % Luego voy a tener que a ejecutar cada shellscript
% al cluseter (con qsub), para no escribir a mano cada comando, los escribo
% con matlab, los guardo en este cell array y luego los copio y los pego.
% Al copiarlos, slaen con comillas ('cmd ...') asi que yo los pego en un
% editor de texto, bucos las ', las reemplazo por nada y las vuelvo a
% copiar (podria haberlo hecho para que me escribiese todos los comandos en
% un archivo de texto, pero soy vago).

% En este loop, para cada video, creo un shellscript con las ordenes
% necesarias, un comando para cambiar permisos (cmdchmod) y un comando para
% mandar el trabajo al cluseter (cmd)
for batchi=1:nbatches
    moviefile = inputfiles{batchi}; % Current movie file
 
    timestamp = datestr(now,'yyyymmddTHHMMSS');
    jobid = sprintf('pv%s_%03d',timestamp,batchi); % Kristin's format
    outfiles{batchi} = fullfile(tmpdir,['log_',jobid,'.txt']); % Este tambien
    scriptfile = fullfile(tmpdir,[jobid,'.sh']); % Nombre (path completeo, 
    % que se guarda en 'temp') de cada shellscript que voy a crear
    
    %%%Create the file with the necessary preallocations for the cluster
    fid = fopen(scriptfile,'w'); 
    fprintf(fid,'if [ -d %s ]\n',TMP_ROOT_DIR);
    fprintf(fid,'  then export MCR_CACHE_ROOT=%s.%s\n',MCR_CACHE_ROOT,jobid);
    fprintf(fid,'fi\n');
%     fprintf(fid,'%s %s %05d %s %s\n',...
%       SCRIPT,MCR,batchi,moviefile,tmpdatafile);
  fprintf(fid,'%s %s "%s" "%s" %d \n',...
      SCRIPT,MCR,moviefile,outputfolders{batchi},debug);
    fclose(fid);
    %%%
    
    %%% Creear cada comando para cambiar los permisos, que luego yo copio
    cmdchmod{batchi} = (sprintf('chmod u+x %s',scriptfile));
    % Si quieres ejecutarlo directamente desde matlab usa:
    [tmp1,tmp2] = unix(cmdchmod{batchi});
    %%%
    
    %%% Crear cada comando para mandar los trabajos al cluster, que luego
    % copiare y pegare
    cmd{batchi} = sprintf('qsub -pe batch %d -N %s -j y -b y -o %s -cwd %s',...
    n_c,jobid,outfiles{batchi},scriptfile);
  
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

qsubcommandsfile=fullfile(tmpdir,'qsubcommands.txt');
fid2=fopen(qsubcommandsfile,'w');
for i=1:nbatches    
    fprintf(fid2,'%s \n',cmd{i});
end
 fclose(fid2);