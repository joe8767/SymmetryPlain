%% ��wrl�ļ������x-y�ӽǵ����ͼ��ת����.abs�ļ�

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

%�ҳ�X,Y�������Сֵ���Ӷ�ȷ��Z�������ͼ�ķ�Χ
Xmax = max(Xvertex);
Xmin = min(Xvertex);
Xscope = Xmax - Xmin;

Ymax = max(Yvertex);
Ymin = min(Yvertex);
Yscope = Ymax - Ymin;

%�ҳ�Z����������Сֵ��ӳ�䵽0~255֮��
Zmax = max(Zvertex);
Zmin = min(Zvertex);
Zscope = Zmax - Zmin;
depth = (Zvertex - Zmin) ./ Zscope;  %ӳ�䵽0-1֮��
depth = depth .* 255;

depthIM = zeros(Yscope, Xscope);
Xabs = zeros(Yscope, Xscope);
Yabs = zeros(Yscope, Xscope);
Zabs = zeros(Yscope, Xscope);
flag = zeros(Yscope, Xscope);   %��¼Y�������е��λ��
Xind = Xvertex-Xmin + 1;    %Matlab�±��1��ʼ
Yind = Yvertex-Ymin + 1;
for i=1:vertex_num
    depthIM(Yind(i), Xind(i)) = depth(i);
    Xabs(Yind(i), Xind(i)) = vertex(i, 1);
    Yabs(Yind(i), Xind(i)) = vertex(i, 2);
    Zabs(Yind(i), Xind(i)) = vertex(i, 3);
    flag(Yind(i), Xind(i)) = 1;
end
%% ��ͼ����ת180��
[Zrows, Zcolums] = size(depthIM);
for i=1:Zrows
    for j=1:Zcolums
        depthIM_rotate180(Zrows-i+1, j) = depthIM(i, j);
    end
end
% figure, imshow(depthIM_rotate180, []);    %�Ҷ�ͼ��
figure, imagesc(depthIM_rotate180), colormap(jet);      %����ӳ��

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


