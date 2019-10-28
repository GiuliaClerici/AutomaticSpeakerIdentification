function [ y, F ] = stft( x, Fs, framesize, overlap )
% funzione che calcola la short-time fourier transform del segnale  

nbin = floor(framesize/2)+1; 
xb = buffer(x,framesize,overlap);
window = hanning(framesize);
xb = bsxfun(@times,xb,window);
y=fft(xb);   % fast fourier transform
y = y(1:nbin,:)/framesize; % taglio e scalo la parte simmetrica
y(2:end-1,:) = y(2:end-1,:) * 2; % recupero energia dopo scarto di valori precedente
F = linspace(0, Fs/2, nbin);

end

