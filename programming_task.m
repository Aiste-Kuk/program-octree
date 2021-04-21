%% Read data from file
clear all;close all;clc;fclose('all');

DataPath = 'C:\Aiste\Universitetas\task\2743_1234.las';
lasReader = lasFileReader(DataPath);

% Read point cloud data from the LAS file using the readPointCloud function.
ptCloud = readPointCloud(lasReader);

%% Draw point cloud
% Visualize the point cloud.
figure(1)
pcshow(ptCloud.Location)

%% Random
pts = ptCloud.Location;
OT = OcTree(pts,'binCapacity',10000);
figure
boxH = OT.plot;
cols = lines(OT.BinCount);
doplot3 = @(p,varargin)plot3(p(:,1),p(:,2),p(:,3),varargin{:});
for i = 1:OT.BinCount
    set(boxH(i),'Color',cols(i,:),'LineWidth', 1+OT.BinDepths(i))
    doplot3(pts(OT.PointBins==i,:),'.','Color',cols(i,:))
end
axis image, view(3)