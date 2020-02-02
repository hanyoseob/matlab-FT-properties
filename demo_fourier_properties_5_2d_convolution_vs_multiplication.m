%% Reference
% https://en.wikipedia.org/wiki/Fourier_transform

%%
clear;

%% Generate FFT function handler
FFT    	= @(x)  fftshift(fft2(ifftshift(x)));
IFFT    = @(y)  ifftshift(ifft2(fftshift(y)));

%% 5) 2D Convolution vs. Multiplication
N   = 256;
M   = 36;

X   = phantom(N);
Y   = fspecial('gaussian', [M, M], 3);

if (N > M)
    K   = max(64,2^nextpow2(2*N));
else
    K   = max(64,2^nextpow2(2*M));
end

X_      = X;
X_(K, K)= 0;

Y_      = Y;
Y_(K, K)= 0;

Z       = conv2(X, Y, 'same');
Z_      = ifft2(fft2(X_).*fft2(Y_));
Z_      = Z_(floor(M/2) + 1:N + floor(M/2), floor(M/2) + 1:N + floor(M/2));

wndImg  = [0, 1];

%% Display
figure('name', '2D Convolution vs. Multiplication');
colormap(gray(256));

suptitle('2D Convolution vs. Multiplication');
subplot(231);   imagesc(X, wndImg);     colorbar;   axis image off; title([num2str([N, N], '%d x %d') ' Source image']);
subplot(232);   imagesc(Y);             colorbar;   axis image off; title([num2str([M, M], '%d x %d') ' Kernel image']);

subplot(234);   imagesc(Z, wndImg);     colorbar;   axis image off; title('Spatial 2D convolution');
subplot(235);   imagesc(Z_, wndImg);    colorbar;   axis image off; title('Fourier multiplication');
subplot(236);   imagesc(Z - Z_);    	colorbar;   axis image off; title('Difference ( <= 1e-14 )');

