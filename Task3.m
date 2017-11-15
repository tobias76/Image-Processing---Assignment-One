% MATLAB script for Assessment Item-1 Part Three

% Task-3
clear; 
close all; 
clc;

% Task One - Load in and convert the image
image = rgb2gray(imread('Noisy.png'));

% Task Two - Pad the image
paddedCols = size(image, 1) + 4;
paddedRows = size(image, 2) + 4;

medSortArray = [1,25];

sortCounter = 1;

x = zeros(paddedCols, paddedRows);

% This allocates the image pixels from three in.
x(1+2:end-2,1+2:end-2) = image;

smoothedImage = uint8(size(image));

for row = 3:size(image,1)-2
    for col = 3:size(image,2)-2       
        % Kernel Mask n Ting
        sum = 0;
        sortCounter = 0;
        for rows = row-2:row+2
            for cols = col-2:col+2
                sortCounter = sortCounter + 1;
                sum = sum + (1/25 * x(rows, cols));
                
                if sortCounter < 26
                    medSortArray(1, sortCounter) = x(rows + 2, cols + 2);
                end
                
                % Two Two Little Quick Sorts
                pivotPoint = medSortArray(end);
                medSortArray(end) = [];
                
                lessArray = medSortArray(medSortArray <= pivotPoint);
                greaterArray = medSortArray(medSortArray > pivotPoint);
                
                medSortArray = [lessArray pivotPoint greaterArray];
            end
        end
        smoothedImage(row-2, col-2) = sum;
    end
end

imshow(smoothedImage);

% Final Task - Display Image
imshow(image);

