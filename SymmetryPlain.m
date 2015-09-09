%% ͨ���Գ��������ҵ��ԳƵ�������
%% ����ԳƵ���е㣬ȡ�����������ó��Գ���
close all
load featurelist
load featurelistsym
load meshFace

figure,plot_mesh(vertex, faces);

%Ѱ��ƥ��ĶԳ�������
addpath ../../Tongji/toolbox_meshSIFT/meshSIFT
[coords mangles match1 match2 coord1 coord2] = findcmatches(featurelist,featurelistsym);

% �����ԳƵ�
hold on;
scatter3(coords(:,1),coords(:,2),coords(:,3),4, 'r');
scatter3(coords(:,4),coords(:,5),coords(:,6),4, 'r');
% �����м��
scatter3((coords(:,1) + coords(:,4))/2, (coords(:,2) + coords(:,5))/2, (coords(:,3) + coords(:,6))/2, 4, 'g');

% �����Գ�ƽ��
% 1 3 5
figure,plot_mesh(vertex, faces);
hold on;
P1idx = 2;
P2idx = 3;
P3idx = 5;
P1 = [(coords(P1idx,1) + coords(P1idx,4))/2, (coords(P1idx,2) + coords(P1idx,5))/2, (coords(P1idx,3) + coords(P1idx,6))/2];
P2 = [(coords(P2idx,1) + coords(P2idx,4))/2, (coords(P2idx,2) + coords(P2idx,5))/2, (coords(P2idx,3) + coords(P2idx,6))/2];
P3 = [(coords(P3idx,1) + coords(P3idx,4))/2, (coords(P3idx,2) + coords(P3idx,5))/2, (coords(P3idx,3) + coords(P3idx,6))/2];
Drawplanefrompoint(P1,P2,P3,[250, 500]);
