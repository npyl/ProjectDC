function [decoded_data] = huffmandeco(dict, encoded_data)
    decoded_data = [];
    current_str = [];

    % αρχικά, παίρνουμε όλους τους πιθανούς κώδικες
    possible_codes = dict(:, 2);
    new_possible_codes = {};

    for i=1:length(encoded_data)
        c = encoded_data(i);
        current_str = [current_str c];

        [m, ~] = size(possible_codes);
        for j = 1:m
            code = possible_codes{j};

            if ismember(current_str, code)
                new_possible_codes(j, :) = code;
            end
        end

        [k, ~] = size(new_possible_codes);
        if k == 1
            decoded_data = [decoded_data new_possible_codes(1)]; 
        else
            possible_codes = new_possible_codes;
        end
    end
end