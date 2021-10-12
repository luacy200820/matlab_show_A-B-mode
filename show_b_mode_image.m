%{
input
    fullPath- �ɮ׸��|
    dynamic_range- �ʺA�d��A�q�`�w�]�O42�A�N��-42dB-0dB������I�|�Q���W�Ʀ�0-255
%}


function [us_image] = show_b_mode_image(fullPath, dynamic_range)
     
%     Ū�����
    file = fopen(fullPath,'r');
    rf = fread(file,'int8');
    fclose(file);
	
%     �p�GB-mode�v�����ɦW�O*_B1.dat(B�᭱�O�_��)�h�ݭn���k½��
    Aline=rf(7)*16129+rf(8)*127+rf(9);	%�L�H���O���ྐྵ��array�j�p
    DataLength=rf(10)*16129+rf(11)*127+rf(12);
    SamplingRate=rf(13)*16129+rf(14)*127+rf(15);% MHz
    Delay=rf(16)*16129+rf(17)*127+rf(18);  %�ȥB�q���L�Ous�����
    Vpp=rf(19)*16129+rf(20)*127+rf(21);% mV
    XInterval=rf(22)*16129+rf(23)*127+rf(24);% �gm
   
    sound_speed = 1540;
    
    file_header = length(rf)-DataLength*Aline;
    rf(1:file_header)=[];
    
    rf_reshape = reshape(rf,DataLength,Aline); % �H��l�ļ˲v��p/q����ǦCrf���ļˡC���Gre_reshape�����׬Ox�����ת�p/q��
    rf_reshape = rf_reshape*Vpp/255; 
    
    spectrum = abs(hilbert(rf_reshape));  %Hilbert �ܴ��i�Ω�Φ��ѪR�H��
    
%     �p��X�b(��V�I�P�I�������Z����X interval����)�BY�b(�a�V�I�P�I�������Z����sampling rate����)
 
    xlength = Aline*XInterval*10^-3;
    ylength = (DataLength/(SamplingRate*2*10^6))*sound_speed*10^3;
    y_start = (Delay/(SamplingRate*2*10^6))*sound_speed*10^3;
    
    round_len = round(ylength);
    round_s = round(y_start);
   
%     �ֳt�ť߸��ഫ

%     ���Y
    compression = 20*log10(spectrum/min(min(spectrum)));
	
	%   �ʺA�d��վ�&���W��
    compressed_signal = compression-max(max(compression));
    us_image=(compressed_signal+dynamic_range)/dynamic_range*255;

%   �q��(plot)


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
    
   
    
    

   





 

