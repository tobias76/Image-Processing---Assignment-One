% Setup for use
clear; 
close all; 
clc;

% % Step-1: Load input image & Step-2: Conversion of input image to grey-scale image
I = rgb2gray(imread('Zebra.jpg'));

% Define a  new image and populate it with zeroes
newImageCols = 1836;
newImageRows = 1668;

oldImageRows = 556;
oldImageColumns = 612;

% Create a new array of integers at the correct size
imageNew = uint8(zeros([newImageRows, newImageCols]));

% Figure out the scale of the image
rowScale = round(size(imageNew, 1) / oldImageRows);
colScale = round(size(imageNew, 2) / oldImageColumns);

% Nearest Neighbour Interpolation
for rows = 0:newImageRows-2
  for columns = 0:newImageCols-2
      newPixelR = 1+round(rows / rowScale);
      newPixelC = 1+round(columns / colScale);
      
      nextRow = rows + 1;
      nextCols = columns + 1;
      
      % Set the next value in the image
      imageNew(nextRow, nextCols) = I(newPixelR, newPixelC);
  end
end

imshow(imageNew);
