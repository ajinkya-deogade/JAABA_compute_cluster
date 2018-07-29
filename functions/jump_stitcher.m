%% Author: Matthieu Louis

function [xy_traj_int, xy_traj_nan]=jump_stitcher(xy_traj, plot_flag) %inputs corresponds to vectors of kinematic data for a given trajectory; fps is the number of frames acquired per second

xy_traj_diff=diff(xy_traj);

diff_cutoff=prctile(xy_traj_diff, 99)*10;

out_of_bound_max_cutoff_x=prctile(xy_traj(:,1),99)+(prctile(xy_traj(:,1),99)-prctile(xy_traj(:,1),1))/2;
out_of_bound_max_cutoff_y=prctile(xy_traj(:,2),99)+(prctile(xy_traj(:,2),99)-prctile(xy_traj(:,2),1))/2;
out_of_bound_min_cutoff_x=prctile(xy_traj(:,1),1)-(prctile(xy_traj(:,1),99)-prctile(xy_traj(:,1),1))/2;
out_of_bound_min_cutoff_y=prctile(xy_traj(:,2),1)-(prctile(xy_traj(:,2),99)-prctile(xy_traj(:,2),1))/2;

% or below might not work... check
out_of_bound_index_x=find(xy_traj(:,1)>out_of_bound_max_cutoff_x | xy_traj(:,1)<out_of_bound_min_cutoff_x);
out_of_bound_index_y=find(xy_traj(:,2)>out_of_bound_max_cutoff_y | xy_traj(:,2)<out_of_bound_min_cutoff_y);

discontinuity_index_x=-1; %value to be discarded, used to create index vector (below)
discontinuity_index_y=-1;
%
for i=1:length(xy_traj_diff(:,1))
    if abs(xy_traj_diff(i,1)) > diff_cutoff(1,1)
        discontinuity_index_x=[discontinuity_index_x (i-1) i (i+1)];
    end
    if abs(xy_traj_diff(i,2)) > diff_cutoff(1,2)
        discontinuity_index_y=[discontinuity_index_y (i-1) i (i+1)];
    end
end
%
discontinuity_index_x=unique(discontinuity_index_x(discontinuity_index_x>0));
discontinuity_index_y=unique(discontinuity_index_y(discontinuity_index_y>0));

xy_traj_nan=xy_traj;
xy_traj_nan(union(out_of_bound_index_x,discontinuity_index_x),1)=NaN;
xy_traj_int(:,1)=interp1(1:length(xy_traj_nan),xy_traj_nan(:,1),1:length(xy_traj_nan),'pchip');
xy_traj_nan(union(out_of_bound_index_y,discontinuity_index_y),2)=NaN;
xy_traj_int(:,2)=interp1(1:length(xy_traj_nan),xy_traj_nan(:,2),1:length(xy_traj_nan),'pchip');

if plot_flag==1
    
    figure
    subplot(2,1,1),plot(1:length(xy_traj_nan),xy_traj_nan(:,1),'k',1:length(xy_traj_int),2+xy_traj_int(:,1),'r')
    subplot(2,1,2),plot(1:length(xy_traj_nan),xy_traj_nan(:,2),'k',1:length(xy_traj_int),2+xy_traj_int(:,2),'r')
    
end