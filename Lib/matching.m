function[speaker, P, allP] = matching(coeff, GMMdb)
% funzione che implementa la fase di test 

% calcolo, data la lambda della registrazione di test, la probabilità per ogni lambda del DB e cerco la più alta 
[numParlanti, ~ ] = size(GMMdb); % calcolo numero di righe in lambdaDB =numParlanti 
P = -inf; % inizializzo la variabile che conterrà la probabilità a posteriori massima trovata 
allP = zeros(numParlanti,1);
for n=1:numParlanti
      P1 = sum(log(pdf(GMMdb{n,2},coeff)));
    % P1=posterior(GMMdb{n,2},coeff); % calcolo la probabilità a posteriori di ogni osserv. 
    % P1 = mean(P1,2); % probabilità che ogni osservazione apartenga al MODELLO (andrà comunque da 0 a 1)
    % P1 = mean(P1); % probabilità che tutta la registrazione appartenga ad un modello
    % Pm = mean(P1(:)); % andrà comunque sempre da 0 a 1
    allP(n) = P1;
    if P1 > P   % non so se la probabilità a posteriori più alta sia già calcolata da posterior 
        P = P1;
        speaker = GMMdb{n,1};
    end;
    
end;
% allP = (allP - mean(allP))/std(allP);

% allP = (allP - mean(allP)); 

end