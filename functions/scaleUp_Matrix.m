%  Author: Ajinkya Deogade
%  Organisation: Center for Genomic Regulation
%  Year: 2014
%  Description: 

function [scaled_matrix] = scaleUp_Matrix(matrix, scaling_up_factor)

    mesh_size = 1/scaling_up_factor;
    [x_grad,y_grad] = meshgrid(1:length(matrix),1:length(matrix));
    [x_grad_interp,y_grad_interp] = meshgrid(1:mesh_size:length(matrix),1:mesh_size:length(matrix));
    for i=1:1:scaling_up_factor*length(matrix)
        for j=1:1:scaling_up_factor*length(matrix)
            x_grad_interp(i,j)=i/scaling_up_factor;
            y_grad_interp(i,j)=j/scaling_up_factor;
        end
    end
    scaled_matrix = interp2(x_grad, y_grad, matrix, x_grad_interp, y_grad_interp, 'linear');

end