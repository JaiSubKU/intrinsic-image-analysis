result=testing;
tic

for i=1:length(testing(1,1,:))

    %Start is set first. If start is below 1 I set start equal to 1. if
    %start greater than 50 but end is less than 50 away I set end equal to
    %the last value. otherwise start will be 50 below current frame and 49
    %above it. 
    start=i-50;
    if start <1
       start=1;
       ending=i+49;
    elseif i+49> length(testing(1,1,:)) 
        ending=length(testing(1,1,:));
    else
        ending=i+49;
    end
    if mod(i,100)==0
        disp(['start: ', num2str(start), ' end: ',num2str(ending)])
    end
    result(:,:,i)=mean(testing(:,:,start:ending),3);
    
    
end
toc.
pixel=[15,15];
figure; plot([1:3000],reshape(testing(pixel(1),pixel(2),:),[1 3000]))
hold on
plot([1:3000],reshape(result(pixel(1),pixel(2),:),[1 3000]),'r')
hold off

