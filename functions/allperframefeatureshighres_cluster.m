function allperframefeatureshighres_cluster(outputfolderorg)
% tic
load(fullfile(outputfolderorg,'trx.mat'))
filename=fullfile(outputfolderorg,'oldtrx.mat');
save(filename,'trx');
mkdir(outputfolderorg,'perframe')
outputfolder = fullfile(outputfolderorg,'perframe');

compute_x_mm(trx,outputfolder)
compute_y_mm(trx,outputfolder)
compute_vy_cm(trx,outputfolder)
compute_vx_cm(trx,outputfolder)
compute_velmag_ctr(trx,outputfolder)
compute_velang(trx,outputfolder)

compute_eccentricity(trx,outputfolder);
compute_da_mm(trx,outputfolder);
compute_db_mm(trx,outputfolder);
compute_decc(trx,outputfolder);


[trx]=compute_tailheadang(trx,outputfolder);
[trx]=compute_spinerelevantpositions(trx,outputfolder);
[trx]=compute_tailheadmag(trx,outputfolder);
[trx]=compute_tailcentralmag(trx,outputfolder);
[trx]=compute_tailcentralang(trx,outputfolder);
[trx]=compute_centralheadmag(trx,outputfolder);
[trx]=compute_centralheadang(trx,outputfolder);


compute_area_mm(trx,outputfolder);
[trx]=spineangle(trx,outputfolder);
[trx]=spinerelangle(trx,outputfolder);
[trx]=compute_spinelength(trx,outputfolder);
[trx]=compute_angchvsangtc(trx,outputfolder);
[trx]=compute_normarea(trx,outputfolder);
[trx]=compute_normlength(trx,outputfolder);

[trx]=compute_velch(trx,outputfolder);
[trx]=compute_velperch(trx,outputfolder);
[trx]=compute_veltc(trx,outputfolder);
[trx]=compute_velpertc(trx,outputfolder);
[trx]=compute_velth(trx,outputfolder);
[trx]=compute_velperth(trx,outputfolder);

[trx]=compute_ratioarealength(trx,outputfolder);


[trx]=compute_dtailheadmag(trx,outputfolder);
[trx]=compute_dtailheadang(trx,outputfolder);
[trx]=compute_dtailcentralmag(trx,outputfolder);
[trx]=compute_dtailcentralang(trx,outputfolder);
[trx]=compute_dcentralheadmag(trx,outputfolder); %%
[trx]=compute_dcentralheadang(trx,outputfolder);

[trx]=compute_dspinerelevantpositions(trx,outputfolder);
compute_darea(trx,outputfolder);
[trx]=compute_dspinelength(trx,outputfolder);
[trx]=compute_dnormarea(trx,outputfolder);
[trx]=compute_dnormlength(trx,outputfolder);

[trx]=compute_dratioarealength(trx,outputfolder);
[trx]=compute_dangchvsangtc(trx,outputfolder);

[trx]=compute_theta(trx,outputfolder);
[trx]=compute_dtheta(trx,outputfolder);


[trx]=compute_velmaghead(trx,outputfolder);
[trx]=compute_velmagcentral(trx,outputfolder);
[trx]=compute_velmagtail(trx,outputfolder);
[trx]=compute_velanghead(trx,outputfolder);
[trx]=compute_velangcentral(trx,outputfolder);
[trx]=compute_velangtail(trx,outputfolder);

[trx]=compute_velheadch(trx,outputfolder);
[trx]=compute_velcentralch(trx,outputfolder);
[trx]=compute_veltailch(trx,outputfolder);
[trx]=compute_velheadperch(trx,outputfolder);
[trx]=compute_velcentralperch(trx,outputfolder);
[trx]=compute_veltailperch(trx,outputfolder);

[trx]=compute_velheadtc(trx,outputfolder);
[trx]=compute_velcentraltc(trx,outputfolder);

[trx]=compute_veltailtc(trx,outputfolder);
[trx]=compute_velheadpertc(trx,outputfolder);
[trx]=compute_velcentralpertc(trx,outputfolder);
[trx]=compute_veltailpertc(trx,outputfolder);

[trx]=compute_velheadth(trx,outputfolder);
[trx]=compute_velcentralth(trx,outputfolder);
[trx]=compute_veltailth(trx,outputfolder);
[trx]=compute_velheadperth(trx,outputfolder);
[trx]=compute_velcentralperth(trx,outputfolder);
[trx]=compute_veltailperth(trx,outputfolder);

[trx]=compute_sumspinerelangle(trx,outputfolder);
[trx]=compute_sumspinerelanglehc(trx,outputfolder);
[trx]=compute_sumspinerelanglect(trx,outputfolder);
[trx]=compute_dsumspinerelangle(trx,outputfolder);
[trx]=compute_dsumspinerelanglehc(trx,outputfolder);
[trx]=compute_dsumspinerelanglect(trx,outputfolder);

[trx]=compute_ratiolengthvsth(trx,outputfolder);
[trx]=compute_dratiolengthvsth(trx,outputfolder);

[trx]=inflectionpointdistance(trx,outputfolder);
[trx]=compute_xinflection_mm(trx,outputfolder);
[trx]=compute_yinflection_mm(trx,outputfolder);
[trx]=compute_dxinflection_mm(trx,outputfolder);
[trx]=compute_dyinflection_mm(trx,outputfolder);
[trx]=compute_tailinflmag(trx,outputfolder);
[trx]=compute_tailinflang(trx,outputfolder);
[trx]=compute_inflheadmag(trx,outputfolder);
[trx]=compute_inflheadang(trx,outputfolder);
[trx]=compute_dtailinflmag(trx,outputfolder);
[trx]=compute_dtailinflang(trx,outputfolder);
[trx]=compute_dinflheadmag(trx,outputfolder);
[trx]=compute_dinflheadang(trx,outputfolder);
[trx]=compute_angihvsangti(trx,outputfolder);
[trx]=compute_dangihvsangti(trx,outputfolder);

% [trx]=compute_spinepositionssm(trx,outputfolder);
% [trx]=compute_dspinepositionssm(trx,outputfolder);

% [trx]=compute_centralheadsmang(trx,outputfolder);
% [trx]=compute_tailsmcentralang(trx,outputfolder);
% [trx]=compute_tailsmheadsmang(trx,outputfolder);
%
% [trx]=compute_velchsm(trx,outputfolder);
% [trx]=compute_veltsmc(trx,outputfolder);
% [trx]=compute_veltsmhsm(trx,outputfolder);

% [trx]=compute_tailsminflang(trx,outputfolder);
% [trx]=compute_inflheadsmang(trx,outputfolder);
% [trx]=compute_angihsmvsangtsmi(trx,outputfolder);

[trx]=compute_xtailcentral_mm(trx,outputfolder);
[trx]=compute_ytailcentral_mm(trx,outputfolder);

[trx]=compute_dxtailcentral_mm(trx,outputfolder);
[trx]=compute_dytailcentral_mm(trx,outputfolder);
[trx]=compute_velmagtailcentral(trx,outputfolder);
[trx]=compute_velangtailcentral(trx,outputfolder);

[trx]=compute_xtailhead_mm(trx,outputfolder);
[trx]=compute_ytailhead_mm(trx,outputfolder);
[trx]=compute_dxtailhead_mm(trx,outputfolder);
[trx]=compute_dytailhead_mm(trx,outputfolder);
[trx]=compute_velmagtailhead(trx,outputfolder);
[trx]=compute_velangtailhead(trx,outputfolder);
[trx]=compute_xcentralhead_mm(trx,outputfolder);
[trx]=compute_ycentralhead_mm(trx,outputfolder);

[trx]=compute_dxcentralhead_mm(trx,outputfolder);
[trx]=compute_dycentralhead_mm(trx,outputfolder);
[trx]=compute_velmagcentralhead(trx,outputfolder);
[trx]=compute_velangcentralhead(trx,outputfolder);

% [trx]=compute_rhead_mm(trx,outputfolder);
% [trx]=compute_disthead2wall_mm(trx,outputfolder);
%
% [trx]=compute_dcentral(trx,outputfolder);
% [trx]=compute_dhead2central(trx,outputfolder);

filename=fullfile(outputfolderorg,'trx.mat');
save(filename,'trx');
% toc