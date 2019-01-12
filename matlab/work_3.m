%% 非参数功率谱（几种方法谱比较）
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
% 参数赋值
nfft = length(data);
fs = 100;
t = (0:1:nfft-1)/fs;

%% 周期图谱
figure;
periodogram(data,[],'onesided',nfft,fs);
h = get(gca,'Children'); set(h,'Color','k');
grid off;  title(sta_name); ylim([-80 120]);
% 加汉明窗的周期图谱
figure;
periodogram(data,hamming(nfft),'onesided',nfft,fs);
h = get(gca,'Children'); set(h,'Color','k');
grid off;  title(sta_name); ylim([-80 120]);

%% 相关图谱
% 自相关系数
R = xcorr(data,'unbiased');
R = R((length(R)+1)/2:end);
% FFT
FR = fft(R); % 频谱序列
FR = FR(1:length(FR)/2); % 取一半
df = 1/(max(t)-min(t));
f = (0:nfft/2-1)*df; % 频率序列
A = 2*abs(FR)/nfft; A(1) = 0;
% 相关图谱
figure;
plot(f,10*log(A),'k'); % 对数谱
xlabel('Frequency (Hz)'); ylabel('Power/frequency (dB/Hz)'); title(sta_name);

%% 最大熵谱(Burg)
order = 5e2; % AR模型的阶数
figure;
pburg(data,order,nfft,fs,'oneside');
h = get(gca,'Children'); set(h,'Color','k');
grid off;  title(sta_name);