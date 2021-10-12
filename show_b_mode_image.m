%{
input
    fullPath- 檔案路徑
    dynamic_range- 動態範圍，通常預設是42，代表-42dB-0dB的資料點會被正規化成0-255
%}


function [us_image] = show_b_mode_image(fullPath, dynamic_range)
     
%     讀取資料
    file = fopen(fullPath,'r');
    rf = fread(file,'int8');
    fclose(file);
	
%     如果B-mode影像的檔名是*_B1.dat(B後面是奇數)則需要左右翻轉
    Aline=rf(7)*16129+rf(8)*127+rf(9);	%印象中是換能器的array大小
    DataLength=rf(10)*16129+rf(11)*127+rf(12);
    SamplingRate=rf(13)*16129+rf(14)*127+rf(15);% MHz
    Delay=rf(16)*16129+rf(17)*127+rf(18);  %暫且猜測他是us的單位
    Vpp=rf(19)*16129+rf(20)*127+rf(21);% mV
    XInterval=rf(22)*16129+rf(23)*127+rf(24);% μm
   
    sound_speed = 1540;
    
    file_header = length(rf)-DataLength*Aline;
    rf(1:file_header)=[];
    
    rf_reshape = reshape(rf,DataLength,Aline); % 以原始採樣率的p/q倍對序列rf重採樣。結果re_reshape的長度是x的長度的p/q倍
    rf_reshape = rf_reshape*Vpp/255; 
    
    spectrum = abs(hilbert(rf_reshape));  %Hilbert 變換可用於形成解析信號
    
%     計算X軸(橫向點與點之間的距離跟X interval有關)、Y軸(縱向點與點之間的距離跟sampling rate有關)
 
    xlength = Aline*XInterval*10^-3;
    ylength = (DataLength/(SamplingRate*2*10^6))*sound_speed*10^3;
    y_start = (Delay/(SamplingRate*2*10^6))*sound_speed*10^3;
    
    round_len = round(ylength);
    round_s = round(y_start);
   
%     快速傅立葉轉換

%     壓縮
    compression = 20*log10(spectrum/min(min(spectrum)));
	
	%   動態範圍調整&正規化
    compressed_signal = compression-max(max(compression));
    us_image=(compressed_signal+dynamic_range)/dynamic_range*255;

%   秀圖(plot)


    image([0,xlength],[y_start y_start+ylength ],us_image);
    set(gca,'XTick',[0 0.2 0.4 0.6 0.8 1],'FontWeight','bold','FontSize',14);
   % set(gca,'YTick',round_s:1:round_s+round_len);
    set(gca,'YTick',[9.3 9.6 10 10.3],'FontWeight','bold','FontSize',14);
    colormap(gray(256));
    axis image;
    ylabel('Depth (mm)','FontWeight','bold','FontSize',18);
    xlabel('Distance (mm)','FontWeight','bold','FontSize',18);
    
    title('B-mode');
    %colorbar;
    
   
    
    

   





 

