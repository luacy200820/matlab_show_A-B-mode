% input:
%     alineName- �ɦW���|
% output: 
%     d- time (x1�b)
%     alineSgn- time-domain�T��(y1�b)
%     f- frequency- (x2�b)
%     alineSgn- frequency-domain�T��(y2�b)


function [d, alineSgn, f, fftSgn] = showTransducerChar(alineName)
    close all

alineName = 'C:\Users\user\Downloads\�V�m�θ��\�V�m�θ��\30MHz_steel_A0.dat';
%     Ū�����
    data = headFile_NI(alineName);  %�o��w�g�Ostructure�Φ��A��X�����T����component
    
%     �ֳt�ť߸��ഫ
    spectrum = abs(fft(data))^2;
%     ���Y
    data_compress = 10*log10(spectrum/max(spectrum));


%     �Ϥ���X(�i�ƻs�K�W��sigmaplot��)

%plot(x,y,'-',x2,y2,'--');  % x,y = time / amplitude , x2,y2 = magnitude /
%frequency
% hold on
    
    