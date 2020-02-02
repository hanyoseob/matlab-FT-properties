%% Reference
% https://en.wikipedia.org/wiki/Fourier_transform

%%
clear;

%% Generate FFT function handler
FFT    	= @(x)  fftshift(fft2(ifftshift(x)));
IFFT    = @(y)  ifftshift(ifft2(fftshift(y)));

%% 4) 1D Convolution vs. Multiplication
N   = 100;
M   = 36;

X   = randn(N, 1);
Y   = randn(M, 1);

if (N > M)
    K   = max(64,2^nextpow2(2*N));
else
    K   = max(64,2^nextpow2(2*M));
end

X_      = X;
X_(K)   = 0;

Y_      = Y;
Y_(K)   = 0;

Z       = conv(X, Y, 'same');
Z_      = ifft(fft(X_).*fft(Y_));
Z_      = Z_(floor(M/2) + 1:N + floor(M/2));

%% Display
figure('name', '1D Convolution vs. Multiplication');
suptitle('1D Convolution vs. Multiplication');
subplot(221);   plot(X);            title([num2str([N, 1], '%d x %d') ' Source line']);
subplot(222);   plot(Y);            title([num2str([M, 1], '%d x %d') ' Kernel line']);
subplot(223);   plot(Z, 'g-');      hold on;
                plot(Z_, 'r--');    hold off;
legend('1D convolution in spatial domain', 'Multiplication in Fourier domain');
title('1D convolution in spatial domain vs. Multiplication in Fourier domain');
subplot(224);   plot(Z - Z_);       title('Difference ( <= 1e-14 )');
