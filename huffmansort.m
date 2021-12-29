function [newvector] = huffmansort(vector)
% ταξινομεί κατά φθίνουσα σειρά
    for i = 1:length(vector)
        max = vector(i).p;
        
        for j = 1:length(vector)
            cur = vector(j).p;

            if max < cur
                tmp = vector(i);
                vector(i) = vector(j);
                vector(j) = tmp;
            end
        end
    end

% debugging
%    for i = 1:length(vector)
%        disp(vector(i));
%    end
    
    newvector = vector;
end