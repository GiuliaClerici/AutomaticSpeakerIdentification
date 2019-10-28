function[GMM] = calcLambda(coeff, M) 
% calcolo le componenti di lambda tramite l'algoritmo di
% Expectation_Maximization (EM), tramite la funzione fitgmdist
options = statset('MaxIter',300);
GMM = fitgmdist (coeff, M, 'CovarianceType', 'diagonal','Start','randSample','Options',options); % stimo i parametri di lambda tramite l'algoritmo EM
% devo mettere limite su valore della varianza!! 

end