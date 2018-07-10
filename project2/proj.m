function projected_img = proj(img, flen)
    [row, col, channel] = size(img);
    projected_img = zeros(row, col, 3, 'uint8');
    for y = 1:row
        for x = 1:col
            tmpx = x - col/2;
            tmpy = y - row/2;
            theta = atan(tmpx/flen);
            h = tmpy / sqrt(tmpx^2 + flen^2);
            newx = round(flen * theta + col/2);
            newy = round(flen * h + row/2);
            projected_img(newy, newx, :) = img(y, x, :);
        end
    end
end