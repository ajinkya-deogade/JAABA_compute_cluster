function peaks = houghcirclepeaks(varargin)
%HOUGHCIRCLEPEAKS Identify peaks in 3-D accumulator for Hough
%transform.
%   PEAKS = HOUGHCIRCLEPEAKS(H,NUMPEAKS) locates peaks in the Hough 
%   transform matrix, H, generated by the HOUGHCIRCLES
%   function. NUMPEAKS specifies the maximum number of peaks to
%   identify. PEAKS is a Q-by-2 matrix, where Q can range from 0 to
%   NUMPEAKS. Q holds the row and column coordinates of the
%   peaks. If NUMPEAKS is omitted, it defaults to 1.
%
%   PEAKS = HOUGHCIRCLEPEAKS(...,PARAM1,VAL1,PARAM2,VAL2) sets
%   various parameters. Parameter names can be abbreviated, and case 
%   does not matter. Each string parameter is followed by a value 
%   as indicated below:
%
%   'Threshold' Nonnegative scalar.
%               Values of H below 'Threshold' will not be
%               considered
%               to be peaks. Threshold can vary from 0 to Inf.
%   
%               Default: 0.5*max(H(:))
%
%   'NHoodSize' Three-element vector of positive odd integers: [L M N].
%               'NHoodSize' specifies the size of the suppression
%               neighborhood. This is the neighborhood around each 
%               peak that is set to zero after the peak is
%               identified.
%
%               Default: smallest odd values greater than or equal
%               to
%                        size(H)/50.
%   Class Support
%   -------------
%   H is the output of the HOUGHCIRCLES function. NUMPEAKS is a positive
%   integer scalar.
%

[h, numpeaks, threshold, nhood] = parseInputs(varargin{:});

% initialize the loop variables
done = false;
hnew = h;
nhood_center = (nhood-1)/2;
peaks = [];

while ~done
  [dummy max_idx] = max(hnew(:)); %#ok
  [p, q, r] = ind2sub(size(hnew), max_idx);
  p = p(1); q = q(1); r = r(1);

  if hnew(p, q, r) >= threshold
    peaks = [peaks; [p q r]]; % add the peak to the list

    % Suppress this maximum and its close neighbors.
    p1 = p - nhood_center(1); p2 = p + nhood_center(1);
    q1 = q - nhood_center(2); q2 = q + nhood_center(2);
    r1 = r - nhood_center(3); r2 = r + nhood_center(3);
    % Throw away out of bounds coordinates
    [pp, qq, rr] = ndgrid(max(p1,1):min(p2,size(h,1)),...
                          max(q1,1):min(q2,size(h,2)),...
                          max(r1,1):min(r2,size(h,3)));
    pp = pp(:); qq = qq(:); rr = rr(:);

    % Convert to linear indices to zero out all the values.
    hnew(sub2ind(size(hnew), pp, qq, rr)) = 0;
    done = size(peaks,1) == numpeaks;
  else,
    done = true;
  end;
end;

function [h,numpeaks,threshold,nhood] = parseInputs(varargin)

if nargin < 1,
  error('At least one input must be given to HOUGHCIRCLEPEAKS');
end;
h = varargin{1};
if ndims(h) > 3,
  error('Usage: PEAKS = HOUGHCIRCLEPEAKS(H,[NUMPEAKS],[''Threshold'',THRESHOLD],[''NHoodSize'',[N1,N2,N3]])');
end;

% set defaults
numpeaks = 1;
threshold = 0.5 * max(h(:));
nhood = size(h)/50;
nhood = max(2*ceil(nhood/2) + 1, 1); % Make sure the nhood size is odd.
startopts = 2;

if (nargin >= 2) && isnumeric(varargin{2}),
  startopts = 3;
  numpeaks = varargin{2};
end;

if nargin >= startopts,
  [threshold,nhood] = myparse(varargin(startopts:end),'threshold',...
                             threshold,'nhoodsize',nhood);
end;