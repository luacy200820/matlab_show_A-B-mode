% input:
%     alineName- 檔名路徑
% output: 
%     d- time (x1軸)
%     alineSgn- time-domain訊號(y1軸)
%     f- frequency- (x2軸)
%     alineSgn- frequency-domain訊號(y2軸)


function [d, alineSgn, f, fftSgn] = showTransducerChar(alineName)
    close all

alineName = 'C:\Users\user\Downloads\訓練用資料\訓練用資料\30MHz_steel_A0.dat';
%     讀取資料
    data = headFile_NI(alineName);  %這邊已經是structure形式，找出對應訊號的component
    
%     快速傅立葉轉換
    spectrum = abs(fft(data))^2;
%     壓縮
    data_compress = 10*log10(spectrum/max(spectrum));


%     圖片輸出(可複製貼上到sigmaplot做)

%plot(x,y,'-',x2,y2,'--');  % x,y = time / amplitude , x2,y2 = magnitude /
%frequency
% hold on
    
    