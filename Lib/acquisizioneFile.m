function[coeff] = acquisizioneFile(filename, framesize, overlap, target_Fs, pef, mfcc_utili)
           [x, Fs]=audioread(filename); % leggo il file audio
            x = mean(x,2);
            
            x = resample(x,target_Fs,Fs); % ricampiono il segnale a 11kHz 
            Fs = target_Fs; % reimposto la frequenza di campionamento a quella utilizzata per il ricampionamento 

            framesize = framesize * Fs;
            overlap = overlap * Fs; 
            
            x=filter(1,pef,x); % filtro di pre-enfasi

            [X, F] = stft(x, Fs, framesize, overlap); % short-time Fourier transform

            coeff = mfcc(X,F); % calcolo coefficienti cepstrali 
            coeff = coeff(mfcc_utili,:); % prendo in considerazione i coefficienti cepstrali utili all'analisi (ovvero, nel caso del parlato, i primi 12 escluso il primo)
            coeff = coeff.'; % opp. solo coeff=coeff' ? trasposizione della matrice (righe: osservazioni, colonne: variabili; per input corretto di fitgmdist) 
 
end