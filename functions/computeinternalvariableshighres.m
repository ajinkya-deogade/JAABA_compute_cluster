function [a,b,theta]=computeinternalvariableshighres(xcontour,ycontour)

    [X,Y]=meshgrid(linspace(round(min(xcontour*100)),round(max(xcontour*100)),round(max(xcontour*100))-round(min(xcontour*100))+1),...
        linspace(round(min(ycontour*100)),round(max(ycontour*100)),round(max(ycontour*100))-round(min(ycontour*100))+1));
    %% inpolygon
    %     in=inpolygon(X,Y,round(xcontour*100),round(ycontour*100)); %% Matlab
    %     in_inpolygon=in;
    %     [Xseg,Yseg]=find(in==1);
    %     [a_inpolygon,b_inpolygon,theta_inpolygon]=cov2ell(cov([Yseg+round(min(xcontour*100)),Xseg+round(min(ycontour*100))]));
    %     a_inpolygon=a_inpolygon/100;
    %     b_inpolygon=b_inpolygon/100;

    %% inpoly - 50 times faster than inpolygon
    p = [X(:), Y(:)];
    node = [round(xcontour*100); round(ycontour*100)];
    in=inpoly(p, node');
    in_inpoly = reshape(in, size(X));
    [Xseg,Yseg]=find(in_inpoly==1);
    [a,b,theta]=cov2ell(cov([Yseg+round(min(xcontour*100)),Xseg+round(min(ycontour*100))]));
    a=a/100;
    b=b/100;

    %% Poly2mask -- Not working
    %     in=poly2mask(round(xcontour*100), round(ycontour*100), size(X,1), size(X,2)); %% polymax
    %     in=poly2mask(round(xcontour*100), round(ycontour*100), round(max(xcontour*100)), round(max(ycontour*100))); %% polymax
    %     in_poly2mask = in;
    %     [Xseg,Yseg]=find(in==1);
    %     [a_poly2mask,b_poly2mask,theta_poly2mask]=cov2ell(cov([Yseg+round(min(xcontour*100)),Xseg+round(min(ycontour*100))]));
    %     a_poly2mask=a_poly2mask/100;
    %     b_poly2mask=b_poly2mask/100;
    
end