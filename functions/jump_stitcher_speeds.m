%% Author: Matthieu Louis

function [speed_int, speed_nan]=jump_stitcher_speeds(speed, plot_flag) %inputs corresponds to vectors of kinematic data for a given trajectory; fps is the number of frames acquired per second

speed_diff=diff(speed);

diff_cutoff=prctile(speed_diff, 99)*10;

out_of_bound_max_cutoff_speed=prctile(speed(:,1),99)+(prctile(speed(:,1),99)-prctile(speed(:,1),1))/2;
% out_of_bound_max_cutoff_y=prctile(speed(:,2),99)+(prctile(speed(:,2),99)-prctile(speed(:,2),1))/2;
out_of_bound_min_cutoff_speed=prctile(speed(:,1),1)-(prctile(speed(:,1),99)-prctile(speed(:,1),1))/2;
% out_of_bound_min_cutoff_y=prctile(speed(:,2),1)-(prctile(speed(:,2),99)-prctile(speed(:,2),1))/2;

% or below might not work... check
out_of_bound_index_speed=find(speed(:,1)>out_of_bound_max_cutoff_speed | speed(:,1)<out_of_bound_min_cutoff_speed);
% out_of_bound_index_y=find(speed(:,2)>out_of_bound_max_cutoff_y | speed(:,2)<out_of_bound_min_cutoff_y);

discontinuity_index_speed=-1; %value to be discarded, used to create index vector (below)
% discontinuity_index_y=-1;
%
for i=1:length(speed_diff(:,1))
    if abs(speed_diff(i,1)) > diff_cutoff(1,1)
        discontinuity_index_speed=[discontinuity_index_speed (i-1) i (i+1)];
    end
%     if abs(speed_diff(i,2)) > diff_cutoff(1,2)
%         discontinuity_index_y=[discontinuity_index_y (i-1) i (i+1)];
%     end
end
%
discontinuity_index_speed=unique(discontinuity_index_speed(discontinuity_index_speed>0));
% discontinuity_index_y=unique(discontinuity_index_y(discontinuity_index_y>0));

speed_nan=speed;
speed_nan(union(out_of_bound_index_speed,discontinuity_index_speed),1) = NaN;
speed_int=interp1(1:length(speed_nan), speed_nan, 1:length(speed_nan),'pchip');

% speed_nan(union(out_of_bound_index_y,discontinuity_index_y),2)=NaN;
% speed_int(:,2)=interp1(1:length(speed_nan),speed_nan(:,2),1:length(speed_nan),'pchip');

if plot_flag==1
    
    figure
    subplot(2,1,1),plot(1:length(speed_nan),speed_nan(:,1),'k',1:length(speed_int),2+speed_int(:,1),'r')
%     subplot(2,1,2),plot(1:length(speed_nan),speed_nan(:,2),'k',1:length(speed_int),2+speed_int(:,2),'r')
    
end