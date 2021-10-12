function RF = headFile_NI(filename)
file = fopen(filename, 'r');
rf = fread(file, 'int8');
fclose(file);

%% header
if rf(3)==0
    pulser='5900PR';
else
    pulser='AVB2-TB-C';
end
%�o�ɮפ@�w�O2�i��A�p�G�O8bit�A�A�[�W���t���]��
%�C�@�Ӧr���̤j���ȴN�O127�A�M��A�A���p��L
%127*=�N�O16129�A�ҥH�ש��}���I�F
%���G�N�O...�L�u�O��u127�i��v����10�i��Ӥw
ScanSpeed=rf(4)*16129+rf(5)*127+rf(6);
Aline=rf(7)*16129+rf(8)*127+rf(9);	%�L�H���O���ྐྵ��array�j�p
DataLength=rf(10)*16129+rf(11)*127+rf(12);
SamplingRate=rf(13)*16129+rf(14)*127+rf(15);% MHz
Delay=rf(16)*16129+rf(17)*127+rf(18);  %�ȥB�q���L�Ous�����
Vpp=rf(19)*16129+rf(20)*127+rf(21);% mV
XInterval=rf(22)*16129+rf(23)*127+rf(24);% �gm
YInterval=rf(25)*16129+rf(26)*127+rf(27);
MoveTimes=rf(28)*16129+rf(29)*127+rf(30);% �gm
Doppler=rf(31)*16129+rf(32)*127+rf(33);


%%

rf1 = reshape(rf, DataLength, Aline,[]);
rf1 = rf1*Vpp/255;
RF = struct('rf', rf1, 'ScanSpeed', ScanSpeed, 'Aline', Aline, 'DataLength', DataLength,...
    'SamplingRate', SamplingRate, 'Delay', Delay, 'Vpp', Vpp, 'XInterval', XInterval,...
    'YInterval', YInterval, 'MoveTimes', MoveTimes, 'Doppler', Doppler, 'rf2', rf);

end

%�D�n��X��RF�A�p�G�O_C0.dat�N�|��X3D matrix

