function [xspine,yspine]=computeflip2(flip,xspine,yspine)
if flip==2
    xspine=xspine(end:-1:1,:);
    yspine=yspine(end:-1:1,:);
end
    