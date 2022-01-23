function [decoded_data] = huffmandeco(dict, encoded_data)
    decoded_data = [];
    current_str = '';
    
    % αρχικά, παίρνουμε όλους τους πιθανούς κώδικες
    possible_codes = dict(:, 2);
    new_possible_codes = {};

    for i=1:length(encoded_data)
        c = encoded_data(i);
        current_str = strcat(current_str, c);

        % βάζουμε όλα τα codes που κάνουν match στο new_possible_codes που
        % θέλουμε ναναι < possible_codes
        [m, ~] = size(possible_codes);
        for j = 1:m
            code = possible_codes{j};

            if contains(code, current_str) == 1
                new_possible_codes{end + 1, 1} = code;
            end
        end

        [k, ~] = size(new_possible_codes);
        [dict_rows, ~] = size(dict);
        % το να έχουμε k=1 σημαίνει πως έχουμε βρει το μοναδικό code που
        % θέλουμε
        if k == 1
            % index of code in dict
            l = 1;

            % find index of code in dict by searching line-by-line
            for idx = 1:dict_rows
                if strcmp(dict{idx, 2}, current_str) == 1
                    l = idx;
                    break;
                end
            end

            % add to decoded_data
            decoded_data = strcat(decoded_data, dict{l, 1});

            % refresh variables
            possible_codes = dict(:,2);
            new_possible_codes = {};
            current_str = '';
        else
            possible_codes = new_possible_codes;
            new_possible_codes = {};
        end
    end
end