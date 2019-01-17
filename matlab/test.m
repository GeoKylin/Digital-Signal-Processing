%% 程序初始化
clear; close all; clc;

%% 导入数据
filePath = '/Users/wangkai/Documents/##我的课件/研一秋季-数字信号处理（地学）/我的作业/地震波处理分析作业/all/AGL.SACASC';
data = loaddata(filePath);
data = reshape(data,[],1);

%% 保存数据
save('data.mat','data');