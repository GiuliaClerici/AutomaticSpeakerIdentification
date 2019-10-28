function[indirizzoCartella, filenameErgodicoM, filenameErgodicoF, filenameDB] = selezioneParametri(segnale, fase, step)
    if fase == 1 % se sono alla fase di learning
        if segnale == 'parlato' % se il segnale è il parlato
            filenameErgodicoM = 'C:\Users\Giulia\Documents\MATLAB\Samples\RegistrazioniTesi\Parlato\SenzaSilenzio\Learning\ergodicoParlatoM.wav';
            filenameErgodicoF = 'C:\Users\Giulia\Documents\MATLAB\Samples\RegistrazioniTesi\Parlato\SenzaSilenzio\Learning\ergodicoParlatoF.wav';
            filenameDB = 'databaseGMM.mat';
            if step == 0 % se ho bisogno dei file con ancora il silenzio incorporato
                indirizzoCartella = 'C:\Users\Giulia\Documents\MATLAB\Samples\RegistrazioniTesi\Parlato\Learning';
            else  % se voglio i file senza silenzio
                indirizzoCartella = 'C:\Users\Giulia\Documents\MATLAB\Samples\RegistrazioniTesi\Parlato\SenzaSilenzio\Learning';
            end;
        else % se il segnale è cantato 
            filenameErgodicoM = 'C:\Users\Giulia\Documents\MATLAB\Samples\RegistrazioniTesi\Cantato\SenzaSilenzio\Learning\ergodicoCantatoM.wav';
            filenameErgodicoF = 'C:\Users\Giulia\Documents\MATLAB\Samples\RegistrazioniTesi\Cantato\SenzaSilenzio\Learning\ergodicoCantatoF.wav';
            filenameDB = 'databaseGMM.mat'; % o 'databaseGMMcantato.mat'
            if step == 0 % se voglio i file con ancora il silenzio
                indirizzoCartella = 'C:\Users\Giulia\Documents\MATLAB\Samples\RegistrazioniTesi\Cantato\Learning';
            else % se voglio i file a cui ho tolto il silenzio
                indirizzoCartella = 'C:\Users\Giulia\Documents\MATLAB\Samples\RegistrazioniTesi\Cantato\SenzaSilenzio\Learning';
            end; 
        end;
    else % se sono alla fase di matching
        if segnale == 'parlato' % se ho a che fare con il parlato
            filenameErgodicoM = 'C:\Users\Giulia\Documents\MATLAB\Samples\RegistrazioniTesi\Parlato\SenzaSilenzio\Learning\ergodicoParlatoM.wav';
            filenameErgodicoF = 'C:\Users\Giulia\Documents\MATLAB\Samples\RegistrazioniTesi\Parlato\SenzaSilenzio\Learning\ergodicoParlatoF.wav';
            filenameDB = 'databaseGMM.mat';
            if step == 0 % se mi servono i file da cui togliere il silenzio
                indirizzoCartella = 'C:\Users\Giulia\Documents\MATLAB\Samples\RegistrazioniTesi\Parlato\Test';
            else % se mi servono i file da cui ho tolto il silenzio
                indirizzoCartella = 'C:\Users\Giulia\Documents\MATLAB\Samples\RegistrazioniTesi\Parlato\SenzaSilenzio\Test';
            end;
        else % se il segnale è cantato
            filenameErgodicoM = 'C:\Users\Giulia\Documents\MATLAB\Samples\RegistrazioniTesi\Cantato\SenzaSilenzio\Learning\ergodicoCantatoM.wav';
            filenameErgodicoF = 'C:\Users\Giulia\Documents\MATLAB\Samples\RegistrazioniTesi\Cantato\SenzaSilenzio\Learning\ergodicoCantatoF.wav';
            filenameDB = 'databaseGMM.mat'; % o 'databaseGMMcantato.mat'
            if step == 0 % se ho bisogno dei file da cui togliere il silenzio
                indirizzoCartella = 'C:\Users\Giulia\Documents\MATLAB\Samples\RegistrazioniTesi\Cantato\Test';
            else % se mi servono i file da cui ho già tolto il silenzio
                indirizzoCartella = 'C:\Users\Giulia\Documents\MATLAB\Samples\RegistrazioniTesi\Cantato\SenzaSilenzio\Test';
            end;
        end;
    end;
end