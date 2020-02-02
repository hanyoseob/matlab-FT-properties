%% Reference
% https://en.wikipedia.org/wiki/Fourier_transform

%%
clear;

%% Generate FFT function handler
FFT    	= @(x)  fftshift(fft2(ifftshift(x)));
IFFT    = @(y)  ifftshift(ifft2(fftshift(y)));

%% 2) Shift in spatial domain
% f(x - a) <== Fourier Transform ==> exp(-j*2pi*a*kx) * FFT(f(x))
N       = 512;

X       = phantom(N);
X_fft   = FFT(X);

[mx, my]= meshgrid(1:N, 1:N);

dx      = 100;
dy      = 100;

sht     = exp(-1i*2*pi*(dx/N*mx + dy/N*my));

Y_fft   = sht.*X_fft;
Y       = IFFT(Y_fft);

wndImg  = [0, 1];
wndAng  = [-pi, pi];
wndFFT  = [0, 10];

%% Display
figure('name', 'Shift-property in spatial domain');
colormap(gray(256));

suptitle('Shift-property in spatial domain');
subplot(231);   imagesc(abs(X), wndImg);            axis image off;     title('Ground truth : Magitude');
subplot(232);   imagesc(angle(X), wndAng);          axis image off;     title('Ground truth : Phase');
subplot(233);   imagesc(log(abs(X_fft)), wndFFT);   axis image off;     title('Ground truth : Fourier domain');

subplot(234);   imagesc(abs(Y), wndImg);            axis image off;     title(['Spatial Shift_{(\DeltaX, \DeltaY) =  (' num2str([dx, dy], '%d, %d') ')} : Magitude']);
subplot(235);   imagesc(angle(Y), wndAng);          axis image off;     title(['Spatial Shift_{(\DeltaX, \DeltaY) =  (' num2str([dx, dy], '%d, %d') ')} : Phase']);
subplot(236);   imagesc(log(abs(Y_fft)), wndFFT);   axis image off;     title(['Spatial Shift_{(\DeltaX, \DeltaY) =  (' num2str([dx, dy], '%d, %d') ')} : Fourier domain']);
