function [encoded_data] = huffmanenco(dict, data)
    encoded_data = [];
    
    for i = 1:length(data)
        % παίρνουμε τον i-οστό χαρακτήρα
        c = data(i);
        
        % παίρνουμε την 1η στήλη για εύκολη πρόσβαση
        symbols = cell2mat(dict(:, 1));
        % αναζήτηση για το index του c στο symbols
        j = find(symbols == c);
        % παίρνουμε τη στήλη με τους κωδικούς
        codes = dict(:, 2);
        % παίρνουμε τον κατάλληλο κωδικό
        code = codes{j};
        % παίρνουμε τον κωδικό σε πίνακα από chars (string)
        str = num2str(code);

        encoded_data = [encoded_data str];
    end

% Debugging
%    disp('Data from file:');
%    disp(data);
%    disp('Encoded data:');
%    disp(char(encoded_data));
end