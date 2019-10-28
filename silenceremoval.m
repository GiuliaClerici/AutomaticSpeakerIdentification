function [no_silence_sig] = silenceremoval(x, fsize, valTres)
% funzione da controllare 
       
    x = mean(x,2);
    xb = buffer(x,fsize,fsize/2); % framing con overlap del 50%
    window = hamming(fsize); % finestratura di hamming
    xb = bsxfun(@times,xb,window); % applico la finestratura di hamming    
        
%     [Nframe, ~ ] = size(xb);
%     signPresente = ones(Nframe);
%     for i=1:Nframe 
%         rmsframe = rms(xb(i)); % RMS per ogni frame 
%         if rmsframe < valTres % impone soglia dB al di sotto di cui il segnale viene scartato -> valTres
%             signPresente(i) = 0; 
%         end;
%     end; 

    signPresente = rms(xb) > valTres;
    yb = xb(:,signPresente);
    % sign = ones(Nframe);
%     sign = bsxfun(@times,xb,signPresente); 
    f_len = fsize * ((size(yb,2) + 1) / 2);
    no_silence_sig = zeros(f_len,1);  
    
    odd = yb(:,1:2:end);
    l_odd = numel(odd);
    even = yb(:,2:2:end);
    l_even = numel(even);
    no_silence_sig(1:l_odd) = odd(:);
    no_silence_sig(1+fsize/2:fsize/2+l_even) = no_silence_sig(1+fsize/2:fsize/2+l_even)+even(:);
     
end