function transformation = do_match(match, ord_i, ord_j)
	% Solve translation matrix M
    % x_j = x_i * c + a
	n = size(match, 1);
	A = zeros(n+1, 2);
	b = zeros(n+1, 1);

	for i = 1:n
		% x_i
		A(i, 1) = 1;
		A(i, 2) = ord_i(match(i, 1), 1);	
        
        % x_j
		b(i, 1) = ord_j(match(i, 2), 1);
    end
    % for c
	A(n+1, 2) = 1;
	b(n+1, 1) = 1;

	% Solve translation
	transformation = round(A\b);
end