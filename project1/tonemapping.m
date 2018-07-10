function rgb = tonemapping(hdr_img, alpha)
    delta = 0.00000001;
    l_white = 1e20;
    [row, col, channel] = size(hdr_img);
    lum_d = zeros(row, col);
    lum_w = 0.27 * hdr_img(:,:,1) + 0.67 * hdr_img(:,:,2) + 0.06 * hdr_img(:,:,3);
    tmp_sum = 0;
    for i = 1 : row
        for j = 1 : col
            tmp_sum = tmp_sum + log(lum_w(i, j) + delta);
        end
    end
    lum_w_bar = exp(tmp_sum/(row*col));
    lum = lum_w * alpha / lum_w_bar;
    
    for i = 1 : row
        for j = 1 : col
            lum_d(i, j) = lum(i, j) * (1 + lum(i, j)/l_white/l_white) / (1 + lum(i, j));
        end
    end
    hsv = rgb2hsv(hdr_img);
    hsv(:,:,3) = lum_d;
    rgb = hsv2rgb(hsv);
end