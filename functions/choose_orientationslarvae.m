% theta = choose_orientations2(x,y,phi,wtheta,wphi)
%
% we will set the orientation to theta_t = phi_t + s_t * pi
% we want to choose s_t to minimize
% \sum_t cost(s_t|s_{t-1})
% cost(s_t|s_{t-1}) = [wtheta_t*d(\theta_t,\theta_{t-1}) +
%                      wphi(||v_t||^2)*d(\theta_t,angle(v_t))]
%
% we will find the most likely states s_t using the recursion
% cost_t(s_t) = min_{s_{t-1}} { cost_{t-1}(s_{t-1}) + cost(s_t|s_{t-1})
%
% Inputs:
% x: N x 1 vector where x(t) is the x-coordinate of the center of the fly
% at time t
% y: N x 1 vector where y(t) is the y-coordinate of the center of the fly
% at time t
% phi: N x 1 vector where phi(t) is the orientation of the fly at time t
% wtheta: N x 1 vector where wtheta(t) is the weight of the change in
% orientation term at time t
% wphi: N x 1 vector where wphi(t) is the weight of the velocity 
% direction term at time t
%
function [xspine,yspine,curvtips] = choose_orientationslarvae(xspine,yspine,velang,ecc,curvtips)


%xspine = xspine([1,11],:);
%yspine = yspine([1,11],:);
wecc=10*(1-ecc);
worient=0.1*ones(1,length(ecc));
worient(ecc<0.9)=0;
% number of frames
N = length(ecc);

% allocate space for storing the optimal path
stateprev = zeros(N-1,2);

% allocate space for computing costs
tmpcost = zeros(2,1);
costprevnew = zeros(2,1);

% initialize first frame
costprev = zeros(2,1);

% % compute velocity
% vx = [0;diff(x)];
% vy = [0;diff(y)];

% compute angle of velocity
%velocityangle = atan2(vy,vx);

% compute iteratively
for t = 2:N,
    
    % compute for both possible states
    for scurr = 1:2,
        
        % try both previous states
        %thetacurr = theta(t) + (scurr-1)*pi;
        [xspinecurr,yspinecurr,curvtipscurr]=computeflip(scurr,xspine(:,t),yspine(:,t),curvtips(:,t));
        
        for sprev = 1:2,
            
            %thetaprev = theta(t-1) + (sprev-1)*pi;
            [xspineprev,yspineprev,curvtipsprev]=computeflip(sprev,xspine(:,t-1),yspine(:,t-1),curvtips(:,t-1));
            % define the cost TODO
            %costcurr = weight_theta(t)*angledist(thetaprev,thetacurr) + ...
            %  weight_phi(t)*angledist(thetacurr,velocityangle(t));
            headtailang=atan2(yspinecurr(1)-yspinecurr(end),xspinecurr(1)-xspinecurr(end));
            orient=cos(velang(t-1)).*cos(headtailang)+sin(velang(t-1)).*sin(headtailang);
            costcurr=2*sqrt((xspineprev(1)-xspinecurr(1)).^2+(yspineprev(1)-yspinecurr(1)).^2)...
                +2*sqrt((xspineprev(end)-xspinecurr(end)).^2+(yspineprev(end)-yspinecurr(end)).^2)...
                -wecc(t)*curvtipscurr(1)-worient(t)*orient;
            tmpcost(sprev) = costprev(sprev) + costcurr;
            
        end
        
        % choose the minimum
        sprev = argmin(tmpcost);
        
        % set pointer for path
        stateprev(t-1,scurr) = sprev;
        
        % set cost
        costprevnew(scurr) = tmpcost(sprev);
        
    end
    
    % copy over
    costprev(:) = costprevnew(:);
    
end

% choose the best last state
scurr = argmin(costprev);

if scurr == 2,
    %theta(end) = modrange(theta(end)+pi,-pi,pi);
    [xspine(:,end),yspine(:,end),curvtips(:,end)]=computeflip(scurr,xspine(:,end),yspine(:,end),curvtips(:,end));
end

% choose the best states
for t = N-1:-1:1,
    scurr = stateprev(t,scurr);
    if scurr == 2,
        %theta(t) = modrange(theta(t)+pi,-pi,pi);
        [xspine(:,t),yspine(:,t),curvtips(:,t)]=computeflip(scurr,xspine(:,t),yspine(:,t),curvtips(:,t));
    end
end

%theta = reshape(theta,inputsz);