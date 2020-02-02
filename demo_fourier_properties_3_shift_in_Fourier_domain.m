%% Reference
% https://en.wikipedia.org/wiki/Fourier_transform

%%
clear;

%% Generate FFT function handler
FFT    	= @(x)  fftshift(fft2(ifftshift(x)));
IFFT    = @(y)  ifftshift(ifft2(fftshift(y)));

%% 3) Shift in Fourier domain
% exp(j*2pi*a*x) * f(x) <== Fourier Transform ==> FFT(f(x))(kx - a)
N       = 512;

X       = phantom(N);
X_fft   = FFT(X);

[mx, my]= meshgrid(1:N, 1:N);

dx      = 100;
dy      = 100;

sht     = exp(1i*2*pi*(dx/N*mx + dy/N*my));

Y       = sht.*X;
Y_fft   = FFT(Y);

wndImg  = [0, 1];
wndAng  = [-pi, pi];
wndFFT  = [0, 10];

%% Display
figure('name', 'Shift-property in Fourier domain');
colormap(gray(256));

suptitle('Shift-property in Fourier domain');
subplot(231);   imagesc(abs(X), wndImg);            axis image off;     title('Ground truth : Magitude');
subplot(232);   imagesc(angle(X), wndAng);          axis image off;     title('Ground truth : Phase');
subplot(233);   imagesc(log(abs(X_fft)), wndFFT);   axis image off;     title('Ground truth : Fourier domain');

subplot(234);   imagesc(abs(Y), wndImg);            axis image off;     title(['Fourier Shift_{(\DeltaX, \DeltaY) =  (' num2str([dx, dy], '%d, %d') ')} : Magitude']);
subplot(235);   imagesc(angle(Y), wndAng);          axis image off;     title(['Fourier Shift_{(\DeltaX, \DeltaY) =  (' num2str([dx, dy], '%d, %d') ')} : Phase']);
subplot(236);   imagesc(log(abs(Y_fft)), wndFFT);   axis image off;     title(['Fourier Shift_{(\DeltaX, \DeltaY) =  (' num2str([dx, dy], '%d, %d') ')} : Fourier domain']);
