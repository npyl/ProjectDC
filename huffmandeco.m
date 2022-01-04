function [decoded_data] = huffmandeco(dict, encoded_data)
    decoded_data = [];
    current_str = [];

    % αρχικά, παίρνουμε όλους τους πιθανούς κώδικες
    possible_codes = dict(:, 2);
    new_possible_codes = {};

    for i=1:length(encoded_data)
        % Παίρνουμε τον επόμενο χαρακτήρα στη σειρά
        c = encoded_data(i);
        % σταδιακά δημιουργούμε τον κωδικό που διαβάζουμε
        current_str = [current_str c];

        % θα αναζητήσουμε κωδικούς που θα ξεκινούν με το current_str
        % καθένα που βρίσκουμε και θεωρούμε πιθανό σωστό, το προσθέτουμε
        % στο new_possible_codes
        [m, ~] = size(possible_codes);
        for j = 1:m
            code = possible_codes{j};

            if ismember(current_str, code)
                new_possible_codes(j, :) = code;
            end
        end

        % έχουμε βρει τον κωδικό που ψάχναμε?
        [k, ~] = size(new_possible_codes);
        if k == 1
            decoded_data = [decoded_data new_possible_codes(1)]; 
        else
            % δεν βρήκαμε ακόμα αυτόν που ψάχναμε, όμως ας μικρύνουμε το
            % πλήθος των κωδικών που πρέπει να τσεκάρουμε
            possible_codes = new_possible_codes;
        end
    end
end