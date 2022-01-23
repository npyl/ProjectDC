function test()
    % ----------------------------------------
    % ανάγνωση αρχείου & δημιουργία dictionary
    % ----------------------------------------
    [dict, data] = huffmandict('./cvxopt.txt');
    disp('Δεδομένα πηγής:');
    disp(data);

    % 2)

    % F - alphabet
    % p - posibilities   c - respective codes
    F = dict(:,1);
    p = dict(:,3);
    c = dict(:, 2);
    
    % H - entropy 
    % L - μέσο-μήκος κώδικα 
    % n - απόδοση
    H = 0;
    L = 0;
    n = 0;
    [m, ~] = size(F);
    for i=1:m
        H = H + p{i} * log2(1 ./ p{i});
    end
    for i=1:m
        li = length(c{i});
        L = L + p{i} * li;
    end
    Lmin = H;
    n = Lmin ./ L;
    
    disp(sprintf('L = %f H(F) = %f n = %f', L, H, n));

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
    disp('Μετά την απο-κωδικοποίηση:');
    disp(decoded_data);

    %
    % Ερώτημα 5)
    %

    % convert string to numbers
    num_encoded_data = 0;
    for i = 1:length(encoded_data)
        c = encoded_data(i);
        num_encoded_data = [num_encoded_data str2num(c)];
    end

    y = bsc(num_encoded_data);
    [~, p] = biterr(num_encoded_data, y);

    % στρογγυλοποίηση στο 2ο δεκαδικό ψηφίο
    p = round(p, 2);

    Hb = (-1) * p * log2(p) - (1 - p) * log2(1 - p);
    C = 1 - Hb;

    disp(sprintf('Χωρητικότητα Καναλιού: %f', C));
end