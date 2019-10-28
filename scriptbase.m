% "Un prototipo per il riconoscimento automatico del parlante"
% Clerici Giulia 

% ricordati di controllare di avere cancellato il file .mat del database
% (se prima avevi fatto learning parlato(o cantato) e ora lo vuoi fare per
% il cantato (o parlato). Oppure li metti tutti insieme? vedi. 
fase = 2; 
unicoTest = 0; % impostato a 1 se voglio fare partire il match solo per un unico file di test
segnale = 'cantato'; % 'parlato' opp. 'cantato'
target_Fs = 11000;    % frequenza con cui ricampionamento
framesize = 0.02; % seconds 
overlap = 0.01; % seconds
valTres = 0.0006; % valore di soglia per rimozione del silenzio db2amp(-20)
ncoeff = 12; % numero di MFCC 
mfcc_utili = 2:13; % quantità di MFCC da acquisire (12 nel caso del parlato, eliminando il primo)
pef = [1,0.7]; % parametri del filtro di preenfasi 
M = 16; % numero di componenti di una GMM 
% filenameDB = 'databaseGMM.mat';
signErgM = zeros(1);
signErgF = zeros(1);
% ergodicoParlato = 'C:\Users\Giulia\Documents\MATLAB\Samples\RegistrazioniTesi\Parlato\Learning\ergodico.wav';
% ergodicoCantato = 'C:\Users\Giulia\Documents\MATLAB\Samples\RegistrazioniTesi\Cantato\Learning\ergodico.wav';
%%
if fase == 1 % fase di learning
    step = 0; % prendo i file da cui devo ancora togliere il silenzio
    [indirizzoCartella, filenameErgodicoM, filenameErgodicoF, filenameDB] = selezioneParametri(segnale, fase, step); 

    % elimino il file ergodico se già esiste
    if exist(filenameErgodicoM) == 2 % se esiste già il file ergodico
        delete(filenameErgodicoM);   % allora lo elimino, altrimenti accoda il nuovo ergodico al vecchio
    end;
    if exist(filenameErgodicoF) == 2 % se esiste già il file ergodico
        delete(filenameErgodicoF);   % allora lo elimino, altrimenti accoda il nuovo ergodico al vecchio
    end;
    
    listing = dir(indirizzoCartella); % qui è la cartella da cui devo togliere il silenzio
    s = size(listing,1);
    for n=3:s
        stringName = listing(n,1).name;
        filename = strcat(indirizzoCartella,'\',stringName);
        x = NoSilenzio(filename, framesize, valTres, segnale, fase); % tolgo il silenzio dalle registrazioni e le salvo in una nuova cartella
    end;
    
    step = 1; % prendo i file da cui ho già tolto il silenzio
    [indirizzoCartella, filenameErgodicoM, filenameErgodicoF, filenameDB] = selezioneParametri(segnale, fase, step);
    listing = dir(indirizzoCartella); % cartella con i file da cui ho già tolto il silenzio
    s = size(listing,1);
    % compongo il file audio ergodico come somma di tutte le registrazioni 
    for a = 3 : s % per ogni file contenuto nella cartella (N.B. l'ergodico non c'è) 
        stringName = listing(a,1).name;
        filename = strcat(indirizzoCartella,'\',stringName); 
        if ~(strcmp(filename,filenameErgodicoM)) && ~(strcmp(filename,filenameErgodicoF))
            if filename(end-4) == 'M'
                [x, Fs]=audioread(filename);  
                signErgM = fileunico(x, signErgM); % compongo il file audio ergodico
            else 
                [x, Fs]=audioread(filename);  
                signErgF = fileunico(x, signErgF); % compongo il file audio ergodico
            end; 
        end;
    end;
    audiowrite(filenameErgodicoM, signErgM, Fs); % salvo il segnale ergodico nella cartella indicata nel path name assoluto 
    audiowrite(filenameErgodicoF, signErgF, Fs);
    
%      coeffErgodico = acquisizioneFile(filenameErgodico, framesize, overlap, target_Fs, pef, mfcc_utili);
%      GMMdb = learning(coeffErgodico, filenameDB, filenameErgodico, M); 
     coeffErgodicoM = acquisizioneFile(filenameErgodicoM, framesize, overlap, target_Fs, pef, mfcc_utili);
     %coeffErgodicoM = coeffErgodicoM.'; 
     GMMdb = learning(coeffErgodicoM, filenameDB, filenameErgodicoM, M);
     coeffErgodicoF = acquisizioneFile(filenameErgodicoF, framesize, overlap, target_Fs, pef, mfcc_utili);
     %coeffErgodicoF = coeffErgodicoF.'; 
     GMMdb = learning(coeffErgodicoF, filenameDB, filenameErgodicoF, M); 

%    GMMdb = learningErg(filenameErgodicoM, filenameErgodicoF, framesize, overlap, target_Fs, pef, mfcc_utili, filenameDB, M);

    listing = dir(indirizzoCartella);
    s = size(listing,1); % ricalcolo i file contenuti nella cartella perché ora c'è anche l'ergodico
    for a = 3:s  % perché i primi due elementi di listing sono '.' e '..' - per ogni file contenuto nella cartella
        stringName = listing(a,1).name;
        filename = strcat(indirizzoCartella,'\',stringName); 
        if ~(strcmp(filename,filenameErgodicoM)) && ~(strcmp(filename,filenameErgodicoF))
            coeff = acquisizioneFile(filename, framesize, overlap, target_Fs, pef, mfcc_utili);
            GMMdb = learning(coeff, filenameDB, filename, M);
        end;
    end;
end;


%%
if fase == 2 % fase di matching 
%         if unicoTest == 1 % se voglio fare il matching solo con un unico file di test 
%             filename = 'C:\Users\Giulia\Documents\MATLAB\Samples\RegistrazioniTesi\Parlato\Test\DavideB_parlato_test.wav'; 
%             step = 0; 
%             [indirizzoCartella, ~, filenameDB] = selezioneParametri(segnale, fase, step);
%             x = NoSilenzio(filename, framesize, valTres, segnale, fase);
%             [ID, Prob, allProb] = testSingolo(filename, filenameDB, framesize, overlap, target_Fs, pef, mfcc_utili);
%         else 
            step = 0; 
            [indirizzoCartella, ~, ~, filenameDB] = selezioneParametri(segnale, fase, step);
            listing = dir(indirizzoCartella);
            s = size(listing,1);
            for n=3:s
                stringName = listing(n,1).name;
                filename = strcat(indirizzoCartella,'\',stringName);
                x = NoSilenzio(filename, framesize, valTres, segnale, fase); % tolgo il silenzio dalle registrazioni e le salvo in una nuova cartella
             end;

            if exist(filenameDB,'file')==2            % se il file esiste
                load(filenameDB);                     % lo carico
            else                                      % altrimenti
                disp('Errore! Non esiste il database, prima eseguire fase di learning.');
            end; 

            NumMod = size(GMMdb,1);
            MatrConf = zeros(NumMod,s-2);
            allmaxscores = zeros(s-2,1);
            j = 0;
            step = 1;
            [indirizzoCartella, filenameErgodico, filenameDB] = selezioneParametri(segnale, fase, step);
            listing = dir(indirizzoCartella);
            s = size(listing,1);
            for a = 3:s  % perché i primi due elementi di listing sono '.' e '..' - per ogni file contenuto nella cartella
                stringName = listing(a,1).name;
                filename = strcat(indirizzoCartella,'\',stringName); 
                coeff = acquisizioneFile(filename, framesize, overlap, target_Fs, pef, mfcc_utili);
                [ID, Prob, allProb] = matching(coeff, GMMdb); % matching con i modelli del DB 

                j = a - 2;
                for i=1:NumMod
                    MatrConf(i,j) = allProb(i,1);
                end; 

                meanProb = mean(MatrConf(:,j));
                for r=1:NumMod
                    MatrConf(r,j) = MatrConf(r,j) - meanProb; 
                end; 
                
                allmaxscores = max(MatrConf,[],1);
                
             end;

            figure
            imagesc(MatrConf)
            hold on 
            [~, indx] = max(MatrConf,[],1); 
            plot(indx,'*R');
            hold off 
            set(gca,'xtick',1:12);
            set(gca,'ytick',1:24);
            xticklabels({'Utente 1','Utente 2','Utente 3', 'Utente 4', 'Utente 5', 'Utente 6', 'Utente 7', 'Utente 8', 'Utente 9', 'Utente 10', 'Utente 11', 'Utente 12'});
            yticklabels({'Ergodico Parlato M', 'Ergodico Parlato F', 'Parlante 1','Parlante 2','Parlante 3', 'Parlante 4', 'Parlante 5', 'Parlante 6', 'Parlante 7', 'Parlante 8', 'Parlante 9', 'Parlante 10', 'Ergodico Cantato M', 'Ergodico Cantato F', 'Cantante 1','Cantante 2','Cantante 3', 'Cantante 4', 'Cantante 5', 'Cantante 6', 'Cantante 7', 'Cantante 8', 'Cantante 9', 'Cantante 10'});   
            xtickangle(45)
            ytickangle(45)
            xlabel('Input')
            ylabel('Modello')
            colormap winter

            figure
            bar(allmaxscores)
            set(gca,'xtick',1:12);
            xticklabels({'Utente 1','Utente 2','Utente 3', 'Utente 4', 'Utente 5', 'Utente 6', 'Utente 7', 'Utente 8', 'Utente 9', 'Utente 10', 'Utente 11', 'Utente 12'});
            xtickangle(45)
            xlabel('Input')
            ylabel('Scarto')
            grid on

            fprintf('Scarto medio: %f\n',mean(allmaxscores))
end;
        
