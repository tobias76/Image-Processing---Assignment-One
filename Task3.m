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

%Arrays
smoothedImage = uint8(size(image));
medFiltImage = uint8(size(image));
medSortArray = [1,25];
x = zeros(paddedCols, paddedRows);

% This allocates the image pixels from three in to account for padding.
x(1+2:end-2,1+2:end-2) = image;

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
                
                % Two Two Little Quick Sorts - Very Slow
%                 pivotPoint = medSortArray(end);
%                 medSortArray(end) = [];
%                 
%                 lessArray = medSortArray(medSortArray <= pivotPoint);
%                 greaterArray = medSortArray(medSortArray > pivotPoint);
%                 
%                 medSortArray = [lessArray pivotPoint greaterArray];
%                                
%                 sum = size(medSortArray) / 2;
                
                
            end
        end
        medianValue = median(medSortArray);
        smoothedImage(row-2, col-2) = sum;
        medFiltImage(row-2, col-2) = medianValue;
    end
end

% Final Task - Display Images

figure;
subplot(2,2,1);
imshow(image);
title('Original Image');

subplot(2,2,2);
imshow(smoothedImage);
title('Averaged Image');

subplot(2,2,3);
imshow(medFiltImage);
title('Median Filtered Image');

