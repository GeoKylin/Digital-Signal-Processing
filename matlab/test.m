%% �����ʼ��
clear; close all; clc;

%% ��������
filePath = '/Users/wangkai/Documents/##�ҵĿμ�/��һ�＾-�����źŴ�����ѧ��/�ҵ���ҵ/���𲨴��������ҵ/all/AGL.SACASC';
data = loaddata(filePath);
data = reshape(data,[],1);

%% ��������
save('data.mat','data');