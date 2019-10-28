function [x] = NoSilenzio(filename, framesize, valTres, segnale, fase)
    [x, Fs]=audioread(filename);
    x = mean(x,2);
    x = silenceremoval(x, floor(Fs*framesize), valTres);
    [filename, address] = salvaSilenziati(x, segnale, filename, fase);
end