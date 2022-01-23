function [encoded_data] = huffmanenco(dict, data)
    encoded_data = [];

    % Για κάθε χαρακτήρα c από το input της πηγής, βρίσκω τον κωδικό που του
    % αντιστοιχεί (code) και δημιουργώ array από strings που λέγεται encoded data.
    for i = 1:length(data)
        c = data(i);
        
        symbols = cell2mat(dict(:, 1));
        j = find(symbols == c);
        codes = dict(:, 2);
        code = codes{j};
        str = num2str(code);

        encoded_data = [encoded_data str];
    end
end