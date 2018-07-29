function [xspine,yspine,curvtips]=computeflip(flip,xspine,yspine,curvtips)
if flip==2
    xspine=xspine(end:-1:1,:);
    yspine=yspine(end:-1:1,:);
    curvtips=curvtips(end:-1:1,:);
end
    