close all;
clear all;

% Load the image
I = imread('street.jpg');
% Convert into a two dimensional array of doubles
I = im2double(I);

% Compress with different tolerance
[Y1,drop1] = Compress(I,0.0007625);
[Y2,drop2] = Compress(I,0.003246);
[Y3,drop3] = Compress(I,0.013075);
[Y4,drop4] = Compress(I,0.03924);

% Calculate the error for each compression
nms_error1 = sqrt(mean2((Y1-I).^2)/(mean2(I).^2));
nms_error2 = sqrt(mean2((Y2-I).^2)/(mean2(I).^2));
nms_error3 = sqrt(mean2((Y3-I).^2)/(mean2(I).^2));
nms_error4 = sqrt(mean2((Y4-I).^2)/(mean2(I).^2));

drop = [drop1,drop2,drop3,drop4];
nms_error = [nms_error1,nms_error2,nms_error3,nms_error4];

subplot(2,2,1), imshow(Y1);
title({'Compressed image with tol = 0.0007625';
      ['resulting a drop ratio of ',num2str(drop1,'%0.2f')]});

subplot(2,2,2), imshow(Y2); 
title({'Compressed image with tol = 0.003246';
      ['resulting a drop ratio of ',num2str(drop2,'%0.2f')]});

subplot(2,2,3), imshow(Y3); 
title({'Compressed image with tol = 0.013075';
      ['resulting a drop ratio of ',num2str(drop3,'%0.2f')]});

subplot(2,2,4), imshow(Y4); 
title({'Compressed image with tol = 0.03924';
      ['resulting a drop ratio of ',num2str(drop4,'%0.2f')]});

figure
plot(nms_error,drop);
title('The error vs. drop ratio plot for the DFT compressed images');
xlabel('Normalized Mean Square Error');
ylabel('Drop Ratio');

