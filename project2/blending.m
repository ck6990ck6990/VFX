function output_img = blending(combined_img, add_img, transform)
    % alpha blending
	[comb_row, comb_col, channel] = size(combined_img);
	[row, col, channel] = size(add_img);
    shift_x = abs(transform(1));
	output_img = zeros(comb_row, comb_col+shift_x, channel, 'uint8');
    
    width = col-shift_x;
    alpha1 = [0:(1/width):1 ones(1, comb_col-width-1)];
    alpha2 = [ones(1, col-width-1) 1:(-1/width):0];

    % left side
    for i = 1:row
        for j = 1:col
            output_img(i, j, :) = add_img(i, j, :) * alpha2(j);
        end
    end
    %right side
    for i = 1:comb_row
        for j = 1:comb_col
            output_img(i, j+shift_x, :) = output_img(i, j+shift_x, :) + combined_img(i, j, :)*alpha1(j);
        end
    end
    imshow(output_img);
end