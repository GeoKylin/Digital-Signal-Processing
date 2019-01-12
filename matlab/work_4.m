%% FIR 和 IIR（根据信号和噪声谱差别选择滤波窗）
% WangKai 编写于 2018/12/23
%% 程序初始化
clear; close all; clc;

%% 导入数据
load all_data;
name = {'AGL' 'BZH' 'CHF' 'HAJF' 'HEY' 'HHC' 'HLG' 'LHT' 'LLM' 'LOH' 
    'MEIX' 'NSHT' 'PHSG' 'PTAQ' 'QLIT' 'QYU' 'WEC' 'XBZ' 'XUW' 'YUY'}';
sta_name = name{4};
eval(['data=',sta_name,';']);
data(isnan(data)) = [];

%% 原始数据图像
dt = 0.01;
fs = 1/dt;
t = (0:length(data)-1)*dt;
figure;
set(gcf,'unit','centimeters','position',[5 20 40 7]);
set(gca,'Position',[.1 .2 .85 .7]);
plot(t,data,'k'); xlim([0 max(t)]); title(sta_name);
xlabel('Time (s)'); ylabel('Acceleration (nm/s^2)');

%% FIR 滤波
% 高通滤波
Wc = 0.5/(fs/2); % 通带频率下限
tc = 5:dt:max(t); % 去除前 5s 滤波后的数据，截断效应
order_fir = 5e2;
b = fir1(order_fir,Wc,'high');
% 滤波器
figure;
freqz(b);
% 滤波信号
filter_d = filter(b,1,data);
filter_d = filter_d(length(t)-length(tc)+1:end);
figure;
set(gcf,'unit','centimeters','position',[5 20 40 7]);
set(gca,'Position',[.1 .2 .85 .7]);
plot(tc,filter_d+mean(data),'k'); xlim([0 max(tc)]); title(sta_name);
xlabel('Time (s)'); ylabel('Acceleration (nm/s^2)');

%% IIR 滤波
% 巴特沃斯高通滤波
order_butter = 4;
[b,a] = butter(order_butter,Wc,'high');
% 滤波器
figure;
freqz(b);
% 滤波信号
filter_d = filter(b,a,data);
filter_d = filter_d(length(t)-length(tc)+1:end);
figure;
set(gcf,'unit','centimeters','position',[5 20 40 7]);
set(gca,'Position',[.1 .2 .85 .7]);
plot(tc,filter_d+mean(data),'k'); xlim([0 max(t)]); title(sta_name);
xlabel('Time (s)'); ylabel('Acceleration (nm/s^2)');