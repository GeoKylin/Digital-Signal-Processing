%% �ǲ��������ף����ַ����ױȽϣ�
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
% ������ֵ
nfft = length(data);
fs = 100;
t = (0:1:nfft-1)/fs;

%% ����ͼ��
figure;
periodogram(data,[],'onesided',nfft,fs);
h = get(gca,'Children'); set(h,'Color','k');
grid off;  title(sta_name); ylim([-80 120]);
% �Ӻ�����������ͼ��
figure;
periodogram(data,hamming(nfft),'onesided',nfft,fs);
h = get(gca,'Children'); set(h,'Color','k');
grid off;  title(sta_name); ylim([-80 120]);

%% ���ͼ��
% �����ϵ��
R = xcorr(data,'unbiased');
R = R((length(R)+1)/2:end);
% FFT
FR = fft(R); % Ƶ������
FR = FR(1:length(FR)/2); % ȡһ��
df = 1/(max(t)-min(t));
f = (0:nfft/2-1)*df; % Ƶ������
A = 2*abs(FR)/nfft; A(1) = 0;
% ���ͼ��
figure;
plot(f,10*log(A),'k'); % ������
xlabel('Frequency (Hz)'); ylabel('Power/frequency (dB/Hz)'); title(sta_name);

%% �������(Burg)
order = 5e2; % ARģ�͵Ľ���
figure;
pburg(data,order,nfft,fs,'oneside');
h = get(gca,'Children'); set(h,'Color','k');
grid off;  title(sta_name);