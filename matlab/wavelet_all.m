%% 时频分析（STFT 和 WaveletT）
% WangKai 编写于 2018/12/22
%% 程序初始化
clear; close all; clc;

%% 导入数据
load all_data;
name = {'AGL' 'BZH' 'CHF' 'HAJF' 'HEY' 'HHC' 'HLG' 'LHT' 'LLM' 'LOH' 
    'MEIX' 'NSHT' 'PHSG' 'PTAQ' 'QLIT' 'QYU' 'WEC' 'XBZ' 'XUW' 'YUY'}';

%% 循环
xb = 0.05;   yb = 0.05;   xs = 0.05;   ys = 0.05;
xl = (1-xb*2-xs*4)/5;   yl = (1-yb*2-ys*3)/4;
xp = (xl+xs)*(0:4)+xb;   yp = (yl+ys)*(3:-1:0)+yb;
[Xp,Yp]=meshgrid(xp,yp);
XP=reshape(Xp',[],1);
YP=reshape(Yp',[],1);
figure;
for i=1:20
    sta_name = name{i};
    eval(['data=',sta_name,';']);
    data(isnan(data)) = [];
    disp(sta_name);
    
    %% STFT
    % % 参数赋值
    fs = 100; % 采样频率
    % win_sz = 256; % 汉明窗大小
    % noverlap = win_sz/2; % 时窗重叠部分
    % nfft = win_sz; % 窗内采样点数
    % % 时频分析图
    % figure;
    % [S, F, T] = spectrogram(data, win_sz, noverlap, nfft, fs);
    % mesh(T, F, log10(abs(S))); title(sta_name);
    % shading interp;
    % colormap jet; hc=colorbar; ylabel(hc,'log (Amplitude)');
    % xlabel('Time (s)'); ylabel('Frequency (Hz)');
    % xlim([0 (length(data)-1)/fs]);
    % view(0,90);
    
    %% WaveletT
    wavename = 'bump';
    cwt(data,wavename,fs); title(sta_name);
    set(gca,'Position',[XP(i) YP(i) xl yl],'xtick',[],'ytick',[]);
    xlabel('Time'); ylabel('Frequency');
    colormap jet; colorbar('position',[1 1 0 0]);
end