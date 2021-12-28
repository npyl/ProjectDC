function [dict, pos] = huffmandict(file)
    dict = [];
    pos = [];

    % φορτώνουμε το αρχείο στη μνήμη => όλοι οι χαρακτήρες βρίσκονται σε
    % μία σειρά
    data = fileread(file);

    % προσθέτουμε έναν-έναν χαρακτήρα από τα data στο dict χωρίς
    % επαναλήψεις
    for i = 1:length(data)
        exists = 0;
        times = 0;
        c = data(i);

        % βρίσκουμε εάν ο χαρακτήρας υπάρχει ήδη στο dict
        for k = 1:length(dict)
            if c == dict(k)
                exists = 1;
                break;
            end
        end

        % εάν όχι, πρέπει να τον προσθέσουμε υπολογίζοντας ταυτόχρονα την
        % πιθανότητα εμφάνισής του
        if ~exists
            % προσθέτουμε το νέο στοιχείο
            dict = [dict data(i)];

            % ας βρούμε πόσες φορές εμφανίζεται
            for j = (i + 1):length(data)
                if c == data(j)
                    times = times + 1;
                end
            end

            % καταγράφουμε την πιθανότητα αυτού του συμβόλου
            p = times / length(data);
            pos = [pos p];
        end
    end
end