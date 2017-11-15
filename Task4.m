% MATLAB script for Assessment Item-1

% Task-4
clear; 
close all; 
clc;

% Task One - Load in Image
image = imread('Starfish.jpg');
greyscaleImage = im2double(rgb2gray(image));

medFiltImage = medfilt2(greyscaleImage, [5 5]);


figure;
subplot(1,2,1);
imshow(image);
title('Unedited Image')

subplot(1,2,2);
imshow(greyscaleImage);
title('Greyscale Image')
