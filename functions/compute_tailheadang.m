%compute tail-head direction and correct trx if necessary
function [trx]=compute_tailheadang(trx,outputfolder)
inputfilename=fullfile(outputfolder,'velang.mat');
if ~exist(inputfilename,'file')
    compute_velang(trx,outputfolder);
end
load(inputfilename, 'data')
velang=data;
inputfilename=fullfile(outputfolder,'ecc.mat');
if ~exist(inputfilename,'file')
    compute_eccentricity(trx,outputfolder);
end
load(inputfilename, 'data')
ecc=data;

headtailang=cell(size(velang));
%is these are high resolution data
if isfield(trx,'curvtips')
    for i=size(velang,2)
        xspine_px=trx(i).xspine;
        yspine_px=trx(i).yspine;
        xspine_mm=trx(i).xspine_mm;
        yspine_mm=trx(i).yspine_mm;
        curvtips=trx(i).curvtips;
        [xspine_mm,yspine_mm,curvtips,xspine_px,yspine_px] = choose_orientationslarvae_highres(xspine_mm,yspine_mm,velang{1,i},ecc{1,i},curvtips,xspine_px,yspine_px);
        trx(i).xspine=xspine_px;
        trx(i).xspine_mm=xspine_mm;
        trx(i).yspine=yspine_px;
        trx(i).yspine_mm=yspine_mm;
        trx(i).curvtips=curvtips;
        headtailang{1,i}=atan2(trx(i).yspine(1,:)-trx(i).yspine(end,:),trx(i).xspine(1,:)-trx(i).xspine(end,:));
    end
    %Compute the best starting orientation
else %if they are regular data
    %the spine params, sbegin and sstop are not aligned any more, I think nothing else use
    %them any more.
    for i=1:size(velang,2)
        xspine_mm=trx(i).xspine_mm;
        yspine_mm=trx(i).yspine_mm;
        xspine=trx(i).xspine;
        yspine=trx(i).yspine;
        [xspine_mm,yspine_mm,xspine,yspine] = choose_orientationslarvaespecies(xspine_mm,yspine_mm,velang{1,i},ecc{1,i},xspine,yspine);
        trx(i).xspine=xspine;
        trx(i).xspine_mm=xspine_mm;
        trx(i).yspine=yspine;
        trx(i).yspine_mm=yspine_mm;
        headtailang{1,i}=atan2(yspine(1,:)-yspine(11,:),xspine(1,:)-xspine(11,:));
        %         xspine=trx(i).xspine_mm([1,11],:);
        %         yspine=trx(i).yspine_mm([1,11],:);
        %         curvtips(1,:)=sqrt(trx(i).xmaxcurvbegin.^2+trx(i).ymaxcurvbegin.^2);
        %         curvtips(2,:)=sqrt(trx(i).xmaxcurvstop.^2+trx(i).ymaxcurvstop.^2);
        %         headtailang{1,i}=atan2(yspine(1,:)-yspine(2,:),xspine(1,:)-xspine(2,:));
        %         orient=cos(velang{1,i}).*cos(headtailang{1,i}(1:end-1))+sin(velang{1,i}).*sin(headtailang{1,i}(1:end-1));
        %         orient=sum(orient(~isnan(orient)));
        %         if orient<0
        %             headtailang{1,i}=atan2(yspine(1,:)-yspine(2,:),xspine(1,:)-xspine(2,:));
        %             trx(i).xspine_mm=trx(i).xspine_mm(11:-1:1,:);
        %             trx(i).xspine=trx(i).xspine(11:-1:1,:);
        %             trx(i).yspine_mm=trx(i).yspine_mm(11:-1:1,:);
        %             trx(i).yspine=trx(i).yspine(11:-1:1,:);
        %             if isfield(trx,'xspineparam')
        %                 trx(i).xspineparam=[-trx(i).xspineparam(1,:);3*(trx(i).sbegin+trx(i).sstop).*trx(i).xspineparam(1,:)+trx(i).xspineparam(2,:);...
        %                     -3*((trx(i).sbegin+trx(i).sstop).^2).*trx(i).xspineparam(1,:)-2*(trx(i).sbegin+trx(i).sstop).*trx(i).xspineparam(2,:)-trx(i).xspineparam(3,:);...
        %                     trx(i).xspineparam(1,:).*((trx(i).sbegin+trx(i).sstop).^3)+trx(i).xspineparam(2,:).*((trx(i).sbegin+trx(i).sstop).^2)+trx(i).xspineparam(3,:).*(trx(i).sbegin+trx(i).sstop)+trx(i).xspineparam(4,:)];
        %                 trx(i).yspineparam=[-trx(i).yspineparam(1,:);3*(trx(i).sbegin+trx(i).sstop).*trx(i).yspineparam(1,:)+trx(i).yspineparam(2,:);...
        %                     -3*((trx(i).sbegin+trx(i).sstop).^2).*trx(i).yspineparam(1,:)-2*(trx(i).sbegin+trx(i).sstop).*trx(i).yspineparam(2,:)-trx(i).yspineparam(3,:);...
        %                     trx(i).yspineparam(1,:).*((trx(i).sbegin+trx(i).sstop).^3)+trx(i).yspineparam(2,:).*((trx(i).sbegin+trx(i).sstop).^2)+trx(i).yspineparam(3,:).*(trx(i).sbegin+trx(i).sstop)+trx(i).yspineparam(4,:)];
        %             end
        %         end
    end
end
units=struct('num','rad','den',[]);
data=headtailang;
filename=fullfile(outputfolder, 'tailheadang.mat');
save(filename, 'data', 'units')
