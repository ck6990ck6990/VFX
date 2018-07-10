function match = ransac(des1, des2, ord1, ord2)	
	n = 3;
	p = 0.5;
	P = 0.999;
	k = ceil(log(1 - P) / log(1 - p ^ n));
	threshold = 10;
	match_ord = [];
    
	for i = 1 : size(des1, 1)
        min1 = 9999999;
        min2 = 9999999;
        min1_idx = i;
        min2_idx = i;

		% distance between feature vectors
		for j = 1 : size(des2, 1)
			dist = sqrt(sum((des1(i, :) - des2(j, :)) .^ 2));
			% Find 2 closest features
            if (dist < min1)
                min2 = min1;
                min1 = dist;
				min1_idx = j;
                min2_idx = min1_idx;
            elseif (dist < min2)
				min2 = dist;
                min2_idx = j;
            end
        end
        % accept if distance ratio < 0.8
        if ((min1 / min2) < 0.8)
            match_idx = [i, min1_idx];
            match_ord = [match_ord; match_idx];
        end
    end
    
    N = size(match_ord, 1);
    
    match = [];
    if N <= n
    	match = match_ord;
    	return;
    end

	for times = 1 : k
		% Draw n samples randomly
		rdm = randperm(N);
		sample_index = rdm(1:n);
	    other_index = rdm(n+1: N);

	    match_sample = match_ord(sample_index, :);
	    match_other = match_ord(other_index, :);
	    sample_i = ord1(match_sample(:, 1), :);
	    sample_j = ord2(match_sample(:, 2), :);
	    else_i = ord1(match_other(:, 1), :);
	    else_j = ord2(match_other(:, 2), :);

		% find theta
		match_tmp = [];
        pos_dis = sample_i - sample_j;
		theta = mean(pos_dis);
	    
		% other points:
		for i = 1:(N - n)
			% distance to the model
			d = (else_i(i, :) - else_j(i, :)) - theta;

			% inlier points
			if norm(d) < threshold
				match_tmp = [match_tmp; match_other(i, :)];
			end
		end

		if size(match_tmp, 1) > size(match, 1)
			match = match_tmp;
		end
    end 
end