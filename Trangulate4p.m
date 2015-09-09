function [ faces3p ] = Trangulate4p( faces4p )
%���ı�����Ƭ���ǻ�(һ���ı���Ƭ��������������Ƭ)
%   Detailed explanation goes here
    faces4pNum = size(faces4p, 1);
    faces3p = zeros(size(2*faces4pNum, 3));
    for i=1:faces4pNum
        faces3p(2*i-1, 1) = faces4p(i, 1);
        faces3p(2*i-1, 2) = faces4p(i, 2);
        faces3p(2*i-1, 3) = faces4p(i, 3);
        
        faces3p(2*i, 1) = faces4p(i, 3);
        faces3p(2*i, 2) = faces4p(i, 4);
        faces3p(2*i, 3) = faces4p(i, 1);
    end
end

