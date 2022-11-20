function ActiveFFTmonitor_updated_4_Jai(handles)


profile on;
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
tim1=tic;
disp(['getting started...Be done in a jiffy'])
    warning('off','all');
    loadedFile=TIFFStack(filenamein);
    %Turn from row vector into 3d movie matrix
    loadedFile=loadedFile(:,:,:);
toc(tim1);


%%

disp('FFT started. About a minute left');
tim1=tic;

FinalI=[];%ones(Width,Height,length(location));
FinalIAb=[];%ones(Width,Height,length(location));
bg=[];


% fix in case the image size is uneven

FFTresult=fft(loadedFile,[],3);
warning('on','all'); 


zerofrequency=repmat(FFTresult(:,:,1),[1 1 NFrames]);
FFTresultAb=abs(FFTresult./zerofrequency);

bg=[bg;FFTresult(:,:,1)];
FinalI=[FinalI;FFTresult(:,:,location)];
FinalIAb=[FinalIAb;FFTresultAb(:,:,location)];


toc(tim1);
%%

%Transpose FinalI since the oi files I read from have a different way of
%storing data that result in the image being roatated wrong otherwise
FinalI=FinalI';
FinalIAb=FinalIAb';
FinalIAbmeansub=FinalIAb;
bg=bg';

%Save raw info and an image of the vessel map
[folder,filebase,~]=fileparts(filenamein);
save ([folder,'RESULT OF ',filebase,'.mat'], 'FinalI*')
csvwrite([folder,'Text Image of vessels for ImageJ import ',filebase,'.csv'],bg);





%Display a blood Vessel Map
bgTemp=mat2gray(bg);
bgTemp=adapthisteq(bgTemp);
f=figure;  imshow(bgTemp,'initialmagnification',100); axis image;
imwrite(bgTemp,[folder,'RESULT OF ',filebase,'_BloodVesselMapFromOI.tif']);
imwrite(bgTemp,[folder,'RESULT OF ',filebase,'_BloodVesselMapFromOI.bmp']);
title([filebase,' Blood Vessel Map From Imaging ']);

%Display the magnitude map
FinalIAb(FinalIAb<=0)=0;
f=figure;  imshow(FinalIAb,[0 .001],'initialmagnification',100); axis image;
title([filebase,' UnSmoothed Magnitude of Responses']);
colormap(gca(f),flipud(gray));
saveas(f,[folder,'RESULT OF ',filebase,'_unSmoothedMagnitude.tif'],'tiffn');
%Converting to a int 16 image by multiplying percentages times max value
%for 16 bits
imwrite(uint16(FinalIAb*2^16-1),[folder,'RESULT OF ',filebase,'_unSmoothedMagnitude_ScaledData.tif']);
%saving raw data as a csv file that can be imported to imageJ as a text
%image
csvwrite([folder,'RESULT OF ',filebase,'_unSmoothedMagnitude_CSV.csv'],FinalIAb);



%Smooth the magnitude maps as an option

filter=fspecial('average',[5 5]);
FilterAb=imfilter(FinalIAb,filter);


f=figure;  
%imshow(FilterAb,[0 4e-4],'initialmagnification',100); axis image;

%adjust display range here
imshow(FilterAb,[0 .001],'initialmagnification',100); axis image;

title([filebase,' Smoothed Magnitude of Responses']);
colormap(flipud(gray));
saveas(f,[folder,'RESULT OF ',filebase,'_SmoothedMagnitude.tif'],'tiffn');

%Converting to a int 16 image by multiplying percentages times max value
%for 16 bits
imwrite(uint16(FilterAb*2^16-1),[folder,'RESULT OF ',filebase,'_SmoothedMagnitude_ScaledData.tif']);
%saving raw data as a csv file that can be imported to imageJ as a text
%image
csvwrite([folder,'RESULT OF ',filebase,'_SmoothedMagnitude_CSV.csv'],FilterAb);



%phase maps/ retinotopy
Ang=angle(FinalI);
f=figure; imshow(Ang,[-pi pi],'Colormap',hsv,'initialmagnification',100); axis image;
title([filebase,' Retinopy / Phase of Responses ']);
saveas(f,[folder,'RESULT OF ',filebase,'_retinotopy.tif'],'tiffn');
profile viewer;
end

