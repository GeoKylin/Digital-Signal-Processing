%% �����ʼ��
clear; close all; clc;

%% ���ϵ��
A = [1 1 1;
     -0.2 0.8 0;
     0.04 0.64 0];
B = [5;6;9.4];
C = A\B

% ԭʼ���ƹ�ʽ
k = -2:10; y=zeros(length(k),1);
for i=3:length(k)
    y(i) = 0.6*y(i-1)+0.16*y(i-2)+5*(k(i)==0)+3*(k(i-1)==0)+5*(k(i-2)==0);
end
y=y(3:end)

% ϵͳ��Ӧ����
k = 0:10; h=zeros(length(k),1);
for i=1:length(k)
    h(i) = C(1)*(-0.2)^k(i)+C(2)*(0.8)^k(i)+C(3)*(k(i)==0);
end
h