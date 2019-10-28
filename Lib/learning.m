function[GMMdb]=learning(coeff, filenameDB, filename, M) 
    % aggiungo la registrazione alla lista di file già utilizzati in fase
    % di learning 
    
    % Parte di controllo registrazioni
    % filenameReg='fileListaReg.mat'; % file contenente la lista di registrazioni già utilizzate per la fase di learning 
    % load(filenameReg);              % lo carico in modo da ottenere listaReg, non controllo se esiste perché già fatto in script base 
    % listaReg = aggiornaListaReg(listaReg,filename,newSpeaker); % aggiorno la lista di registrazioni utilizzate in fase learning
    % save(filenameReg,'listaReg');   % salvo la lista aggiornata

    % calcolo o aggiornamento di lambda        
    if exist(filenameDB,'file')==2            % se il file esiste
        load(filenameDB);                     % lo carico
    else                                      % altrimenti
        GMMdb = creaDBvuoto(filenameDB);   % creo il database
    end;                                      % una volta aperto il file DB
    GMMdb = addLambda(GMMdb, filenameDB, coeff, M, filename);  % aggiungo la nuova lambda
    save(filenameDB,'GMMdb');              % aggiorno il file (sovrascrivo) con la lambdaDB completa di tutti i parlanti, compreso il nuovo      
    
end