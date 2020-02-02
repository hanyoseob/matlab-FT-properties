%% Reference
% https://en.wikipedia.org/wiki/Fourier_transform

%%
clear ;
close all;
home;

%% 1) Linearity
% a*f(x) + b*g(x) <== Fourier Transform ==> a*FFT(f(x)) + b*FFT(g(x))
demo_fourier_properties_1_linearity();

%% 2) Shift in spatial domain
% f(x - a) <== Fourier Transform ==> exp(-j*2pi*a*kx) * FFT(f(x))
demo_fourier_properties_2_shift_in_spatial_domain();

%% 3) Shift in Fourier domain
% exp(j*2pi*a*x) * f(x) <== Fourier Transform ==> FFT(f(x))(kx - a)
demo_fourier_properties_3_shift_in_Fourier_domain();

%% 4) 1D Convolution vs. Multiplication
demo_fourier_properties_4_1d_convolution_vs_multiplication();

%% 5) 2D Convolution vs. Multiplication
demo_fourier_properties_5_2d_convolution_vs_multiplication();
