% Write a MATLAB script to perform the following tasks.
% a) Read input image peppers.png into a MATLAB variable a.
% b) Display the image and select pixel colors from an object in the input image.
% S = impixel(a) 
% Click the left-mouse button to select N pixels in an object. Press Enter key to stop selecting.
% c) Calculate the mean vector and the covariance matrix of set S.
% d) Generate an output image by processing all pixels in the input image. If the Euclidean distance from a 
% pixel to set S is smaller than threshold , keep the pixel color the same. Otherwise, change the 
% pixel color to white (Red = Green = Blue = 255).
% e) Generate an output image by processing all pixels in the input image. If the Mahalanobis distance from a 
% pixel to set S is smaller than threshold , keep the pixel color the same. Otherwise, change the 
% pixel color to white (Red = Green = Blue = 255). display with the result of part (d).
% f) Test the script for different values for N and and comment on the results

clear; clc;

% a) Read input image peppers.png into a MATLAB variable a.
a = imread('peppers.png');

% b) Display the image and select pixel colors from an object in the input image.
% S = impixel(a)
% Click the left-mouse button to select N pixels in an object. Press Enter key to stop selecting.
imshow(a);
S = impixel(a)

% c) Calculate the mean vector and the covariance matrix of set S.
mean_S = mean(S)
cov_S = cov(S)

% d) Generate an output image by processing all pixels in the input image. If the Euclidean distance from a 
% pixel to set S is smaller than threshold , keep the pixel color the same. Otherwise, change the 
% pixel color to white (Red = Green = Blue = 255).
threshold = 50 % set the threshold value

% reshape a to a 2-D array
a_2d = reshape(a, [], size(a, ndims(a)));

% calculate the Euclidean distance between each pixel in the input image and the mean vector of set S
dist_Euclidean = pdist2(double(a_2d), mean_S)

% create a binary mask based on the threshold value
mask = dist_Euclidean <= threshold;

% create a new image by copying the input image and setting the pixels outside the mask to white
output_Euclidean = a;
output_Euclidean(repmat(~mask, [1 1 3])) = 255;

% display the output image
% imshow(output_Euclidean);

% e) Generate an output image by processing all pixels in the input image. If the Mahalanobis distance from a 
% pixel to set S is smaller than threshold , keep the pixel color the same. Otherwise, change the 
% pixel color to white (Red = Green = Blue = 255). display with the result of part (d).

disp("Shape of 'a':");
disp(size(a));
disp("Shape of 'S':");
disp(size(S));

% calculate the Mahalanobis distance between each pixel in the input image and the mean vector of set S
dist_mahal = zeros(size(a, 1), size(S, 1));
for i = 1:size(a, 1)
    dist_mahal(i, :) = mahal(double(a(i, :)), double(S));
end

% find the minimum distance for each pixel
min_dist_mahal = min(dist_mahal, [], 2);

% create a binary mask based on the threshold value
mask = min_dist_mahal <= threshold;

% create a new image by copying the input image and setting the pixels outside the mask to white
output_mahal = a;
output_mahal(repmat(~mask, [1 1 3])) = 255;

% display the output image
% imshow(output_mahal);

% display the output images using subplot
figure
subplot(1,2,1)
imshow(output_Euclidean)
title('Output using Euclidean distance')

subplot(1,2,2)
imshow(output_mahal)
title('Output using Mahalanobis distance')

% f) Test the script for different values for N and and comment on the results