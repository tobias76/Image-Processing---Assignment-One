% MATLAB script for Assessment Item-1

% Task-2
clear; 
close all;
clc;

% Step One - Read in the Image
image = imread('SC.png');

% Save a second for point processing
imageOne = image;

% Step Two - Loop through the Array
for row = 1:size(image,1)
    for col = 1:size(image,2)
        if image(row, col) >= 80 && image(row, col) <= 100
            imageOne(row, col) = 220;
        end
    end
end

figure;
subplot(1,2,1);
imshow(image);
title('Original Image');

subplot(1,2,2);
imshow(imageOne);
title('Point Processed Image');
