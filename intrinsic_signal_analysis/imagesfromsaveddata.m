
    filter=fspecial('average',[5 5]);
    FilterAb=imfilter(FinalIAbmeansub,filter);

    %thresh=FilterAb
    masked=FilterAb>=0*max(max(FilterAb));
    thresh=FilterAb.*masked;
    figure;  imshow(thresh,[0 4e-4],'initialmagnification',200);; axis image;
    colormap(flipud(gray))
   
    Ang=angle(FinalI);
    figure; imshow(Ang,[-pi pi],'Colormap',hsv,'initialmagnification',200); axis image;