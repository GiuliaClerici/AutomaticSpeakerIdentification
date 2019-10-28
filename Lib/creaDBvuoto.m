function[GMMdb]=creaDBvuoto(filenameDB)
% funzione che crea il file di database di lambda, in cui memorizzare i
% valori di lambda per i diversi parlanti
    GMMdb=cell(1,2); % crea matrice vuota di dimensioni 1-4, inizio a creare l'impostazione di lambdaDB
    save(filenameDB,'GMMdb');    
end