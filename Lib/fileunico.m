function [sign] = fileunico(x, sign) 
    if isempty(sign) 
        sign = x;
    else 
        sign = vertcat(sign, x);  
    end;

    
%     if filename(end-4) == 'M'
%         if isempty(signM)
%             signM = x;
%         else 
%             signM = vertcat(signM, x);
%         end;
%     else 
%         if isempty(signF)
%             signF = x;
%         else 
%             signF = vertcat(signF, x);
%         end;
%     end;
end
