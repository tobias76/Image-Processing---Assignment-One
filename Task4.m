% MATLAB script for Assessment Item-1

% Task-4
clear; 
close all; 
clc;

% Task One - Load in Image
image = imread('Starfish.jpg');
greyscaleImage = rgb2gray(image);

% Different images, filtered to compare the results. Discuss in report.
medFiltImage = medfilt2(greyscaleImage, [5 5]);
boxFiltImage = imboxfilt(greyscaleImage, [5 5]);
gaussianFiltImage = imgaussfilt(greyscaleImage);
averageFiltImage = imfilter(greyscaleImage, fspecial('average', 3));
binarizedImage = zeros(size(medFiltImage));
% Equalise the median filtered image, making it darker and stretching stars
equalisedMedImage = histeq(medFiltImage, 255);
% Thresholded Image
thresholdImage = equalisedMedImage;
% Reveresed Image
reversedImage = zeros(size(thresholdImage));

diskStrel = strel('disk', 1);

% Loop through our equalised image and basically invert it, instead of
% using a grey threshold to give me more control of the values.
for row = 1:size(thresholdImage,1)
    for col = 1:size(thresholdImage,2)
        if thresholdImage(row, col) < 10
            thresholdImage(row, col) = 255;
        end
        
        if thresholdImage(row, col) >= 34 && thresholdImage(row, col) <= 255
           thresholdImage(row, col) = 255; 
        end
    end
end

% Now binarize the image
thresholdImage = imbinarize(thresholdImage);

% Smooth the image again to give us the full stars
medSmoothThresh = medfilt2(thresholdImage, [7 7]);

% Reverse the image so it is white by black
reversedImage = imbinarize(abs(medSmoothThresh - 1));

% Display the boundaries, no holes speeds up the search by preventing the
% search of inside objects. Use BWBoundaries as dictated in the matlab
% documentation, located here: https://uk.mathworks.com/help/images/ref/bwboundaries.html
[imageWithObjects, typeOfSearch] = bwboundaries(logical(reversedImage),'noholes');

figure('Name','Base Image Prep');
subplot(2,1,1);
imshow(image);
title('Unedited Image');

subplot(2,1,2);
imshow(greyscaleImage);
title('Greyscale Image');

figure('Name', 'Filter Comparison')
subplot(2,2,1);
imshow(medFiltImage);
title('Median Filtered [5 x 5] Image');

subplot(2,2,2);
imshow(boxFiltImage);
title('Box Filtered [5 x 5] Image');

subplot(2,2,3);
imshow(gaussianFiltImage);
title('Guassian Filtered Image');

subplot(2,2,4);
imshow(averageFiltImage);
title('Average Filtered Image');

figure('Name', 'Equalisation')
subplot(2,2,1);
imshow(equalisedMedImage);
title('Median Filter + Equalisation Applied');

subplot(2,2,2);
imshow(thresholdImage);
title('Threshold applied');

subplot(2,2,3);
imshow(medSmoothThresh);
title('Threshold + Median Filter of 7 x 7 applied');

figure('Name', 'Final Steps')
subplot(2,2,1);
imshow(reversedImage);
title('Reversed Image');

% Find the objects and display the image
subplot(2,2,2);
title('Shapes with Metrics');

% % Add the boundaries to the objects
hold on

% Loop through the label matrix and allocate boundary to the current
% boundary, then plot this boundary on the image using a white line of the
% size 2pt.
for boundariesLoop = 1:length(imageWithObjects)
  boundary = imageWithObjects{boundariesLoop};
  plot(boundary(:,2), boundary(:,1), 'w', 'LineWidth', 2)
end

labeledImage = bwlabel(reversedImage);
stats = regionprops(logical(labeledImage),'Area','Perimeter','Centroid');

% Obtain the area calculation corresponding to label 'k'
area = [stats.Area];
perimeter = [stats.Perimeter];
centroid = [stats.Centroid];

counter = 0;

for i = 1:2:length(centroid)-1
   counter = counter+1;
   centroidX(counter) = centroid(i);
   centroidY(counter) = centroid(i+1);
end

metric = (4*pi.*area) ./ perimeter.^2;

perimeter(perimeter == 0)= 0.01;

% Find all objects of a certain size
keeperBlobs = find((metric > 0.31) & (metric < 0.34)); 

imshow(reversedImage);

text_image = uint8(reversedImage .* 255);

for i = 1:length(centroidX)
    value = metric(i);
    centroidValue = stats(i).Centroid;
    text_image = insertText(text_image, centroidValue, num2str(round(value,2)));
end

subplot(2,2,2);
imshow(text_image);

finalImage = ismember(labeledImage, keeperBlobs) > 0;

finalImage = imfill(finalImage, 'holes');

subplot(2,2,3);
imshow(finalImage);
title('Final Image');


