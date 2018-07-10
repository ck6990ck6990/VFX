function hdr_img = cal_E(img, g, ln_t, w)
    [row, col, channel, num] = size(img);
    ln_E = zeros(row, col, 3);
    for i = 1 : channel
        for r = 1 : row
            for c = 1 : col
                total_E = 0;
                total_w = 0;
                for n = 1 : num
                    Zij = img(r, c, i, n) + 1;
                    tmp = w(Zij) * (g(Zij) - ln_t(n));
                    total_E  = total_E + tmp;
                    total_w = total_w + w(Zij);
                end
                ln_E(r, c, i) = total_E / total_w;
            end
        end
    end
    hdr_img = exp(ln_E);
    
    % remove NAN or INF
    index = find(isnan(hdr_img) | isinf(hdr_img));
    hdr_img(index) = 0;

end