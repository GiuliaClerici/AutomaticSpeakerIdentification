function [name, address] = salvaSilenziati(x, segnale, filename, fase)
    address = 0; 
    if segnale == 'parlato'
        if fase == 1 
            address = 'C:\Users\Giulia\Documents\MATLAB\Samples\RegistrazioniTesi\Parlato\SenzaSilenzio\Learning';
        else 
            address = 'C:\Users\Giulia\Documents\MATLAB\Samples\RegistrazioniTesi\Parlato\SenzaSilenzio\Test';
        end;
    else 
        if fase == 1 
            address = 'C:\Users\Giulia\Documents\MATLAB\Samples\RegistrazioniTesi\Cantato\SenzaSilenzio\Learning';
        else 
            address = 'C:\Users\Giulia\Documents\MATLAB\Samples\RegistrazioniTesi\Cantato\SenzaSilenzio\Test';
        end;
    end;  
    len = strlength(filename); 
    slashes = 0; 
    ind = 0; 
    for i=1:len 
        if filename(i) == '\'
            slashes = slashes + 1; 
        end; 
        if slashes == 9
            ind = i;
            slashes = slashes + 1; 
        end;
    end; 
    filename = filename(ind+1:end);
    name = strcat(address,'\',filename);
    audiowrite(name, x, 44100);
end