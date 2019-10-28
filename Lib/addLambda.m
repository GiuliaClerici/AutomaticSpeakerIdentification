function[GMMdb]=addLambda(GMMdb, filenameDB, coeff, M, filename) 
% funzione tramite cui calcolo la lambda del nuovo parlante e la inserisco
% in lambdaDB, ovvero nella variabile contenuta nel file databadelambda.m 
    %size(GMMdb,1)+1 
    exist=0;
    j=0;
    j=size(GMMdb,1);
    if not(cellfun('isempty',GMMdb)) % se un cellarray non è vuoto
        for i=1:j
            if strcmpi(GMMdb{i,1}, filename)
                exist=1;        % so che non si fa ma non mi vengono altre idee 
            end;
        end;
    end;
    if exist==0 %size(GMMdb,1)<n % è la prima volta che calcolo lambda per quel parlante 
       if cellfun('isempty',GMMdb)
            GMMdb{j,1} = filename;                
            GMMdb{j,2} = calcLambda(coeff, M); 
            save(filenameDB,'GMMdb'); 
       else
            GMMdb{j+1,1} = filename;                 % GMMdb(n,1)= ID del parlante (che sarà filename) % funziona tranne per il primo
            GMMdb{j+1,2} = calcLambda(coeff, M); 
            save(filenameDB,'GMMdb'); 
        end;  
    end;
end 