%% 将wrl文件构造成x-y视角的深度图像并转换成.abs文件

filename = 'cara1_frontal1.wrl';

[ vertex, faces3p, faces4p] = readWRL2Tuples(filename);
% add 1 to index
faces3p = faces3p + 1;
faces4p = faces4p + 1;
triangulated4p = Trangulate4p(faces4p);

%% combine the faces
faces = [triangulated4p;faces3p];

figure,plot_mesh(vertex, faces);

Xvertex = round(vertex(:, 1));
Yvertex = round(vertex(:, 2));
Zvertex = round(vertex(:, 3));
vertex_num = length(Xvertex);

%找出X,Y的最大最小值，从而确定Z方向深度图的范围
Xmax = max(Xvertex);
Xmin = min(Xvertex);
Xscope = Xmax - Xmin;

Ymax = max(Yvertex);
Ymin = min(Yvertex);
Yscope = Ymax - Ymin;

%找出Z方向的最大最小值，映射到0~255之间
Zmax = max(Zvertex);
Zmin = min(Zvertex);
Zscope = Zmax - Zmin;
depth = (Zvertex - Zmin) ./ Zscope;  %映射到0-1之间
depth = depth .* 255;

depthIM = zeros(Yscope, Xscope);
Xabs = zeros(Yscope, Xscope);
Yabs = zeros(Yscope, Xscope);
Zabs = zeros(Yscope, Xscope);
flag = zeros(Yscope, Xscope);   %记录Y方向上有点的位置
Xind = Xvertex-Xmin + 1;    %Matlab下标从1开始
Yind = Yvertex-Ymin + 1;
for i=1:vertex_num
    depthIM(Yind(i), Xind(i)) = depth(i);
    Xabs(Yind(i), Xind(i)) = vertex(i, 1);
    Yabs(Yind(i), Xind(i)) = vertex(i, 2);
    Zabs(Yind(i), Xind(i)) = vertex(i, 3);
    flag(Yind(i), Xind(i)) = 1;
end
%% 将图像旋转180度
[Zrows, Zcolums] = size(depthIM);
for i=1:Zrows
    for j=1:Zcolums
        depthIM_rotate180(Zrows-i+1, j) = depthIM(i, j);
    end
end
% figure, imshow(depthIM_rotate180, []);    %灰度图像
figure, imagesc(depthIM_rotate180), colormap(jet);      %红蓝映射

absFile = fopen('test.abs', 'w+');
fprintf(absFile, '%d  rows', Yscope);
fprintf(absFile, '\n');
fprintf(absFile, '%d  columns', Xscope);
fprintf(absFile, '\n');
fprintf(absFile, 'pixels (flag X Y Z):', Xscope);
fprintf(absFile, '\n');
for i=1:Yscope
    for j=1:Xscope
        fprintf(absFile, '%d ', flag(i, j));
    end
end
fprintf(absFile, '\n');
for i=1:Yscope
    for j=1:Xscope
        fprintf(absFile, '%g ', Xabs(i, j));
    end
end
fprintf(absFile, '\n');
for i=1:Yscope
    for j=1:Xscope
        fprintf(absFile, '%g ', Yabs(i, j));
    end
end
fprintf(absFile, '\n');
for i=1:Yscope
    for j=1:Xscope
        fprintf(absFile, '%g ', Zabs(i, j));
    end
end
fprintf(absFile, '\n');
fclose(absFile);
fprintf('absFile Saved!\n');


