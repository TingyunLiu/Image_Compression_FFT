close all;
clear all;

% Load the image
I = imread('street.jpg');
% Convert into a two dimensional array of doubles
I = im2double(I);

% Extract first 16x16 sub-block
top_left = I(1:16,1:16);

% Fast Fourier Transform on 2D dimensional 
TOP_LEFT = fft2(top_left);

subplot(2,1,1),
% Create 3D bar plot
bar3(abs(TOP_LEFT),'white');
title('3D bar plot of Fourier coefficients');

% Zero out the F(1,1)
TOP_LEFT(1,1) = 0;

subplot(2,1,2),
% Create 3D bar plot again
bar3(abs(TOP_LEFT),'white');
title('3D bar plot of Fourier coefficients with F(1,1) been zero out');
