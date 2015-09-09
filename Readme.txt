基于MeshSIFT计算人脸特征(特征点及其Normal)
人脸文件(来自GavabDB)：cara1_frontal1.wrl
读入到matlab的人脸: meshFace.mat
计算出来的特征: featurelist.mat
进行对称运算之后的特征:featurelistsym.mat


DrawNormals.m		%%绘制mesh上的Normals

SymmetryPlain.m		%%画出脸部对称平面

Wrl2Depth.m		%%把wrl格式转换成深度图(有点问题)