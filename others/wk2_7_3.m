%% �����ʼ��
clear; close all; clc;

%% ������ֵ
alphap = 3; alphas = 14;
omegap = 1e5; omegas = 1.5e5;

%% ������
% Step 1��ȷ������ K
K = ceil(log((10^(alphas/10)-1)/(10^(alphap/10)-1))/(2*log(omegas/omegap)))
% Step 2��ȷ���빦�ʽ�ֹƵ�� ��c
omegac = [omegap/(10^(alphap/10)-1).^(1/(2*K)),...
    omegas/(10^(alphas/10)-1).^(1/(2*K))]
% Step 3��ȷ�����ݺ��� H(s)
omegac = mean(omegac)
k = 1:K;
format short g
A = [1 2.613126 3.414214 2.613126 1].*[1 omegac omegac^2 omegac^3 omegac^4]
omega = linspace(0,3e5,1001);
H = omegac^K./(polyval(A,1j*omega));
% ���� |H(jw)| ͼ��
plot(omega,abs(H),'k'); hold on;
ylim([0 1.2]);
% ����
passband_floor = 10^(-alphap/20);
stopband_ceil = 10^(-alphas/20);
fill([0 omegap omegap 0],[0 0 passband_floor passband_floor],[0.8 0.8 0.8]);
fill([0 omegap omegap 0],[1 1 1.2 1.2],[0.8 0.8 0.8]);
fill([omegas 3e5 3e5 omegas],[stopband_ceil stopband_ceil 1.2 1.2],...
    [0.8 0.8 0.8]);
text(4e4,passband_floor+0.03,num2str(passband_floor));
text(2.1e5,stopband_ceil-0.03,num2str(stopband_ceil));
title(['Lowpass Butterworth magnitude response with K = ',num2str(K),...
    ' and ��c = ',num2str(omegac)]);

omegaps = [1.1e5 1.4e5];
alphaps = -20*log10(abs(omegac^K./(polyval(A,1j*omegaps))))