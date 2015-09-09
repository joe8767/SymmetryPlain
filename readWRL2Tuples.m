function [ vertex, faces3p, faces4p] = readWRL2Tuples(filename)
  % 读取gavaDB中的人脸数据
  % vertex:       顶点
  % faces3p:    三角面片
  % faces4p:    四边形面片
    fp = fopen(filename, 'r');
    if fp == -1
        fclose all;
        str = sprintf('Cannot open file %s \n', filename);
%         errordlg(str);
        error(str);
        return;
    end
    
    % skip the head
    lineStr = fgetl(fp);
    while isempty(strfind(lineStr, 'point'))
        lineStr = fgetl(fp);
    end
    
    % read points
    points = [];
    while true
        lineStr = fgetl(fp);
        if ~isempty(strfind(lineStr, ']'))
            break;
        end
        pointStr = regexp(lineStr, ' ', 'split');
        point1 = pointStr{1};
        point2 = pointStr{2};
        point3 = pointStr{3};
        %remove the comma
        point3 = point3(1:end-1);
        point1 = str2double(point1);
        point2 = str2double(point2);
        point3 = str2double(point3);
        
        points = [points; [point1, point2, point3] ];
    end
    
    %% read faces
    % coordIndex
    % skip the head
    lineStr = fgetl(fp);
    while isempty(strfind(lineStr, 'coordIndex'))
        lineStr = fgetl(fp);
    end
    
    faces4p = [];
    faces3p = [];
    while true
        lineStr = fgetl(fp);
        faceStr = regexp(lineStr, ',', 'split');
        if ~isempty(strfind(lineStr, ']'))
            break;
        end
        faceLen = length(faceStr);
        % neglect the missing lines
        if faceLen == 6
            face1 = faceStr{1};
            face2 = faceStr{2};
            face3 = faceStr{3};
            face4 = faceStr{4};
            
            face1 = str2double(face1);
            face2 = str2double(face2);
            face3 = str2double(face3);
            face4 = str2double(face4);
            
            faces4p = [faces4p; [face1, face2, face3, face4]];
        elseif faceLen == 5 || faceLen == 4 % triple tuple
%             faceLen
            face1 = faceStr{1};
            face2 = faceStr{2};
            face3 = faceStr{3};
            face1 = str2double(face1);
            face2 = str2double(face2);
            face3 = str2double(face3);
            faces3p = [faces3p; [face1, face2, face3]];
        else
            faceLen
        end
    end
    size(points);
    size(faces4p);
    vertex = points;
        
end

