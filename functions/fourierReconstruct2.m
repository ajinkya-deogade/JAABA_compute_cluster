function [coordinate_x coordinate_y] = fourierReconstruct2(coeffs, nPoints, nComponents)
len = size(coeffs);
for t = 1:len(1)
    j = 0;
    for i = 1:nComponents
        j = j+1;
        AX(t,i) = coeffs(t,j);
        j = j+1;
        BX(t,i) = coeffs(t,j);
        j = j+1;
        AY(t,i) = coeffs(t,j);
        j = j+1;
        BY(t,i) = coeffs(t,j);
        
    end
end

coordinate = zeros(nPoints,2);
thetaStep = (2*pi)/nPoints;
theta = -1*pi;

x = zeros(len(1),nPoints);
y = zeros(len(1),nPoints);

for t = 1:len(1)
    for k = 1:nComponents
        theta = -1*pi;
        for j = 1:nPoints
            x(t,j) = x(t,j) + BX(t,k)*sin((k-1)*theta)+ AX(t,k)*cos((k-1)*theta);
            y(t,j) = y(t,j) + BY(t,k)*sin((k-1)*theta)+ AY(t,k)*cos((k-1)*theta);
            theta = theta + thetaStep;
        end
    end
    coordinate_x(t,:) = y(t,:);
    coordinate_y(t,:) = x(t,:);
end
end