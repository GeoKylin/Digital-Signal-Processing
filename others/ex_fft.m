%% fft_analyze 函数的测试样例
%% 程序初始化
clear; close all; clc;

%% 创建信号
f1 = 10; f2 = 25; % 两个频率成分的频率
A1 = 5; A2 = 3; % 两个频率成分的振幅
fs = 100; % 采样频率(需要大于等于2倍的最大频率成分)
t = 0.01 : 1/fs : 5; % 采样时间序列
y = A1*sin(2*pi*f1*t) + A2*sin(2*pi*f2*t); % 采样信号序列

%% 信号分析
% help fft_analyze; % 帮助文档
[~,~,~,fs,~,~,df] = fft_analyze(t,y) % 输出采样率 fs 与频率域分辨率 df