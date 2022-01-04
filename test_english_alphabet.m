%
% όπως και το test.m αλλά για το ερώτημα 3)
%
function test_english_alphabet()
    % ----------------------------------------
    % ανάγνωση αρχείου & δημιουργία dictionary
    % ----------------------------------------
    [dict, data] = huffmandict('./cvxopt.txt');
    disp('Περιεχόμενα του αρχείου:');
    disp(data);

    % -----------------------------------------
    % αντικατάσταση των πιθανοτήτων που βρήκαμε
    % με αυτές της αγγλικής γλώσσας
    % -----------------------------------------
    english_frequencies = read_frequencies_file();      % παίρνουμε τις πιθανότητες απ'το αρχείο frequencies.txt
    english_frequencies_symbols_matrix = cell2mat(english_frequencies(:, 1));
    
    % για κάθε χαρακτήρα του dict(:,1), βάζουμε την πιθανότητα που
    % διαβάσαμε απ'το english_frequencies
    [m, ~] = size(dict);
    symbols = dict(:, 1);
    k = 1;
    for i = 1:m
        % χαρακτήρας απ'το dict
        c = symbols{i};

        % η θέση του στο english_frequences
        k = find(english_frequencies_symbols_matrix == c);

        % η νέα πιθανότητα
        dict(i, 3) = english_frequencies(k, 2);

        % debugging
        % disp(dict{i, 1});
        % disp(dict{i, 3});
    end

    % ---------------------------
    % 2) β) Yπολογισμός εντροπίας, μέσου μήκους κώδικα, απόδοσης
    % ---------------------------

    A = dict(:,1);  % συμβολα => αλφάβητο
    p = dict(:,3);  % πιθανότητες
    c = dict(:, 2); % κώδικες
    H = 0;          % εντροπία
    L = 0;          % μέσο μήκος κώδικα
    n = 0;          % απόδοση

    [m, ~] = size(A);
    for i=1:m
        H = H + p{i} * log2(1 ./ p{i});
    end
    disp('Η(Φ) = ');
    disp(H);

    for i=1:m
        % μήκος του i-οστού κώδικα
        li = length(c{i});
        L = L + p{i} * li;
    end
    disp('L = ');
    disp(L);

    Lmin = H;   % η Lmin = H(Φ)
    n = Lmin ./ L;
    disp('Απόδοση = ');
    disp(n);

    % --------------------------------------------------
    % δημιουργία κωδικοποιημένης μορφής των περιεχομένων
    % --------------------------------------------------
    encoded_data = huffmanenco(dict, data);
    disp('Μετά την κωδικοποίηση:');
    disp(encoded_data);

    % ---------------
    % αποκωδικοποίηση
    % ---------------
    decoded_data = huffmandeco(dict, encoded_data);
    disp('Αποκωδικοποιημένο κείμενο:');
    disp(decoded_data);
end

%
% Επιστρέφει πίνακα όπου 1η στήλη: σύμβολο και 2η: πιθανότητα
%
function [frequencies] = read_frequencies_file()
    frequencies = {};

    f = fopen('frequencies.txt');

    % τωρινή γραμμή στο frequencies πίνακα
    i = 1;

    % διαβάζουμε γραμμή-γραμμή
    line = fgetl(f);
    while ischar(line)
        % διαβάζουμε την πληροφορία της γραμμής
        c = line(1);                                            % 1η θέση είναι πάντα ο χαρακτήρας
        number_str = extractBetween(line, 2, length(line));     % από τη 2η έως το τέρμα της γραμμής έχουμε τον 5-ψήφιο αριθμό
        number = str2double(number_str);                        % το string που αναπαριστά αριθμό, το κάνουμε convert σε αριθμητική μορφή

        frequencies{i, 1} = c;
        frequencies{i, 2} = number;

% debugging
% disp(frequencies{i,1});
% disp(frequencies{i,2});

        % διαβάζουμε επόμενη γραμμή
        line = fgetl(f);

        % αύξηση της γραμμής
        i = i + 1;
    end
    fclose(f);
end