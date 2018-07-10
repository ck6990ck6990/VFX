function [tb, eb] = ComputeBitmaps(gray_img)
    h = size(gray_img, 1);
    w = size(gray_img, 2);
    tb = zeros(h, w);
    eb = zeros(h, w);
    threshold = median(reshape(gray_img, [], 1));
    for i = 1 : h
        for j = 1 : w
            % MTB
            if gray_img(i, j) <= threshold
                tb(i, j) = 0;
            else
                tb(i, j) = 1;
            end
            % exclusion bitmap
            if gray_img(i, j) > threshold + 4
                eb(i, j) = 1;
            elseif gray_img(i, j) < threshold - 4
                eb(i, j) = 1;
            else
                eb(i, j) = 0;
            end
        end
    end

end