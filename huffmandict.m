function [dict] = huffmandict(file)
    % φορτώνουμε το αρχείο στη μνήμη => όλοι οι χαρακτήρες βρίσκονται σε
    % μία σειρά
    data = fileread(file);
    
    % αρχικοποιούμε με έναν μόνο χαρακτήρα από τα data
    dict(1) = data(1);

    % προσθέτουμε έναν-έναν χαρακτήρα από τα data στο dict χωρίς
    % επαναλήψεις
    for i = 1:length(data)
        found = 0;
        c = data(i);
        for j = 1:length(dict)
            if c == dict(j)
                found = 1;
            end
        end

        if ~found
            % προσθέτουμε το νέο στοιχείο
            dict = [dict data(i)];
        end
    end

    % ας δούμε το array μετά το "καθάρισμα"
    disp(dict);
end

