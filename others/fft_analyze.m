function [f,A,Phi,fs,N,dt,df] = fft_analyze(t_series,y_series)
%% FFT_ANALYZE ���ٸ���Ҷ�任��������
%   [f,A,Phi,fs,N,dt,df] = fft_analyze(t_series,y_series)
%
% ��������
%   T_SERIES: ʱ������
%   Y_SERIES: �ź�����
%
% ���������
%    F: Ƶ������
%    A: �����
%  PHI: ��λ��
%   FS: ʱ�������Ƶ��
%    N: ʱ�����������
%   DT: ʱ����������
%   DF: Ƶ����ֱ���
%
% ����Ҷ���� �� ����Ҷ�任 ������
%   ����Ҷ������FS�������������������ź�
%   ����Ҷ�任��FT������������������ź�
%   ��ɢ����Ҷ�任��DFT���������������ɢ�ź�
%   ���ٸ���Ҷ�任��FFT����DFT �Ŀ����㷨�������� DFT
%
% ע�����
%   Y = fft(x) % x Ϊһ������(����)����Ųɼ��źŵ�����
%   Y = fft(x,n) % x �Ķ���ͬ�ϣ�n ����������ݵĸ���
%   ��� n ���� x �ĳ��ȣ��� x ��ĩβ��� 0��ʹ�� x �ĳ��ȵ��� n
%   ��� n С�� x �ĳ��ȣ���ȡ x �е�ǰ n ���������м���
%   Y ���� fft �Ľ����Ϊһ����������(����)
% ���飺���õ�һ�ָ�ʽ���÷������ұ�֤ x �ĸ���Ϊż��
%
% ���ٸ���Ҷ�任��������
%   Ƶ�׹����м�λ�öԳ�(���λ�� 1 �� N/2+1 ����)��MATLAB �� FFT Ϊ�Գ��ף�
%   ���������������Ĵ�����
%
% ��������
%   ����Ƶ��Ϊ Fs ʱ��Ƶ��ͼ�����Ƶ��Ϊ Fs/2��Ƶ�ʷֱ���Ϊ fs/N
%   ��ˣ���Ҫ�õ�Ƶ�ʳɷ� Fc����������� Fs��2Fc��ʵ��Ӧ������Ҫ����� Fs
%   ͬʱ����Ҫ��������Ƶ�ʳɷ� F1 �� F2����������� fs/N > abs(F1-F2)
%
% WangKai ��д�� 2018/4/18 13:52:00
%   �й���ѧԺ��������������о���, ����, �й�.
%   ҳ��������ʹ���ʵ����
%   Comments, bug reports and questions, please send to:
%   wangkai185@mails.ucas.edu.cn / 513814330@qq.com
%
%   2018��11��7�յ�һ���޸� - ����ź��ؽ����֣��޸Ĳ���ע��

%% ��ʼ������
N = length(t_series); % ��������
dt = (t_series(end) - t_series(1))/(N - 1); % ����ʱ����
fs = 1/dt; % ����Ƶ��
df = fs/N; % Ƶ����ֱ���

%% ʱ����ͼ��
figure; subplot(2,2,1);
plot(t_series,y_series); 
xlabel('Time/s'); ylabel('Y'); title('ԭʼ�ź�');

%% ���ٸ���Ҷ�任
Y0 = fft(y_series); % Ƶ������
Y = fftshift(Y0); % ת��Ϊ����ԭ��Գ�

%% Ƶ����ͼ��
f = (-N/2 : 1 : N/2-1)*df; % Ƶ������
A = 2*abs(Y)/N; A(1) = A(1)/2; A(N/2+1) = A(N/2+1)/2; % �������
% �����
subplot(2,2,3); plot(f,A); 
% plot(f,log(A)); % ������
xlabel('Frequency/Hz'); ylabel('Amplitude'); title('�����');
% ��λ��
Phi = angle(Y);
subplot(2,2,4); plot(f,Phi); 
xlabel('Frequency/Hz'); ylabel('\phi'); title('��λ��');

%% �ź��ؽ�
yi = ifft(Y0); % ������Ҷ�任
subplot(2,2,2); plot(t_series,yi);
xlabel('Time/s'); ylabel('Y'); title('�ؽ��ź�');