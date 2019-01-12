%% 信号与噪声谱（FFT）
% WangKai 编写于 2018/12/22
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

%% 噪声
% 时间序列
tn = 0:dt:20;
dn = data(1:length(tn));
figure;
set(gcf,'unit','centimeters','position',[5 20 40 7]);
set(gca,'Position',[.1 .2 .85 .7]);
plot(tn,dn,'k'); title(sta_name);
xlabel('Time (s)'); ylabel('Acceleration (nm/s^2)');
% FFT
Dn = fft(dn); % 频谱序列
Dn = fftshift(Dn); % 转换为关于原点对称
Nn = length(tn);
dfn = 1/(max(tn)-min(tn));
fn = (-(Nn-1)/2 : 1 : (Nn-1)/2)*dfn; % 频率序列
An = 2*abs(Dn)/Nn;
An((Nn+1)/2) = 0;
% 振幅谱
figure;  
set(gcf,'unit','centimeters','position',[10 5 30 20]);
set(gca,'Position',[.08 .1 .88 .85]);
plot(fn,log(An),'k'); % 对数谱
xlabel('Frequency (Hz)'); ylabel('log (Amplitude)'); title(sta_name);

%% 信号
% 高通滤波
Wc = 0.5/(fs/2);
tc = 20:dt:max(t); % 去除前 20s 滤波后的数据，截断效应
[b,a] = butter(4,Wc,'high');
filter_d = filter(b,a,data);
filter_d = filter_d(length(t)-length(tc)+1:end);
figure;
set(gcf,'unit','centimeters','position',[5 20 40 7]);
set(gca,'Position',[.1 .2 .85 .7]);
plot(tc,filter_d+mean(data),'k'); xlim([0 max(t)]); title(sta_name);
xlabel('Time (s)'); ylabel('Acceleration (nm/s^2)');
% FFT
D = fft(filter_d); % 频谱序列
D = fftshift(D); % 转换为关于原点对称
N = length(tc);
df = 1/(max(tc)-min(tc));
f = (-(N-1)/2 : 1 : (N-1)/2)*df; % 频率序列
A = 2*abs(D)/N;
A(ceil((N+1)/2)) = 0;
% 振幅谱
figure;
set(gcf,'unit','centimeters','position',[10 5 30 20]);
set(gca,'Position',[.08 .1 .88 .85]);
plot(f,log(A),'k'); % 对数谱
xlabel('Frequency (Hz)'); ylabel('log (Amplitude)'); title(sta_name);