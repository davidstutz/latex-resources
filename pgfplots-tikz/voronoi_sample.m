points = dlmread('points.txt');
[vx,vy]=voronoi(points(:,1), points(:,2));
fid = fopen('voronoi.txt', 'w');
fprintf(fid, '%f, %f\n%f %f\n\n', [vx(:), vy(:)]');
fclose(fid);
fid = fopen('voronoi.txt', 'w');
fprintf(fid, '%f %f\n%f %f\n\n', [vx(:), vy(:)]');
fclose(fid);