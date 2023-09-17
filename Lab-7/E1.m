% Write a MATLAB script to process color image peppers.png.
% - Calculate the number of distinct colors n that appear the image. Hint: Use MATLAB function unique to 
% find the distinct rows or columns in a matrix. Study the online documentation of this function.
% - Apply minimum variance quantization to reduce the number of distinct colors by half and save the output 
% image as peppers_quantized.bmp. 
% - Compare the input and quantized image by displaying them side-by-side.

clear; clc;

% Read the image
img = imread('peppers.png');

class(img)
size(img)
% Calculate the number of distinct colors
uniqueimg = unique(reshape(img,[],3),'rows');
n_colours = size(uniqueimg,1)


% Apply minimum variance quantization to reduce the number of distinct colors by half
img_quantized = imquantize(img, linspace(0, 1, n_colours/2)); % apply minimum variance quantization to reduce the number of distinct colors by half

% Save the output image as peppers_quantized.bmp
imwrite(img_quantized, 'peppers_quantized.bmp');


% Display the images side-by-side
figure;
subplot(1,2,1);
imshow(img);
title('Original Image');
subplot(1,2,2);
imshow(img_quantized);
title('Quantized Image');
clear;