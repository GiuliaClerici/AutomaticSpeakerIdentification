function[] = loadDB(filenameDB, filenameDBergodico)
 if exist(filenameDB,'file')==2            % se il file esiste
    load(filenameDB);                      % lo carico
 else                                      % altrimenti
    disp('Errore! Non esiste il database, prima eseguire fase di learning.');
 end; 
 if exist(filenameDBergodico,'file')==2    % se il file esiste
    load(filenameDBergodico);              % lo carico
 else                                      % altrimenti
    disp('Errore! Non esiste il database per il modello ergodico, prima eseguire fase di learning.');
 end; 
end