function[speaker, P, allP] = matching(coeff, GMMdb)
% funzione che implementa la fase di test 

% calcolo, data la lambda della registrazione di test, la probabilit� per ogni lambda del DB e cerco la pi� alta 
[numParlanti, ~ ] = size(GMMdb); % calcolo numero di righe in lambdaDB =numParlanti 
P = -inf; % inizializzo la variabile che conterr� la probabilit� a posteriori massima trovata 
allP = zeros(numParlanti,1);
for n=1:numParlanti
      P1 = sum(log(pdf(GMMdb{n,2},coeff)));
    % P1=posterior(GMMdb{n,2},coeff); % calcolo la probabilit� a posteriori di ogni osserv. 
    % P1 = mean(P1,2); % probabilit� che ogni osservazione apartenga al MODELLO (andr� comunque da 0 a 1)
    % P1 = mean(P1); % probabilit� che tutta la registrazione appartenga ad un modello
    % Pm = mean(P1(:)); % andr� comunque sempre da 0 a 1
    allP(n) = P1;
    if P1 > P   % non so se la probabilit� a posteriori pi� alta sia gi� calcolata da posterior 
        P = P1;
        speaker = GMMdb{n,1};
    end;
    
end;
% allP = (allP - mean(allP))/std(allP);

% allP = (allP - mean(allP)); 

end