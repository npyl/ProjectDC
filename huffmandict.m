function [dict, pos] = huffmandict(file)
% H συνάρτηση φορτώνει το αρχείο file στη μνήμη και επιστρέφει τις μεταβλητές dict και pos
% η 1η, περιέχει τον κάθε χαρακτήρα (δηλ. σύμβολο-πηγής) μία μόνο φορά και
% η 2η, περιέχει την πιθανότητα εμφάνισης κάθενος από αυτά τα σύμβολα, στις
%   αντίστοιχες θέσεις: συνεπώς, εάν έχει καταχωρηθεί το σύμβολο w στη θέση 1
%   του dict, τότε η αντίστοιχη πιθανότητά του θα είναι στην ίδια θέση (1),
%   στη μεταβλητή pos.
    symbols = [];
    pos = [];

    % φορτώνουμε το αρχείο στη μνήμη => όλοι οι χαρακτήρες βρίσκονται σε
    % μία σειρά
    data = fileread(file);

    % προσθέτουμε έναν-έναν χαρακτήρα από τα data στο symbols χωρίς
    % επαναλήψεις
    for i = 1:length(data)
        exists = 0;
        times = 0;
        c = data(i);

        % βρίσκουμε εάν ο χαρακτήρας υπάρχει ήδη στο symbols
        for k = 1:length(symbols)
            if c == symbols(k)
                exists = 1;
                break;
            end
        end

        % εάν όχι, πρέπει να τον προσθέσουμε υπολογίζοντας ταυτόχρονα την
        % πιθανότητα εμφάνισής του
        if ~exists
            % προσθέτουμε το νέο στοιχείο
            symbols = [symbols data(i)];

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

    % δημιουργούμε την πρώτη στήλη
    for i = 1:length(symbols)
        dict(i,1) = struct('str', symbols(i), 'p', pos(i));
    end

    %
    % αλγόριθμος δημιουργίας dict
    %
    reached_root = 0;
    height = length(symbols);           % ύψος στήλης
    col = 1;                            % δείκτης της τωρινής στήλης
    
    % σορτάρουμε τη στήλη 1
    column = dict(:,1)';
    vector = huffmansort(column);
    dict(:,1) = vector';

    while ~reached_root
        % συγχώνευση
        p1 = dict(height, col).p;
        p2 = dict(height - 1, col).p;
        sum = p1 + p2;

        % δημιουργούμε το string της συγχώνευσης (το string είναι της μορφής α0b1 ώστε να διακρίνεται το αριστερό από το δεξί)
        str = dict(height, col).str + '0' + dict(height, col).str + '1';

        % εύρεση της γραμμής (k) που πρέπει να τοποθετήσουμε το συγχωνευμένο αντικείμενο
        k = 1;
        while sum < dict(k, col).p
            k = k + 1;
        end

        % προσθέτουμε νέα στήλη
        for i = 1:k-1
            dict(i, col + 1) = dict(i, col);
        end
        dict(k, col + 1) = struct('str', str, 'p', sum);
        for i = k+1:height
            dict(i, col + 1) = dict(i, col);
        end

        % πάμε στην επόμενη στήλη
        col = col + 1;

        % μείναμε με μόνο 1 στοιχείο?
        if k == 2
            reached_root = 1;
        end
    end
end