function ActiveFFTmonitor_updated_4_Jai(handles)
Width=str2num(handles.imWidth.String); % width
Height=str2num(handles.imHeight.String); % height
NFrames=str2num(handles.nFrames.String); % number of frames
acqHz=str2num(handles.acqHz.String); %recording speed
stimRepHz=str2num(handles.stimRepHz.String);%stimulus rep rate
increment=ceil(Width/4);%split up of the image to make the 3d fft faster later on.

numsamples=NFrames;
validFFTpts=numsamples/2+1;

%fft result will only be valid from 0:acqHz/2+1. Anything after this point is reflective of what came before; 
f = acqHz/2*linspace(0,1,validFFTpts);

location=find(f==stimRepHz);

if isempty(location)
    disp('The given acquisition speed and the stimulus rep rate are not compatible');
    return;
end

[filenamein, folder]=uigetfile('*.tif','MultiSelect','on');
if filenamein==0
    return;
end
filenamein=[folder,filenamein];

%loc=findstr(filenamein,'_D');
loc=findstr(filenamein,'d');
%filebase=filenamein(1:loc(1)-2);
filebase=filenamein(1:loc);
fileext=filenamein(loc+4:end);


startmat=double(zeros(increment,Width, NFrames));
% 
% save  ([handles.tempDir.String,'imagearray1.mat'], 'startmat', '-v7.3');
% save  ([handles.tempDir.String,'imagearray2.mat'], 'startmat', '-v7.3');
% save  ([handles.tempDir.String,'imagearray3.mat'], 'startmat', '-v7.3');
% 
% startmat=double(zeros(Height-increment*3,Width, NFrames));
% save  ([handles.tempDir.String,'imagearray4.mat'], 'startmat', '-v7.3');
% 
% %using this command to save files keeps everything from having to be
% %stored in memory and by splitting things up into multiple files, I
% %save a lot of computation time
% imagearray1=matfile( [handles.tempDir.String,'imagearray1.mat'],'Writable',true);
% imagearray2=matfile( [handles.tempDir.String,'imagearray2.mat'],'Writable',true);
% imagearray3=matfile( [handles.tempDir.String,'imagearray3.mat'],'Writable',true);
% imagearray4=matfile( [handles.tempDir.String,'imagearray4.mat'],'Writable',true);

tim1=tic;
disp(['getting started...Be done in a jiffy'])

files=dir([filebase(1:end-7),'*']);
for j=1:NFrames
    
    if length(files)>j
        filename=[folder,files(j).name];
    elseif length(files)<=j
        %this while loop enables checking if file is ready to copy
        while 1==1
            files=dir([filebase(1:end-7),'*']);
            if length(files)>=j 
                filename=[folder,files(j).name];               
                out=dir(filename);
                oldbytes=out.bytes;
                %this check will make sure file is done being written by
                %making sure the filesize stays the same for a short time
                while 1==1
                    pause(.1);
                    out=dir(filename);
                    newbytes=out.bytes;
                    if newbytes==oldbytes
                        break
                    end
                    oldbytes=newbytes;
                end
                break
            end
            
            %disp(['waiting on ',folder, filebase, num2str(j),fileext])
            pause(.1);
            
        end
    end
    loadedFile(:,:,j)=imread(filename);
    if mod(j,50)==0
     disp(['loaded: ',num2str(j/NFrames*100),'% of all files.'])
    end 
end

toc(tim1);


%%

disp('FFT started. About a minute left');
tim1=tic;

FinalI=[];%ones(Width,Height,length(location));
FinalIAb=[];%ones(Width,Height,length(location));
bg=[];

for i=1:4
    % fix in case the image size is uneven
    FFTresult=fft(loadedFile,[],3);
    bg=FFTresult(:,:,1); %background or zerofrequency
    
    zerofrequency=repmat(bg,[1 1 NFrames]);
    FFTresultAb=abs(FFTresult./zerofrequency);
    
    FinalI=FFTresult(:,:,location);
    FinalIAb=FFTresultAb(:,:,location);

end
toc(tim1);
%%

%Transpose FinalI since the oi files I read from have a different way of
%storing data that result in the image being roatated wrong otherwise
%Change this if it doesn't match your setup
FinalI=FinalI';
FinalIAb=FinalIAb';
FinalIAbmeansub=FinalIAb;
bg=bg';

%Display and save a blood Vessel Map
bgTemp=mat2gray(bg);
bgTemp=adapthisteq(bgTemp);
f=figure;  imshow(bgTemp,'initialmagnification',100); axis image;
imwrite(bgTemp,[folder,'RESULT OF ',filebase,'_BloodVesselMapFromOI.tif']);
imwrite(bgTemp,[folder,'RESULT OF ',filebase,'_BloodVesselMapFromOI.bmp']);
title([filebase,' Blood Vessel Map From Imaging ']);

%Display the magnitude map
FinalIAb(FinalIAb<=0)=0;
f=figure;  imshow(FinalIAb,[0 4e-4],'initialmagnification',100); axis image;
title([filebase,' UnSmoothed Magnitude of Responses']);
colormap(gca(f),flipud(gray));
saveas(f,[folder,'RESULT OF ',filebase,'_unSmoothedMagnitude.tif'],'tiffn');

%Smooth the magnitude maps as an option
filter=fspecial('average',[5 5]);
FilterAb=imfilter(FinalIAb,filter);

f=figure;  imshow(FilterAb,[0 4e-4],'initialmagnification',100); axis image;
title([filebase,' Smoothed Magnitude of Responses']);
colormap(flipud(gray));
saveas(f,[folder,'RESULT OF ',filebase,'_SmoothedMagnitude.tif'],'tiffn');


%phase maps/ retinotopy
Ang=angle(FinalI);
f=figure; imshow(Ang,[-pi pi],'Colormap',hsv,'initialmagnification',100); axis image;
title([filebase,' Retinopy / Phase of Responses ']);
saveas(f,[folder,'RESULT OF ',filebase,'_retinotopy.tif'],'tiffn');
end

