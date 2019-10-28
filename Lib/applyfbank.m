function [ formants ] = applyfbank( x, fbank )
% Funzione che permette di applicare il filter bank ottenuto allo spettro
% del segnale in analisi, dividendolo in bande 

    nframes = size(x,2);
    nbands = size(fbank,2);

    formants = zeros(nbands,nframes);

    for t = 1:nframes
        for b = 1:nbands
            formants(b,t) = sum(x(:,t) .* fbank(:,b)); 
        end;
    end

end

