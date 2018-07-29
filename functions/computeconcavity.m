%dtermine if a point in the contour is concave or convexe

function [conc]=computeconcavity(outline,i)
lengthcontour=length(outline);
edges=zeros(2,2);
idx1=[6:lengthcontour,1:5];
idx2=[lengthcontour-4:lengthcontour,1:lengthcontour-5];
edges(1,:)=outline(idx1(i),:);
edges(2,:)=outline(idx2(i),:);

conc=inpolygon(mean(edges(:,1)),mean(edges(:,2)),outline(:,1),outline(:,2));