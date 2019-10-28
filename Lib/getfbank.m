% funzione per divisione in bande d'ottava
function [fbank, cent] = getfbank(F) % F è l'asse delle frequenze da 0 a 5500
    bw=100; % larghezza banda è 4 (con sovrspposizione), questa è metà banda, "passo" di sovrapposizione    
    low=f2mel(F(1)); % da frequenze in Hz a semitoni
    high=f2mel(F(end));
    nband=floor((high-low)/bw-1); % trovo il numero di bande, contando la sovrapposizione 
    cent=linspace(1,nband,nband).*bw; % ma non dovrebbe spostarsi di due passi, per sovrapposizione? si
    inferiori=mel2f(cent-bw); % array in cui vengono immagazzinati gli indici inferiori
    superiori=mel2f(cent+bw); % array in cui vengono immagazzinati gli indici superiori
    n = size(F,2); % numero di righe, dato dal range di frequenze del segnale 
    fbank=zeros(n,nband); % inizializzo la matrice 
    for b=1:nband 
        il=findx(F, inferiori(b)); % ritorna il valore di F più vicino al valore contenuto nell'array inferiori all'indice b
        ih=findx(F, superiori(b)); % dunque cerca sull'asse delle frequenze dove posizionare i valori inferiori e superiori 
                                   % cercando il valore più vicino a quello contenuto in ineriori(b) e superiori(b)
        fbank(il:ih,b)=triang(ih-il+1);
    end;
    
end

function mel = f2mel(f)
% funzione che converte una frequenza in Hertz ad una frequenza in scala
% Mel
    mel=2595*log10(1+f/700);
end

function f = mel2f(mel)
% funzione che converte una frequenza in scala Mel ad una frequenza in Hertz
    f=700*( ( 10.^(mel/2595) )-1 );
end

function indx = findx(X, val)
% Dato un array X e un valore val ritorna l'indice di X in cui è contenuto
% il numero più vicino a val
    X = abs(X-val); 
    [~, indx] = min(X); 
end