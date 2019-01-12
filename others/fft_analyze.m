function [f,A,Phi,fs,N,dt,df] = fft_analyze(t_series,y_series)
%% FFT_ANALYZE 快速傅里叶变换分析函数
%   [f,A,Phi,fs,N,dt,df] = fft_analyze(t_series,y_series)
%
% 函数输入
%   T_SERIES: 时间序列
%   Y_SERIES: 信号序列
%
% 函数输出：
%    F: 频率序列
%    A: 振幅谱
%  PHI: 相位谱
%   FS: 时间域采样频率
%    N: 时间域采样点数
%   DT: 时间域采样间隔
%   DF: 频率域分辨率
%
% 傅里叶级数 与 傅里叶变换 的区别：
%   傅里叶级数（FS）：处理周期性连续信号
%   傅里叶变换（FT）：处理非周期连续信号
%   离散傅里叶变换（DFT）：处理非周期离散信号
%   快速傅里叶变换（FFT）：DFT 的快速算法，本质是 DFT
%
% 注意事项：
%   Y = fft(x) % x 为一个序列(向量)，存放采集信号的数据
%   Y = fft(x,n) % x 的定义同上，n 定义计算数据的个数
%   如果 n 大于 x 的长度，在 x 的末尾添加 0，使得 x 的长度等于 n
%   如果 n 小于 x 的长度，截取 x 中的前 n 个数来进行计算
%   Y 返回 fft 的结果，为一个复数序列(向量)
% 建议：采用第一种格式的用法，并且保证 x 的个数为偶数
%
% 快速傅里叶变换的特征：
%   频谱关于中间位置对称(序号位置 1 和 N/2+1 除外)，MATLAB 的 FFT 为对称谱，
%   详见“振幅修正”的处理方法
%
% 采样定理：
%   采样频率为 Fs 时，频谱图的最高频率为 Fs/2，频率分辨率为 fs/N
%   因此，想要得到频率成分 Fc，则必须满足 Fs≥2Fc，实际应用中需要更大的 Fs
%   同时，想要区分两个频率成分 F1 和 F2，则必须满足 fs/N > abs(F1-F2)
%
% WangKai 编写于 2018/4/18 13:52:00
%   中国科学院地质与地球物理研究所, 北京, 中国.
%   页岩气与地质工程实验室
%   Comments, bug reports and questions, please send to:
%   wangkai185@mails.ucas.edu.cn / 513814330@qq.com
%
%   2018年11月7日第一次修改 - 添加信号重建部分，修改部分注释

%% 初始化变量
N = length(t_series); % 采样点数
dt = (t_series(end) - t_series(1))/(N - 1); % 采样时间间隔
fs = 1/dt; % 采样频率
df = fs/N; % 频率域分辨率

%% 时间域图像
figure; subplot(2,2,1);
plot(t_series,y_series); 
xlabel('Time/s'); ylabel('Y'); title('原始信号');

%% 快速傅里叶变换
Y0 = fft(y_series); % 频谱序列
Y = fftshift(Y0); % 转换为关于原点对称

%% 频率谱图像
f = (-N/2 : 1 : N/2-1)*df; % 频率序列
A = 2*abs(Y)/N; A(1) = A(1)/2; A(N/2+1) = A(N/2+1)/2; % 振幅修正
% 振幅谱
subplot(2,2,3); plot(f,A); 
% plot(f,log(A)); % 对数谱
xlabel('Frequency/Hz'); ylabel('Amplitude'); title('振幅谱');
% 相位谱
Phi = angle(Y);
subplot(2,2,4); plot(f,Phi); 
xlabel('Frequency/Hz'); ylabel('\phi'); title('相位谱');

%% 信号重建
yi = ifft(Y0); % 反傅里叶变换
subplot(2,2,2); plot(t_series,yi);
xlabel('Time/s'); ylabel('Y'); title('重建信号');