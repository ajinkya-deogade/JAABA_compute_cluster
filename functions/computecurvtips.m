%compute the curvature of the tips
function [curvborders]=computecurvtips(xoutline,youtline,xspine,yspine,scales,absX,absY)
filter=conv(fspecial('gaussian',[40 1],8),[1 -2 1]);

%xheadidx=find(xoutline==xspine(:,1));
%yheadidx=find(youtline==yspine(:,1));
%headidx=intersect(xheadidx,yheadidx);
disthead=bsxfun(@hypot,xoutline-xspine(1),youtline-yspine(1));
[~,headidx]=min(disthead);

% xtailidx=find(xoutline==xspine(:,end));
% ytailidx=find(youtline==yspine(:,end));
% tailidx=intersect(xtailidx,ytailidx);

disttail=bsxfun(@hypot,xoutline-xspine(end),youtline-yspine(end));
[~,tailidx]=min(disttail);

xoutlinepx=(xoutline-scales(2)*absX)/scales(1);
youtlinepx=(youtline-scales(2)*absY)/scales(1);

%compute curvature of the points in the outline
xcurvoutline=imfilter(xoutlinepx',filter,'circular');
ycurvoutline=imfilter(youtlinepx',filter,'circular');

curvborders=sqrt(xcurvoutline([headidx,tailidx]).^2+ycurvoutline([headidx,tailidx]).^2);



