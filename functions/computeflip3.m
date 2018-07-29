function [xspine_mm,yspine_mm,xspine,yspine]=computeflip3(flip,xspine_mm,yspine_mm,xspine,yspine)
if flip==2
    xspine_mm=xspine_mm(end:-1:1,:);
    yspine_mm=yspine_mm(end:-1:1,:);
    xspine=xspine(end:-1:1,:);
    yspine=yspine(end:-1:1,:);
end
