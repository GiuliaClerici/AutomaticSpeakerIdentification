function [ mfc ] = mfcc( stft, F )
% funzione che calcola i coefficenti cepstrali Mel 
    psd = abs(stft).^2; % spettro di potenza
    fbank = getfbank(F); % calcolo il filter bank 
    formants = applyfbank(psd,fbank); % applico il filterbank al segnale 
    formants = log(formants+eps); % sommo eps, valore molto piccolo, in modo tale che se ci sia silenzio, dunque il valore sia 0,
                                  % il logaritmo non dia come risultato meno infinito
    mfc = dct(formants); % trasformata discreta di Fourier 
end

