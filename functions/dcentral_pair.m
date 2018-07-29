function dcentral = dcentral_pair(trx,larva1,larva2,xcentral_mm1,ycentral_mm1,xcentral_mm2,ycentral_mm2)

% initialize
dcentral = nan(1,trx(larva1).nframes);

% get start and end frames of overlap
t0 = max(trx(larva1).firstframe,trx(larva2).firstframe);
t1 = min(trx(larva1).endframe,trx(larva2).endframe);
  
% no overlap
if t1 < t0, 
  return;
end
lengthoverlap=t1-t0+1;
% indices for these frames
if trx(larva1).firstframe>trx(larva2).firstframe
    i0 = 1;
    i1 = lengthoverlap;
    j0 = t0-trx(larva2).firstframe+1;
    j1 = j0+lengthoverlap-1;
else
    j0 = 1;
    j1 = lengthoverlap;
    i0 = t0-trx(larva1).firstframe+1;
    i1 = i0+lengthoverlap-1;
end
    

% centroid distance
dx = xcentral_mm2(j0:j1)-xcentral_mm1(i0:i1);
dy = ycentral_mm2(j0:j1)-ycentral_mm1(i0:i1);
z = sqrt(dx.^2 + dy.^2);
dcentral(i0:i1) = z;
