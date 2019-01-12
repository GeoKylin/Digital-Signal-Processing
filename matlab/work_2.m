%% ʱƵ������STFT �� WaveletT��
% WangKai ��д�� 2018/12/22
%% �����ʼ��
clear; close all; clc;

%% ��������
load all_data;
name = {'AGL' 'BZH' 'CHF' 'HAJF' 'HEY' 'HHC' 'HLG' 'LHT' 'LLM' 'LOH' 
    'MEIX' 'NSHT' 'PHSG' 'PTAQ' 'QLIT' 'QYU' 'WEC' 'XBZ' 'XUW' 'YUY'}';
sta_name = name{11};
eval(['data=',sta_name,';']);
data(isnan(data)) = [];

%% STFT
% ������ֵ
fs = 100; % ����Ƶ��
win_sz = 256; % ��������С
noverlap = win_sz/2; % ʱ���ص�����
nfft = win_sz; % ���ڲ�������
% ʱƵ����ͼ
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