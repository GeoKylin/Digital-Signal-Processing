%% �ź��������ף�FFT��
% WangKai ��д�� 2018/12/22
%% �����ʼ��
clear; close all; clc;

%% ��������
load all_data;
name = {'AGL' 'BZH' 'CHF' 'HAJF' 'HEY' 'HHC' 'HLG' 'LHT' 'LLM' 'LOH' 
    'MEIX' 'NSHT' 'PHSG' 'PTAQ' 'QLIT' 'QYU' 'WEC' 'XBZ' 'XUW' 'YUY'}';
sta_name = name{4};
eval(['data=',sta_name,';']);
data(isnan(data)) = [];

%% ԭʼ����ͼ��
dt = 0.01;
fs = 1/dt;
t = (0:length(data)-1)*dt;
figure;
set(gcf,'unit','centimeters','position',[5 20 40 7]);
set(gca,'Position',[.1 .2 .85 .7]);
plot(t,data,'k'); xlim([0 max(t)]); title(sta_name);
xlabel('Time (s)'); ylabel('Acceleration (nm/s^2)');

%% ����
% ʱ������
tn = 0:dt:20;
dn = data(1:length(tn));
figure;
set(gcf,'unit','centimeters','position',[5 20 40 7]);
set(gca,'Position',[.1 .2 .85 .7]);
plot(tn,dn,'k'); title(sta_name);
xlabel('Time (s)'); ylabel('Acceleration (nm/s^2)');
% FFT
Dn = fft(dn); % Ƶ������
Dn = fftshift(Dn); % ת��Ϊ����ԭ��Գ�
Nn = length(tn);
dfn = 1/(max(tn)-min(tn));
fn = (-(Nn-1)/2 : 1 : (Nn-1)/2)*dfn; % Ƶ������
An = 2*abs(Dn)/Nn;
An((Nn+1)/2) = 0;
% �����
figure;  
set(gcf,'unit','centimeters','position',[10 5 30 20]);
set(gca,'Position',[.08 .1 .88 .85]);
plot(fn,log(An),'k'); % ������
xlabel('Frequency (Hz)'); ylabel('log (Amplitude)'); title(sta_name);

%% �ź�
% ��ͨ�˲�
Wc = 0.5/(fs/2);
tc = 20:dt:max(t); % ȥ��ǰ 20s �˲�������ݣ��ض�ЧӦ
[b,a] = butter(4,Wc,'high');
filter_d = filter(b,a,data);
filter_d = filter_d(length(t)-length(tc)+1:end);
figure;
set(gcf,'unit','centimeters','position',[5 20 40 7]);
set(gca,'Position',[.1 .2 .85 .7]);
plot(tc,filter_d+mean(data),'k'); xlim([0 max(t)]); title(sta_name);
xlabel('Time (s)'); ylabel('Acceleration (nm/s^2)');
% FFT
D = fft(filter_d); % Ƶ������
D = fftshift(D); % ת��Ϊ����ԭ��Գ�
N = length(tc);
df = 1/(max(tc)-min(tc));
f = (-(N-1)/2 : 1 : (N-1)/2)*df; % Ƶ������
A = 2*abs(D)/N;
A(ceil((N+1)/2)) = 0;
% �����
figure;
set(gcf,'unit','centimeters','position',[10 5 30 20]);
set(gca,'Position',[.08 .1 .88 .85]);
plot(f,log(A),'k'); % ������
xlabel('Frequency (Hz)'); ylabel('log (Amplitude)'); title(sta_name);