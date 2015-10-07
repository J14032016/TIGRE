function h=plotgeometry(geo,a)

% You need the following files to run it:
% Arrow3D
% https://www.mathworks.com/matlabcentral/fileexchange/28324-3d-arrow-plot

%% Figure stuff
h=figure('Name','Cone Beam Compute Tomography geometry');
hold on
xlabel('X');
ylabel('Y');
zlabel('Z');
set(gcf, 'color', [1 1 1])

%% CUBE/Image

drawCube(geo.offOrigin,geo.sVoxel,'k',0.05,0);

%% Detector
drawCube([-geo.DSD+geo.DSO; geo.offDetector],[1; geo.sDetector],'r',1,a)
plotCircle3D([0 0 0],-geo.DSD+geo.DSO);
%% source
p=plot3(geo.DSO,0,0,'.','MarkerSize',30);
rotate(p,[0  0  1],a,[0 0 0]);
plotCircle3D([0 0 0],geo.DSO);

%% Arrows.
arrow=geo.sVoxel;
%XYZ arrows
arrow3d([0 arrow(1)],[0 0],[0 0],.90,5,15,'r');
arrow3d([0 0],[0 arrow(2)],[0 0],.90,5,15,'b');
arrow3d([0 0],[0 0],[0 arrow(3)],.90,5,15,'g');

%UV arrows



%%
axis equal;
% grid on
% axis off;



end
function drawCube( origin, size,color,alpha,a)
% From
% http://www.mathworks.com/matlabcentral/newsreader/view_thread/235581

x=([0 1 1 0 0 0;1 1 0 0 1 1;1 1 0 0 1 1;0 1 1 0 0 0]-0.5)*size(1)+origin(1);
y=([0 0 1 1 0 0;0 1 1 0 0 0;0 1 1 0 1 1;0 0 1 1 1 1]-0.5)*size(2)+origin(2);
z=([0 0 0 0 0 1;0 0 0 0 0 1;1 1 1 1 0 1;1 1 1 1 0 1]-0.5)*size(3)+origin(3);
for i=1:6
    h=patch(x(:,i),y(:,i),z(:,i),color);
    set(h,'facealpha',alpha)
    rotate(h,[0 0 1],a,[0 0 0]);
end

end

function plotCircle3D(center,radius)

theta=0:0.1:2*pi;
v=null([0 0 1]);
points=repmat(center',1,size(theta,2))+radius*(v(:,1)*cos(theta)+v(:,2)*sin(theta));
plot3(points(1,:),points(2,:),points(3,:),'k-.');

end