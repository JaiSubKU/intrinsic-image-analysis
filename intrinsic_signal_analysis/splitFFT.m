function [ FinalIsection, FinalIAbsection ] = splitFFT(i, stopping, Height, numsamples, location)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

if i>=1 && i<=125
    imagearray1=matfile('imagearray1.mat','Writable',true);
    FFTresult=fft(imagearray1.startmat(i:stopping,1:Height,1:numsamples),[],3);
elseif i>=126 && i<=250
    imagearray2=matfile('imagearray2.mat','Writable',true);
    FFTresult=fft(imagearray2.startmat(i-125:stopping-125,1:Height,1:numsamples),[],3);
elseif i>=251 && i<=375
    imagearray3=matfile('imagearray3.mat','Writable',true);
    FFTresult=fft(imagearray3.startmat(i-250:stopping-250,1:Height,1:numsamples),[],3);
elseif i>=376
    imagearray3=matfile('imagearray3.mat','Writable',true);
    FFTresult=fft(imagearray3.startmat(i-250:stopping-250,1:Height,1:numsamples),[],3);
end

FFTresultAb=FFTresult;
maxZ=length(FFTresult(1,1,:));
zerofrequency=FFTresult(:,:,1);
zerofrequency=repmat(zerofrequency,[1 1 maxZ]);
%
%FFTresultAb=abs((abs(zerofrequency)-abs(FFTresult)))./abs(zerofrequency);
FFTresultAb=abs(((FFTresult)))./(zerofrequency);
%FFTresultAb2=((FFTresult)-(zerofrequency))./(zerofrequency);


FinalIsection=FFTresult(:,:,location);
FinalIAbsection=FFTresultAb(:,:,location);


end

