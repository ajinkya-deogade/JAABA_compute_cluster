%% Author: Ajinkya Deogade
% Function to compute spine from CLT tracker data
% contour - Contour points for the larvae
% headposition - headposition from the kinData file
% tailposition - tailpoistion from the kinData file

function [spineX, spineY] = computeSpine(contour, headposition, tailposition)

%% Number of points for the spine
skeletonSize = length(contour)/2;

%% Determine the head index in the perimeter
D_head = pdist2(headposition, contour, 'euclidean');
headInd = find(D_head == min(D_head));
headposition = contour(headInd,:);
head = headposition;

%% Determine the tail index in the perimeter
D_tail = pdist2(tailposition, contour, 'euclidean');
tailInd = find(D_tail == min(D_tail));
tailposition = contour(tailInd,:);
tail = tailposition;

%% Sort perimeter from head clockwise, find number of points to tail and length of this side
for i = headInd:(headInd+length(contour))
    contourSortedCW((i-headInd)+1,:) = contour(mod(i,length(contour))+1,:);
    if (contour(mod(i,length(contour))+1, 1) == tailposition(1) & (contour(mod(i,length(contour))+1,2) == tailposition(2)))
        tailIndCW = i-headInd;
        break;
    end
end

%% Sort perimeter from head counterclockwise, Find number of points to tail
for i = (headInd+length(contour)):-1:headInd
    %     display(i)
    contourSortedCCW(((headInd+length(contour))-i)+1,:) = contour(mod(i,length(contour))+1,:);
    if (contour(mod(i,length(contour))+1, 1) == tailposition(1) & (contour(mod(i,length(contour))+1, 2) == tailposition(2)))
        tailIndCCW = headInd+length(contour) - i;
        break;
    end
end

%% 100 points along the skeleton, cut the different sides into a number of equal steps
stepCW = tailIndCW/skeletonSize;
stepCCW = tailIndCCW/skeletonSize;
indCW = 1;
indCCW = 1;
pLengthCW = length(contourSortedCW);
pLengthCCW = length(contourSortedCCW);

%% calculate skeleton by finding the midpoint between evenly spaced number of points on each side
for i = 1:skeletonSize
    %     if indCW <=pLengthCW & indCCW <=pLengthCCW
    spine(i,1) = (contourSortedCW(round(indCW),1) + contourSortedCCW(round(indCCW),1))/2;
    spine(i,2) = (contourSortedCW(round(indCW),2) + contourSortedCCW(round(indCCW),2))/2;
    indCW = indCW + stepCW;
    indCCW = indCCW + stepCCW;
    %     end
end
spineX = spine(:,1);
spineY = spine(:,2);

end