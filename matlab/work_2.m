%% 时频分析（STFT 和 WaveletT）
% WangKai 编写于 2018/12/22
%% 程序初始化
clear; close all; clc;

%% 导入数据
load all_data;
name = {'AGL' 'BZH' 'CHF' 'HAJF' 'HEY' 'HHC' 'HLG' 'LHT' 'LLM' 'LOH' 
    'MEIX' 'NSHT' 'PHSG' 'PTAQ' 'QLIT' 'QYU' 'WEC' 'XBZ' 'XUW' 'YUY'}';
sta_name = name{11};
eval(['data=',sta_name,';']);
data(isnan(data)) = [];

%% STFT
% 参数赋值
fs = 100; % 采样频率
win_sz = 256; % 汉明窗大小
noverlap = win_sz/2; % 时窗重叠部分
nfft = win_sz; % 窗内采样点数
% 时频分析图
figure; 
[S, F, T] = spectrogram(data, win_sz, noverlap, nfft, fs);
mesh(T, F, log10(abs(S))); title(sta_name);
shading interp;
colormap jet; hc=colorbar; ylabel(hc,'log (Amplitude)');
xlabel('Time (s)'); ylabel('Frequency (Hz)');
xlim([0 (length(data)-1)/fs]);
view(0,90);

%% WaveletT
wavename = 'bump';
figure;
cwt(data,wavename,fs); title(sta_name);
colormap jet;