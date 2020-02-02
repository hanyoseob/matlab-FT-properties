%% Reference
% https://en.wikipedia.org/wiki/Fourier_transform

%%
clear;

%% Generate FFT function handler
FFT    	= @(x)  fftshift(fft2(ifftshift(x)));
IFFT    = @(y)  ifftshift(ifft2(fftshift(y)));

%% 1) Linearity
% a*f(x) + b*g(x) <== Fourier Transform ==> a*FFT(f(x)) + b*FFT(g(x))
N       = 512;

X       = phantom(N);
X_fft   = FFT(X);

X1      = X.*(X > 0.95 & X < 1.05);
X2      = X.*(X > 0.35 & X < 0.45);
X3      = X.*(X > 0.25 & X < 0.35);
X4      = X.*(X > 0.15 & X < 0.25);
X5      = X.*(X > 0.05 & X < 0.15);

X0      = X1 + X2 + X3 + X4 + X5;

X1_fft  = FFT(X1);
X2_fft  = FFT(X2);
X3_fft  = FFT(X3);
X4_fft  = FFT(X4);
X5_fft  = FFT(X5);

% X0_fft  = FFT(X0);
X0_fft  = X1_fft + X2_fft + X3_fft + X4_fft + X5_fft;

%% Display
wndImg  = [0, 1];
wndFFT  = [0, 10];

figure('name', 'Linearity'); 
colormap(gray(256));

subplot(3,7,1);     imagesc(X, wndImg);                             axis image off;     title('Ground truth : X');
subplot(3,7,2);     imagesc(X0, wndImg);                            axis image off;     title('X0 = \Sigma_1^5X_i');
subplot(3,7,3);     imagesc(X1, wndImg);                            axis image off;     title('X1');
subplot(3,7,4);     imagesc(X2, wndImg);                            axis image off;     title('X2');
subplot(3,7,5);     imagesc(X3, wndImg);                            axis image off;     title('X3');
subplot(3,7,6);     imagesc(X4, wndImg);                            axis image off;     title('X4');
subplot(3,7,7);     imagesc(X5, wndImg);                            axis image off;     title('X5');

subplot(3,7,8);     imagesc(log(abs(X_fft)), wndFFT);             	axis image off;     title('Ground truth : FFT(X)');
subplot(3,7,9);     imagesc(log(abs(X0_fft)), wndFFT);              axis image off;     title('FFT(X0) = \Sigma_1^5FFT(X_i)');
subplot(3,7,10);    imagesc(log(abs(X1_fft)), wndFFT);              axis image off;     title('FFT(X1)');
subplot(3,7,11);    imagesc(log(abs(X2_fft)), wndFFT);              axis image off;     title('FFT(X2)');
subplot(3,7,12);    imagesc(log(abs(X3_fft)), wndFFT);              axis image off;     title('FFT(X3)');
subplot(3,7,13);    imagesc(log(abs(X4_fft)), wndFFT);              axis image off;     title('FFT(X4)');
subplot(3,7,14);    imagesc(log(abs(X5_fft)), wndFFT);              axis image off;     title('FFT(X5)');

% subplot(3,7,15);    imagesc(log(abs(X_fft - X_fft)), wndFFT);     	axis image off;
subplot(3,7,16);    imagesc(log(abs(X_fft - X0_fft)), wndFFT);      axis image off;     title('FFT(X) - FFT(X0)');
subplot(3,7,17);    imagesc(log(abs(X_fft - X1_fft)), wndFFT);      axis image off;     title('FFT(X) - FFT(X1)');
subplot(3,7,18);    imagesc(log(abs(X_fft - X2_fft)), wndFFT);      axis image off;     title('FFT(X) - FFT(X2)');
subplot(3,7,19);    imagesc(log(abs(X_fft - X3_fft)), wndFFT);      axis image off;     title('FFT(X) - FFT(X3)');
subplot(3,7,20);    imagesc(log(abs(X_fft - X4_fft)), wndFFT);      axis image off;     title('FFT(X) - FFT(X4)');
subplot(3,7,21);    imagesc(log(abs(X_fft - X5_fft)), wndFFT);      axis image off;     title('FFT(X) - FFT(X5)');
