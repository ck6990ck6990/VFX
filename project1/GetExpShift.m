function [shift_ret] = GetExpShift(gray_img1, gray_img2, shift_bits, shift_ret)
    cur_shift = zeros(1, 2);
    if shift_bits > 0
        sml_img1 = imresize(gray_img1, 0.5);
        sml_img2 = imresize(gray_img2, 0.5);
        GetExpShift(sml_img1, sml_img2, shift_bits-1, cur_shift);
        cur_shift(1) = cur_shift(1) * 2;
        cur_shift(2) = cur_shift(2) * 2;
    else
        cur_shift(1) = 0;
        cur_shift(2) = 0;
    end
    
    [tb1, eb1] = ComputeBitmaps(gray_img1);
    [tb2, eb2] = ComputeBitmaps(gray_img2);
    h = size(gray_img1, 1);
    w = size(gray_img1, 2);
    min_err = h * w;
    for i = -1 : 1 : 1
        for j = -1 : 1 : 1
            xs = cur_shift(1) + i;
            ys = cur_shift(2) + j;
            shifted_tb2 = imtranslate(tb2, [xs, ys], 'FillValues', 255);
            shifted_eb2 = imtranslate(eb2, [xs, ys], 'FillValues', 255);
            [diff_b] = xor(tb1, shifted_tb2);
            [diff_b] = and(diff_b, eb1);
            [diff_b] = and(diff_b, shifted_eb2);
            err = sum(diff_b);
            if err < min_err
                shift(1) = xs;
                shift(2) = ys;
                min_err = err;
            end
        end
    end
end