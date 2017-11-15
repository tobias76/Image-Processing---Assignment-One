% MATLAB script for Assessment Item-1

% Task-4
clear; 
close all; 
clc;

% Task One - Load in Image
image = imread('Starfish.jpg');
greyscaleImage = im2double(rgb2gray(image));

medFiltImage = medfilt2(greyscaleImage, [5 5]);
boxFiltImage = imboxfilt(greyscaleImage, [5 5]);
gaussianFiltImage = imgaussfilt(greyscaleImage);
averageFiltImage = imfilter(greyscaleImage, fspecial('average', 3));

for X = 1:size(greyscaleImage,1) - 2
    for Y = 1:size(greyscaleImage,2) - 2
        
        % Find the sobel for the X-Axis
        xMask = ((2 * medFiltImage(X + 2, Y + 1) + medFiltImage(X + 2 , Y) + medFiltImage(X+2, Y+2))-(2 * medFiltImage(X, Y + 1) + medFiltImage(X, Y) + medFiltImage(X,Y+2)));
        
        % Find the sobel for the Y-Axis
        yMask = ((2 * medFiltImage(X + 1 ,Y + 2) + medFiltImage(X,Y + 2)+ medFiltImage(X + 2,Y + 2))- (2*medFiltImage(X + 1,Y)+ medFiltImage(X,Y) + medFiltImage(X + 2,Y)));
        
        % Find the image gradient
        
        % Add together the absolute values
        imageOut(X, Y) = abs(xMask) + abs(yMask);
        
        % Find the square root of the xMask + the yMask (both squared)
        imageOut(X, Y) = sqrt(xMask ^2 + yMask ^2);
        
       xApply(X, Y) = abs(xMask);
       yApply(X, Y) = abs(yMask);
    end
end

for X = 1:size(greyscaleImage,1) - 2
    for Y = 1:size(greyscaleImage,2) - 2
        if imageOut(X, Y) >= 0.16 && imageOut(X, Y) <= 0.4
            imageOutNew(X, Y) = 255;
        end
   end
end
figure('Name','Base Image Prep');
subplot(1,2,1);
imshow(image);
title('Unedited Image')

subplot(1,2,2);
imshow(greyscaleImage);
title('Greyscale Image')

figure('Name', 'Filter Comparison')
subplot(2,2,1);
imshow(medFiltImage);
title('Median Filtered Image');

subplot(2,2,2);
imshow(boxFiltImage);
title('Box Filtered Image');

subplot(2,2,3);
imshow(gaussianFiltImage);
title('Guassian Filtered Image');

subplot(2,2,4);
imshow(averageFiltImage);
title('Average Filtered Image');

figure;
subplot(2,1,1);
imshow(imageOut);
subplot(2,1,2);
imshow(imageOutNew);
