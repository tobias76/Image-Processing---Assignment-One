% MATLAB script for Assessment Item-1

% Task-4
clear; 
close all; 
clc;

% Task One - Load in Image
image = im2double(rgb2gray(imread('Starfish.jpg')));

image = medfilt2(image);

imshow
imageRows = size(image, 1);
imageCols = size(image, 2);

for X = 1:imageRows - 2
    for Y = 1:imageCols - 2
         % Find the sobel for the X-Axis
        xMask = ((2 * image(X + 2, Y + 1) + image(X + 2 , Y) + image(X+2, Y+2))-(2 * image(X, Y + 1) + image(X, Y) + image(X,Y+2)));
        
        % Find the sobel for the Y-Axis
        yMask = ((2 * image(X + 1 ,Y + 2) + image(X,Y + 2)+ image(X + 2,Y + 2))- (2*image(X + 1,Y)+image(X,Y) + image(X + 2,Y)));
    
        imageOut(X, Y) = abs(xMask) + abs(yMask);
   
        xMaskApply(X, Y) = abs(xMask);
        yMaskApply(X, Y) = abs(yMask);
    end
end

imshow(imageOut);

