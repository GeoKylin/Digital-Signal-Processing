%% FIR �� IIR�������źź������ײ��ѡ���˲�����
% WangKai ��д�� 2018/12/23
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

%% FIR �˲�
% ��ͨ�˲�
Wc = 0.5/(fs/2); % ͨ��Ƶ������
tc = 5:dt:max(t); % ȥ��ǰ 5s �˲�������ݣ��ض�ЧӦ
order_fir = 5e2;
b = fir1(order_fir,Wc,'high');
% �˲���
figure;
freqz(b);
% �˲��ź�
filter_d = filter(b,1,data);
filter_d = filter_d(length(t)-length(tc)+1:end);
figure;
set(gcf,'unit','centimeters','position',[5 20 40 7]);
set(gca,'Position',[.1 .2 .85 .7]);
plot(tc,filter_d+mean(data),'k'); xlim([0 max(tc)]); title(sta_name);
xlabel('Time (s)'); ylabel('Acceleration (nm/s^2)');

%% IIR �˲�
% ������˹��ͨ�˲�
order_butter = 4;
[b,a] = butter(order_butter,Wc,'high');
% �˲���
figure;
freqz(b);
% �˲��ź�
filter_d = filter(b,a,data);
filter_d = filter_d(length(t)-length(tc)+1:end);
figure;
set(gcf,'unit','centimeters','position',[5 20 40 7]);
set(gca,'Position',[.1 .2 .85 .7]);
plot(tc,filter_d+mean(data),'k'); xlim([0 max(t)]); title(sta_name);
xlabel('Time (s)'); ylabel('Acceleration (nm/s^2)');